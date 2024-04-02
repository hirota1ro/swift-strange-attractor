import CoreGraphics

struct Complex {
    let re: CGFloat //!< real part
    let im: CGFloat //!< image part
}

extension Complex {
    init(angle: CGFloat, radius: CGFloat=1) {
        self.init(re: radius * cos(angle), im: radius * sin(angle))
    }
}

extension Complex {

    func plus(_ z: Complex) -> Complex { return Complex(re: re + z.re, im: im + z.im) }

    func minus(_ z: Complex) -> Complex { return Complex(re: re - z.re, im: im - z.im) }

    func mul(_ z: Complex) -> Complex { return Complex(re: re * z.re - im * z.im, im: re * z.im + im * z.re) }

    func mul(_ s: CGFloat) -> Complex { return Complex(re: re * s, im: im * s) }

    /**
     * @param z complex number to divide
     * @return self / z
     */
    func div(_ z: Complex) -> Complex {
        // (c + di)     (ac + bd) + (ad - bc)i
        // ---------- = ----------------------
        // (a + bi)           a^2 + b^2

        let c: CGFloat = self.re
        let d: CGFloat = self.im
        let a: CGFloat = z.re
        let b: CGFloat = z.im

        return Complex(re: a*c + b*d, im: a*d - b*c).div(a*a + b*b)
    }

    func div(_ s: CGFloat) -> Complex { return Complex(re: re / s, im: im / s) }

    var sqr: Complex {
        let r: CGFloat = sqrt(modulus)
        let t: CGFloat = arg / 2.0
        return Complex(re: cos(t), im: sin(t)).mul(r)
    }

    var square: CGFloat { return re * re + im * im }

    var modulus: CGFloat { return sqrt(square) }

    var arg: CGFloat { return atan2(im, re) }

    var conjugate: Complex { return Complex(re: re, im: -im) }

    func pow(_ n: Int) -> Complex {
        var z: Complex = self
        for _ in 0 ..< (n-1) {
            z = z.mul(self)
        }
        return z
    }

}

extension Complex: CustomStringConvertible {
    public var description: String { return "(\(re)+\(im)i)" }
}
