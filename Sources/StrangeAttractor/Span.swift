import Foundation

struct Span {
    var min: CGFloat
    var max: CGFloat
}

extension Span {
    mutating func update(_ value: CGFloat) {
        min = Swift.min(min, value)
        max = Swift.max(max, value)
    }
    var divergent: Bool { return max > 1e+300 || min < -1e+300 }
    var value: CGFloat { return max - min }
    var center: CGFloat { return (max + min) / 2 }
    func normalized(_ value: CGFloat) -> CGFloat { return (value - min) / (max - min) }
    var csv: [String] { return ["\(min)", "\(max)"] }
}

extension Span: CustomStringConvertible {
    var description: String {
        return "(\(min), \(max))"
    }
}
