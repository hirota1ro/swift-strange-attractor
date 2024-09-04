import Foundation
import Cocoa

extension StrangeAttractor.Catalog {

    mutating func run() throws {
        guard let outputFile = outputFile else {
            print("Usage: Catalog -?")
            return
        }
        // make a list of items from array of filenames
        let items: [Item] = inputFiles.compactMap { Item.from(path: $0, xAxis: xAxis, yAxis: yAxis) }
        guard items.count > 0 else {
            print("no item")
            return
        }

        // make a catalog image
        let size = CGSize(width: 1024, height: 1024)
        let bitmap = Bitmap(size: size)
        let cgImg = bitmap.image { _ in
            draw(items: items, catalogSize: size, thumbSize: CGSize(width: 100, height: 100))
        }
        let image = NSImage(cgImage: cgImg, size: size)

        // save the catalog image to the output file
        guard let data = image.pngData else { fatalError("no data") }
        let fileURL = URL(fileURLWithPath: outputFile)
        try data.write(to: fileURL, options: .atomic)
        print("succeeded to write \(fileURL.path)")
    }

    private func draw(items: [Item], catalogSize: CGSize, thumbSize: CGSize) {
        // fill the background
        NSColor.white.setFill()
        CGRect(origin: .zero, size: catalogSize).fill()
        NSColor.black.setStroke()

        // obtain the range of bounding box from parameters
        let bbRAW = items.map { $0.point } .boundingBox
        let bb = bbRAW.floorCeil
        //print("bbRAW=\(bbRAW) bb=\(bb)")
        let xr = bb.minX ... bb.maxX
        let yr = bb.minY ... bb.maxY

        let tw = thumbSize.width/2
        let th = thumbSize.height/2

        let sxr = tw ... (catalogSize.width - tw)
        let syr = th ... (catalogSize.height - th)

        // draw scales on the x-axis
        if true {
            let sy = linearMapping(value: 0, from: yr, to: syr)
            let xstep = pow(10, floor(log10(bb.maxX - bb.minX))/10)
            for x in stride(from: floor(bb.minX/10)*10, to: ceil(bb.maxX/10)*10, by: xstep) {
                let sx = linearMapping(value: x, from: xr, to: sxr)
                // draw a scale
                let p0 = CGPoint(x:sx, y:0)
                let p1 = CGPoint(x:sx, y:catalogSize.height)
                let line = (x==0) ? NSBezierPath(arrowFrom: p0, to: p1, head:8) : NSBezierPath(lineFrom: p0, to: p1)
                line.lineWidth = (x==0) ? 0.4 : 0.1
                line.stroke()
                // draw label
                drawYTopXCenter(string: String(format: "%.1f", x), at: CGPoint(x: sx, y: sy))
            }
            drawRightTop(string: xAxis, at: CGPoint(x: catalogSize.width, y: sy))
        }
        // draw scales on the y-axis
        if true {
            let sx = linearMapping(value: 0, from: xr, to: sxr)
            let ystep = pow(10, floor(log10(bb.maxY - bb.minY))/10)
            for y in stride(from: floor(bb.minY/10)*10, to: ceil(bb.maxY/10)*10, by: ystep) {
                let sy = linearMapping(value: y, from: yr, to: syr)
                // draw a scale
                let p0 = CGPoint(x:0, y:sy)
                let p1 = CGPoint(x:catalogSize.width, y:sy)
                let line = (y==0) ? NSBezierPath(arrowFrom: p0, to: p1, head:8) : NSBezierPath(lineFrom: p0, to: p1)
                line.lineWidth = (y==0) ? 0.4 : 0.1
                line.stroke()
                // draw label
                drawXRightYCenter(string: String(format: "%.1f", y), at: CGPoint(x: sx, y: sy))
            }
            drawRightTop(string: yAxis, at: CGPoint(x: sx, y: catalogSize.height))
        }

        // draw thumbnail images
        for item in items {
            if let thumb = NSImage(contentsOfFile: item.path) {
                let x = linearMapping(value: item.point.x, from: xr, to: sxr)
                let y = linearMapping(value: item.point.y, from: yr, to: syr)
                thumb.draw(in: CGRect(origin: CGPoint(x: x, y: y) - CGPoint(x:tw, y:th), size: thumbSize))
            } else {
                print("not found \(item.path)")
            }
        }
    }

    private func drawXRightYCenter(string: String, at: CGPoint) {
        let size = string.size(withAttributes: nil)
        string.draw(at: at - CGPoint(x: size.width, y: size.height/2), withAttributes: nil)
    }
    private func drawYTopXCenter(string: String, at: CGPoint) {
        let size = string.size(withAttributes: nil)
        string.draw(at: at - CGPoint(x: size.width/2, y: size.height), withAttributes: nil)
    }
    private func drawRightTop(string: String, at: CGPoint) {
        let size = string.size(withAttributes: nil)
        string.draw(at: at - CGPoint(x: size.width, y: size.height), withAttributes: nil)
    }

    func linearMapping(value: CGFloat, from: ClosedRange<CGFloat>, to: ClosedRange<CGFloat>) -> CGFloat {
        let v = (value - from.lowerBound) / (from.upperBound - from.lowerBound)
        return v * (to.upperBound - to.lowerBound) + to.lowerBound
    }
}

extension StrangeAttractor.Catalog {
    struct Item {
        let path: String // file path name (e.g. "/path/to/Beadhead(a=0.1,b=0.2).png")
        let point: CGPoint // a pair of (x,y) value (e.g. (x=0.1, y=0.2))
    }
}

extension StrangeAttractor.Catalog.Item {

    /// extract values on the x and y axis from filename
    /// - Parameters:
    ///   - name: file path name (例 "/path/to/Bedhead(a=0.1,b=0.2).png")
    ///   - xAxis: parameter name on the x-axis(e.g. "a")
    ///   - yAxis: parameter name on the y-axis(e.g. "b")
    static func from(path: String, xAxis: String, yAxis: String) -> Self? {
        // split the path name to array of path components with the separator char '/'
        let components = path.split(separator: "/")
        let name = String(components.last!)

        // search '('
        guard let startIdx = name.firstIndex(of: "(") else { return nil }

        let beginIdx = name.index(after: startIdx)
        let sub = String(name[beginIdx...])
        // search ')'
        guard let lastIdx = sub.firstIndex(of: ")") else { return nil }

        let s = String(sub[..<lastIdx])
        //print("\(s)") // e.g. "a=-0.64,b=0.76"
        let pairs = s.split(separator: ",").map { String($0) }
        let kvs = pairs.map { pair -> (String,CGFloat) in
            let kv = pair.split(separator: "=")
            let key = String(kv[0])
            let k: Float = Float(String(kv[1])) ?? 0
            let value = CGFloat(k)
            return (key, value)
        }
        var dict: [String: CGFloat] = [:]
        kvs.forEach { (k,v) in
            dict[k] = v
        }
        let x = dict[xAxis] ?? 0
        let y = dict[yAxis] ?? 0
        let point = CGPoint(x:x, y:y)

        return Self(path: path, point: point)
    }
}

extension Array where Element == CGPoint {

    var boundingBox: CGRect {
        let xlist = self.map { $0.x }
        let ylist = self.map { $0.y }
        let xmin = xlist.reduce(1e+9) { Swift.min($0, $1) }
        let xmax = xlist.reduce(-1e+9) { Swift.max($0, $1) }
        let ymin = ylist.reduce(1e+9) { Swift.min($0, $1) }
        let ymax = ylist.reduce(-1e+9) { Swift.max($0, $1) }
        return CGRect(x: xmin, y: ymin, width: xmax - xmin, height: ymax - ymin)
    }
}

extension CGRect {

    var floorCeil: CGRect {
        let xmin = floor(minX)
        let ymin = floor(minY)
        let xmax = ceil(maxX)
        let ymax = ceil(maxY)
        return CGRect(x: xmin, y: ymin, width: xmax - xmin, height: ymax - ymin)
    }
}
