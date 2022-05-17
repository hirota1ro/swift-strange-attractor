import Foundation

class SgArPaintRatio {
    var matrix: BitMatrix
    let screen: CGAffineTransform
    let bounds: CGRect

    init(size: CGSize, vis: SgArVisual) {
        let width = Int(ceil(size.width))
        let height = Int(ceil(size.height))
        matrix = BitMatrix(width: width, height: height)
        let scale = vis.scaleToFit(size: size)
        let translation = vis.translation
        screen = .identity
          .translatedBy(x: size.width/2, y: size.height/2)
          .scaledBy(x: scale, y: scale)
          .translatedBy(x: translation.x, y: translation.y)
        bounds = CGRect(origin: .zero, size: size)
    }

    var ratio: Float { return matrix.bitRatio }
}

extension SgArPaintRatio: SgArPlotter {
    func plot(point: CGPoint, velocity: CGPoint, acceleration: CGPoint) {
        let p = point.applying(screen)
        if bounds.contains(p) {
            let x = Int(round(p.x))
            let y = Int(round(p.y))
            if matrix.inside(x: x, y: y) {
                matrix[x, y] = 1
            }
        }
    }
}
