import Foundation
import Cocoa

extension NSBezierPath {

    convenience init(lineFrom from: CGPoint, to: CGPoint) {
        self.init()
        self.move(to: from)
        self.line(to: to)
    }

    convenience init(arrowFrom from: CGPoint, to: CGPoint, head: CGFloat) {
        self.init()

        let v = (from - to).normalized
        let pleft = to + head * v.rotateBy(angle: CGFloat(30).radians)
        let pright = to + head * v.rotateBy(angle: -CGFloat(30).radians)

        self.move(to: from)
        self.line(to: to)
        self.move(to: pleft)
        self.line(to: to)
        self.line(to: pright)
    }
}
