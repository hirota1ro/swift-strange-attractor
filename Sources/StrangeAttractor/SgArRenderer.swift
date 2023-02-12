import Cocoa

struct SgArRenderer {
    let size: CGSize
    let screen: CGAffineTransform
    let colorResolver: SgArColorResolver
    var backgroundColor: NSColor? = .black
}

extension SgArRenderer {
    func image(n: Int, algorithm: SgArAlgorithm, driver: SgArDriver, progress: SgArProgress) -> NSImage {
        let image = NSImage(size: size)
        image.lockFocus()

        if let bgColor = backgroundColor {
            bgColor.setFill()
            CGRect(origin: .zero, size: size).fill()
        }
        do {
            try algorithm.draw(n: n, driver: driver, plotter: self, progress: progress)
        } catch {
            print("\(error)")
        }
        image.unlockFocus()
        return image
    }
}

extension SgArRenderer: SgArPlotter {
    static let dot = CGSize(width: 1, height: 1)

    func plot(point p: CGPoint, velocity v: CGPoint, acceleration a: CGPoint) {
        let color = colorResolver.resolve(point:p, velocity:v, acceleration:a)
        color.setFill()
        let pt = p.applying(screen)
        CGRect(origin: pt, size: SgArRenderer.dot).fill()
    }
}

protocol SgArColorResolver {
    func resolve(point: CGPoint, velocity: CGPoint, acceleration: CGPoint) -> NSColor
}
