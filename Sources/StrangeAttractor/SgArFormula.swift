import Foundation

protocol SgArFormula: CustomStringConvertible {
    var start: CGPoint { get }
    func next(x: CGFloat, y: CGFloat) -> CGPoint
    var name: String { get }
    var json: [String: Any] { get }
    var head: [String] { get }
    var csv: [String] { get }
}

extension SgArFormula {
    var name: String { return String(describing: type(of: self)) }
}

extension SgAr {

    struct Bedhead: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        var start: CGPoint { return CGPoint(x: 1.0, y: 1.0) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = sin(x*y/b)*y+cos(a*x-y)
            let ynew  = x+sin(y)/b
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b] }
        var csv: [String] { return [name, "\(a)", "\(b)"] }
        var head: [String] { return ["#name", "a", "b"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2))" }
    }

    struct Clifford: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = sin(a*y)+c*cos(a*x)
            let ynew  = sin(b*x)+d*cos(b*y)
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct FractalDream: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = sin(y*b)+c*sin(x*b)
            let ynew  = sin(x*a)+d*sin(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct GumowskiMira: SgArFormula {
        let nf: Int
        let ng: Int
        let f: (CGFloat, CGFloat) -> CGPoint
        let alpha: CGFloat
        let sigma: CGFloat
        let mu: CGFloat
        /**
         * @param ft 1 ... 2
         * @param gt 1 ... 2
         */
        init(f nf: Int, g ng:Int, a alpha: CGFloat, s sigma: CGFloat, m mu: CGFloat) {
            self.nf = nf
            self.ng = ng
            self.alpha = alpha
            self.sigma = sigma
            self.mu = mu
            let g: (CGFloat) -> CGFloat = ng == 1
              ? { (x: CGFloat) -> CGFloat in
                  let x??  = x*x
                  return mu * x + (2 * (1 - mu) * x??) / (1 + x??)
              }
              : { (x: CGFloat) -> CGFloat in
                  let x??  = x*x
                  return mu * x + (1 - mu) * x?? * exp((1 - x??) / 4)
              }
            let f: (CGFloat, CGFloat) -> CGPoint = nf == 1
              ? { (x:CGFloat, y:CGFloat) -> CGPoint in
                  let xnew  =  y + g(x)
                  let ynew  = -x + g(xnew)
                  return CGPoint(x: xnew, y: ynew)
              }
              : { (x:CGFloat, y:CGFloat) -> CGPoint in
                  let xnew  =  y + alpha * y * (1 - sigma * y*y) + g(x)
                  let ynew  = -x + g(xnew)
                  return CGPoint(x: xnew, y: ynew)
              }
            self.f = f
        }
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint { return f(x, y) }
        var json: [String: Any] { return ["name":name, "f":nf, "g":ng, "a":alpha, "s":sigma, "mu":mu] }
        var csv: [String] { return [name, "\(nf)", "\(ng)", "\(alpha)", "\(sigma)", "\(mu)"] }
        var head: [String] { return ["#name", "f", "g", "alpha", "sigma", "mu"] }
        var description: String { return "\(name)((F,G)=(\(nf),\(ng)),??=\(alpha.f2),??=\(sigma.f2),??=\(mu.f2))" }
    }

    struct Hopalong: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        var start: CGPoint { return CGPoint(x: 0.0, y: 0.0) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = y-1-sqrt(abs(b*x-1-c))*(x-1).sign
            let ynew  = a-x-1
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)"] }
        var head: [String] { return ["#name", "a", "b", "c"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2))" }
    }

    struct JasonRampe1: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = cos(y*b) + c*sin(x*b)
            let ynew  = cos(x*a) + d*sin(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct JasonRampe2: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = cos(y*b) + c*cos(x*b)
            let ynew  = cos(x*a) + d*cos(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct JasonRampe3: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = sin(y*b) + c*cos(x*b)
            let ynew  = cos(x*a) + d*sin(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct JohnnySvensson: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = d*sin(x*a)-sin(y*b)
            let ynew  = c*cos(x*a)+cos(y*b)
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct PeterDeJong: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = sin(y*a)-cos(x*b)
            let ynew  = sin(x*c)-cos(y*d)
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct SymmetricIcon: SgArFormula {
        let ??: CGFloat
        let ??: CGFloat
        let ??: CGFloat
        let ??: CGFloat
        let ??: CGFloat
        let d: Int
        init(l: CGFloat, a: CGFloat, b: CGFloat, g: CGFloat, o: CGFloat, d: Int) {
            ?? = l
            ?? = a
            ?? = b
            ?? = g
            ?? = o
            self.d = d
        }
        var start: CGPoint { return CGPoint(x: 0.01, y: 0.01) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            var zreal = x
            var zimag = y
            for _ in 0 ..< d-2 {
                let za  = zreal*x - zimag*y
                let zb  = zimag*x + zreal*y
                zreal = za
                zimag = zb
            }
            let zn  = x*zreal - y*zimag
            let p  = ??*(x*x + y*y) + ??*zn + ??
            let xnew  = p*x + ??*zreal - ??*y
            let ynew  = p*y - ??*zimag + ??*x
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "l":??, "a":??, "b":??, "g":??, "o":??, "d":d] }
        var csv: [String] { return [name, "\(??)", "\(??)", "\(??)", "\(??)", "\(??)", "\(d)"] }
        var head: [String] { return ["#name", "??", "??", "??", "??", "??", "d"] }
        var description: String { return "\(name)(??=\(??.f2),??=\(??.f2),??=\(??.f2),??=\(??.f2),??=\(??.f2),d=\(d))" }
    }

    struct Tinkerbell: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        let x0: CGFloat
        let y0: CGFloat
        var start: CGPoint { return CGPoint(x: x0, y: y0) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = x*x - y*y + a*x + b*y
            let ynew  = 2*x*y + c*x + d*y
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d, "x0":x0, "y0":y0] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)", "\(x0)", "\(y0)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d", "x0", "y0"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2),x0=\(x0.f2),y0=\(y0.f2))" }
    }

    struct QuadraticStrange: SgArFormula {
        let a: [CGFloat]
        init(_ s: String) {
            assert(s.count == 12)
            a = AYSystem.decode(s)
            assert(a.count == 12)
        }
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let x??  = x*x
            let y??  = y*y
            let xnew  = a[0] + a[1]*x + a[2]*x?? + a[3]*x*y + a[ 4]*y + a[ 5]*y??
            let ynew  = a[6] + a[7]*x + a[8]*x?? + a[9]*x*y + a[10]*y + a[11]*y??
            return CGPoint(x: xnew, y: ynew)
        }
        var code: String { return AYSystem.encode(a) }
        var json: [String: Any] { return ["name":name, "a":code] }
        var csv: [String] { return [name, "\(code)"] }
        var head: [String] { return ["#name", "code"] }
        var description: String { return "\(name)(\"\(code)\")" }
    }

    struct CubicStrange: SgArFormula {
        let a: [CGFloat]
        init(_ s: String) {
            assert(s.count == 20)
            a = AYSystem.decode(s)
            assert(a.count == 20)
        }
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let x??  = x*x
            let y??  = y*y
            let x??  = x??*x
            let y??  = y??*y
            let xnew  = a[ 0] + a[ 1]*x + a[ 2]*x?? + a[ 3]*x?? + a[ 4]*x??*y + a[ 5]*x*y + a[ 6]*x*y?? + a[ 7]*y + a[ 8]*y?? + a[ 9]*y??
            let ynew  = a[10] + a[11]*x + a[12]*x?? + a[13]*x?? + a[14]*x??*y + a[15]*x*y + a[16]*x*y?? + a[17]*y + a[18]*y?? + a[19]*y??
            return CGPoint(x: xnew, y: ynew)
        }
        var code: String { return AYSystem.encode(a) }
        var json: [String: Any] { return ["name":name, "a":code] }
        var csv: [String] { return [name, "\(code)"] }
        var head: [String] { return ["#name", "code"] }
        var description: String { return "\(name)(\"\(code)\")" }
    }

    struct QuarticStrange: SgArFormula {
        let a: [CGFloat]
        init(_ s: String) {
            assert(s.count == 30)
            a = AYSystem.decode(s)
            assert(a.count == 30)
        }
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let x??  = x*x
            let y??  = y*y
            let x??  = x??*x
            let y??  = y??*y
            let x???  = x??*x
            let y???  = y??*y
            let xnew  = a[ 0] + a[ 1]*x + a[ 2]*x?? + a[ 3]*x?? + a[ 4]*x??? + a[ 5]*x??*y + a[ 6]*x??*y + a[ 7]*x??*y?? + a[ 8]*x*y + a[ 9]*x*y?? + a[10]*x*y?? + a[11]*y + a[12]*y?? + a[13]*y?? + a[14]*y???
            let ynew  = a[15] + a[16]*x + a[17]*x?? + a[18]*x?? + a[19]*x??? + a[20]*x??*y + a[21]*x??*y + a[22]*x??*y?? + a[23]*x*y + a[24]*x*y?? + a[25]*x*y?? + a[26]*y + a[27]*y?? + a[28]*y?? + a[29]*y???
            return CGPoint(x: xnew, y: ynew)
        }
        var code: String { return AYSystem.encode(a) }
        var json: [String: Any] { return ["name":name, "a":code] }
        var csv: [String] { return [name, "\(code)"] }
        var head: [String] { return ["#name", "code"] }
        var description: String { return "\(name)(\"\(code)\")" }
    }

    struct ChossatGolubitsky: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        let c: CGFloat
        let d: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let A  = a * (x * x + y * y) + b * x * (x * x - 3 * y * y) + c
            let xnew  = A * x + d * (x * x - y * y)
            let ynew  = A * y - 2 * d * x * y
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b, "c":c, "d":d] }
        var csv: [String] { return [name, "\(a)", "\(b)", "\(c)", "\(d)"] }
        var head: [String] { return ["#name", "a", "b", "c", "d"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2),c=\(c.f2),d=\(d.f2))" }
    }

    struct Lorenz: SgArFormula {
        let a: CGFloat
        let b: CGFloat
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
        func next(x: CGFloat, y: CGFloat) -> CGPoint {
            let xnew  = (1 + a * b) * x - b * x * y
            let ynew  = (1 - b) * y + b * x * x
            return CGPoint(x: xnew, y: ynew)
        }
        var json: [String: Any] { return ["name":name, "a":a, "b":b] }
        var csv: [String] { return [name, "\(a)", "\(b)"] }
        var head: [String] { return ["#name", "a", "b"] }
        var description: String { return "\(name)(a=\(a.f2),b=\(b.f2))" }
    }
}
