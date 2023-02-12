import Foundation
import Cocoa

extension StrangeAttractor.Image {

    var sizeOfImage: CGSize { return CGSize(width: width, height: height ?? width) }

    mutating func run() throws {
        let algorithm = SgArAlgorithm()
        let drivers = try SgArFile.read(from: inputFile)
        for driver in drivers {
            let image = try createImage(algorithm: algorithm, driver: driver)
            try save(image: image, toFileName: "\(driver)")
        }
    }

    func createImage(algorithm: SgArAlgorithm, driver: SgArDriver) throws -> NSImage {
        let visual = SgArVisual()
        try algorithm.draw(n: iterations, driver: driver, plotter: visual, progress: EmptyProgress())
        let renderer = renderer(visual: visual)
        var image = renderImage(algorithm: algorithm, driver: driver, renderer: renderer)
        if drawTitle {
            image = decorate(image: image, text: "\(driver)")
        }
        return image
    }

    func renderImage(algorithm: SgArAlgorithm, driver: SgArDriver, renderer: SgArRenderer) -> NSImage {
        let n = iterations * density * density
        let progress = MeasurementProgress(IndeterminableProgress())
        let image = renderer.image(n: n, algorithm: algorithm, driver: driver, progress: progress)
        if density > 1 {
            let resizedImg = image.resized(to: sizeOfImage)
            if gamma != 1 {
                if let gammaImg = resizedImg.gammaAdjusted(inputPower: gamma) {
                    return gammaImg
                }
            }
            return resizedImg
        } else {
            return image
        }
    }

    func renderer(visual: SgArVisual) -> SgArRenderer {
        let scale = visual.scaleToFit(size: sizeOfImage) * CGFloat(scaleFactor) * CGFloat(density)
        let size = sizeOfImage * CGFloat(density)
        let tr = visual.translation
        let screen: CGAffineTransform = .identity
          .translatedBy(x: size.width/2, y: size.height/2)
          .scaledBy(x: scale, y: scale)
          .translatedBy(x: tr.x, y: tr.y)
        let br: SgArBrightnessResolver = dark ? BlackBackBrightnessResolver() : WhiteBackBrightnessResolver()
        let colorResolver = VelAccResolver(v: visual.v, a: visual.a, b: br)
        var rdr = SgArRenderer(size: size, screen: screen, colorResolver: colorResolver)
        if transparent {
            rdr.backgroundColor = nil
        } else {
            if dark {
                rdr.backgroundColor = .black
            } else {
                rdr.backgroundColor = .white
            }
        }
        return rdr
    }

    func decorate(image: NSImage, text: String) -> NSImage {
        let size = image.size
        image.lockFocus()
        let textColor: NSColor = .white
        let attr: [NSAttributedString.Key: Any] = [ .foregroundColor: textColor ]
        text.draw(at: CGPoint(x: 4, y: size.height-14), withAttributes: attr)
        image.unlockFocus()
        return image
    }

    func save(image: NSImage, toFileName name: String) throws {
        guard let data = image.pngData else { throw SgArRuntimeError.noPNGData }
        let fpresolver = FilePathResolver(path: outputFile)
        let fileURL = fpresolver.resolve(suffix: name)
        try data.write(to: fileURL, options: .atomic)
        print("succeeded to write \(fileURL.path)")
    }
}

struct VelAccResolver {
    let v: Span
    let a: Span
    let b: SgArBrightnessResolver
}
extension VelAccResolver: SgArColorResolver {
    func resolve(point: CGPoint, velocity: CGPoint, acceleration: CGPoint) -> NSColor {
        let vel = velocity.norm
        let acc = acceleration.norm
        let hue = v.normalized(vel)
        let sat = easeOutQuad(a.normalized(acc))
        let bri = b.resolve(hue: hue, saturation: sat)
        return NSColor(hue: hue, saturation: sat, brightness: bri, alpha: 1)
    }

    func easeOutQuad(_ x: CGFloat) -> CGFloat {
	return 1 - (1 - x) * (1 - x)
    }
}

protocol SgArBrightnessResolver {
    func resolve(hue: CGFloat, saturation sat: CGFloat) -> CGFloat
}
struct WhiteBackBrightnessResolver: SgArBrightnessResolver {
    func resolve(hue: CGFloat, saturation sat: CGFloat) -> CGFloat { return sat }
}
struct BlackBackBrightnessResolver: SgArBrightnessResolver {
    func resolve(hue: CGFloat, saturation sat: CGFloat) -> CGFloat { return 1 }
}
