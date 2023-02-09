import Foundation

class AYSystem {

    static func decode(_ s: String) -> [CGFloat] {
        return s.map { decodeChar($0) }
    }

    static func decodeChar(_ c: Character) -> CGFloat {
        guard let code = c.asciiValue else { return .nan }
        assert(Character("A").asciiValue! <= code && code <= Character("Y").asciiValue!)
        return -1.2 + 0.1 * CGFloat(code - Character("A").asciiValue!)
    }

    static func encode(_ a: [CGFloat]) -> String {
        let a1 = a.map { encodeChar($0) }
        let a2 = a1.map { "\($0)" }
        return a2.joined()
    }

    static func encodeChar(_ value: CGFloat) -> Character {
        let i = Int(round((value + 1.2) / 0.1))
        assert(0 <= i && i <= (Character("Y").asciiValue! - Character("A").asciiValue!))
        return Character(Unicode.Scalar(0x41 + i)!)
    }

    static func clamp(_ value: CGFloat) -> CGFloat {
        return min(max(-1.2, value), 1.2)
    }

    static func random(count: Int) -> String {
        let a: [CGFloat] = (0 ..< count).map { _ in return CGFloat.random(in: -1.2 ... 1.2) }
        return AYSystem.encode(a)
    }
}
