import Foundation

protocol SgArFactory {
    var args: [SgArArgType] { get }
    func create(param: SgArParam) -> SgArFormula
    func next(param: SgArParam) -> SgArNext
    var start: CGPoint { get }
}

extension SgArFactory {
    var name: String { return String(describing: type(of: self)) }
}

typealias SgArNext = (_ x: CGFloat, _ y: CGFloat) -> CGPoint

struct Bedhead: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        return SgAr.Bedhead(a: a, b: b)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = sin(x*y/b)*y + cos(a*x - y)
            let ynew = x + sin(y)/b
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 1.0, y: 1.0) }
}

struct Clifford: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3), .f("d",-3...3)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.Clifford(a: a, b: b, c: c, d: d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = sin(a*y)+c*cos(a*x)
            let ynew = sin(b*x)+d*cos(b*y)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct FractalDream: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-0.5...1.5), .f("d", -0.5...1.5)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.FractalDream(a: a, b: b, c: c, d: d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = sin(y*b)+c*sin(x*b)
            let ynew = sin(x*a)+d*sin(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct GumowskiMira: SgArFactory {
    var args: [SgArArgType] { return [.i("f",1...2), .i("g",1...2), .f("a",-1...1), .f("s",-1...1), .f("m",-1...1)] }
    func create(param: SgArParam) -> SgArFormula {
        let f = param.int("f")
        let g = param.int("g")
        let a = param.flt("a")
        let s = param.flt("s")
        let m = param.flt("m")
        return SgAr.GumowskiMira(f:f, g:g, a:a, s:s, m:m)
    }
    func next(param: SgArParam) -> SgArNext {
        let nf = param.int("f")
        let ng = param.int("g")
        let a = param.flt("a")
        let s = param.flt("s")
        let m = param.flt("m")
        let g: (CGFloat) -> CGFloat = (ng == 1)
          ? { (_ x: CGFloat) -> CGFloat in
              let x² = x*x
              return m * x + (2 * (1 - m) * x²) / (1 + x²)
          }
          : { (_ x: CGFloat) -> CGFloat in
              let x² = x*x
              return m * x + (1 - m) * x² * exp((1 - x²) / 4)
          }
        let f: SgArNext = (nf == 1)
          ? { (_ x:CGFloat, _ y:CGFloat) -> CGPoint in
              let xnew =  y + g(x)
              let ynew = -x + g(xnew)
              return CGPoint(x: xnew, y: ynew)
          }
          : { (_ x:CGFloat, _ y:CGFloat) -> CGPoint in
              let xnew =  y + a * y * (1 - s * y*y) + g(x)
              let ynew = -x + g(xnew)
              return CGPoint(x: xnew, y: ynew)
          }
        return f
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Hopalong: SgArFactory {
    var args: [SgArArgType] { return [.f("a",0...10), .f("b",0...10), .f("c",0...10)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        return SgAr.Hopalong(a:a, b:b, c:c)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = y-1-sqrt(abs(b*x-1-c))*(x-1).sign
            let ynew = a-x-1
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.0, y: 0.0) }
}

struct JasonRampe1: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3), .f("d",-3...3)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.JasonRampe1(a:a, b:b, c:c, d:d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = cos(y*b) + c*sin(x*b)
            let ynew = cos(x*a) + d*sin(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct JasonRampe2: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3), .f("d",-3...3)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.JasonRampe2(a:a, b:b, c:c, d:d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = cos(y*b) + c*cos(x*b)
            let ynew = cos(x*a) + d*cos(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct JasonRampe3: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3), .f("d",-3...3)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.JasonRampe3(a:a, b:b, c:c, d:d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = sin(y*b) + c*cos(x*b)
            let ynew = cos(x*a) + d*sin(y*a)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct JohnnySvensson: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3), .f("d",-3...3)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.JohnnySvensson(a:a, b:b, c:c, d:d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = d*sin(x*a)-sin(y*b)
            let ynew = c*cos(x*a)+cos(y*b)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct PeterDeJong: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3), .f("d",-3...3)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.PeterDeJong(a:a, b:b, c:c, d:d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = sin(y*a)-cos(x*b)
            let ynew = sin(x*c)-cos(y*d)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct SymmetricIcon: SgArFactory {
    var args: [SgArArgType] { return [.f("l",-3...3), .f("a",-3...5), .f("b",-17...2), .f("g",-1...1), .f("o",-0.2...0.2), .i("d",3...24)] }
    func create(param: SgArParam) -> SgArFormula {
        let l = param.flt("l")
        let a = param.flt("a")
        let b = param.flt("b")
        let g = param.flt("g")
        let o = param.flt("o")
        let d = param.int("d")
        return SgAr.SymmetricIcon(l:l, a:a, b:b, g:g, o:o, d:d)
    }
    func next(param: SgArParam) -> SgArNext {
        let λ = param.flt("l")
        let α = param.flt("a")
        let β = param.flt("b")
        let γ = param.flt("g")
        let ω = param.flt("o")
        let d = param.int("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            var zreal = x
            var zimag = y
            for _ in 0 ..< d-2 {
                let za = zreal*x - zimag*y
                let zb = zimag*x + zreal*y
                zreal = za
                zimag = zb
            }
            let zn = x*zreal - y*zimag
            let p = α*(x*x + y*y) + β*zn + λ
            let xnew = p*x + γ*zreal - ω*y
            let ynew = p*y - γ*zimag + ω*x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.01, y: 0.01) }
}

struct Tinkerbell: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-1...1), .f("b",-1...1), .f("c",-2...2), .f("d",-1...1), .f("x0",-0.01...0.01), .f("y0",-0.01...0.01)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        let x0 = param.flt("x0")
        let y0 = param.flt("y0")
        return SgAr.Tinkerbell(a:a, b:b, c:c, d:d, x0:x0, y0:y0)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = x*x - y*y + a*x + b*y
            let ynew = 2*x*y + c*x + d*y
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.01, y: 0.01) }
}

struct QuadraticStrange: SgArFactory {
    var args: [SgArArgType] { return [.s("a", 12)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.str("a")
        return SgAr.QuadraticStrange(a)
    }
    func next(param: SgArParam) -> SgArNext {
        let a: [CGFloat] = AYSystem.decode(param.str("a"))
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let x² = x*x
            let y² = y*y
            let xnew = a[0] + a[1]*x + a[2]*x² + a[3]*x*y + a[ 4]*y + a[ 5]*y²
            let ynew = a[6] + a[7]*x + a[8]*x² + a[9]*x*y + a[10]*y + a[11]*y²
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct CubicStrange: SgArFactory {
    var args: [SgArArgType] { return [.s("a", 20)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.str("a")
        return SgAr.CubicStrange(a)
    }
    func next(param: SgArParam) -> SgArNext {
        let a: [CGFloat] = AYSystem.decode(param.str("a"))
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let x² = x*x
            let y² = y*y
            let x³ = x²*x
            let y³ = y²*y
            let xnew = a[ 0] + a[ 1]*x + a[ 2]*x² + a[ 3]*x³ + a[ 4]*x²*y + a[ 5]*x*y + a[ 6]*x*y² + a[ 7]*y + a[ 8]*y² + a[ 9]*y³
            let ynew = a[10] + a[11]*x + a[12]*x² + a[13]*x³ + a[14]*x²*y + a[15]*x*y + a[16]*x*y² + a[17]*y + a[18]*y² + a[19]*y³
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct QuarticStrange: SgArFactory {
    var args: [SgArArgType] { return [.s("a", 30)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.str("a")
        return SgAr.QuarticStrange(a)
    }
    func next(param: SgArParam) -> SgArNext {
        let a: [CGFloat] = AYSystem.decode(param.str("a"))
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let x² = x*x
            let y² = y*y
            let x³ = x²*x
            let y³ = y²*y
            let x⁴ = x³*x
            let y⁴ = y³*y
            let xnew = a[ 0] + a[ 1]*x + a[ 2]*x² + a[ 3]*x³ + a[ 4]*x⁴ + a[ 5]*x³*y + a[ 6]*x²*y + a[ 7]*x²*y² + a[ 8]*x*y + a[ 9]*x*y² + a[10]*x*y³ + a[11]*y + a[12]*y² + a[13]*y³ + a[14]*y⁴
            let ynew = a[15] + a[16]*x + a[17]*x² + a[18]*x³ + a[19]*x⁴ + a[20]*x³*y + a[21]*x²*y + a[22]*x²*y² + a[23]*x*y + a[24]*x*y² + a[25]*x*y³ + a[26]*y + a[27]*y² + a[28]*y³ + a[29]*y⁴
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct ChossatGolubitsky: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-2...2), .f("b",-0.2...0.2), .f("c",-3...3), .f("d",-1...1)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return SgAr.ChossatGolubitsky(a:a, b:b, c:c, d:d)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let A = a * (x * x + y * y) + b * x * (x * x - 3 * y * y) + c
            let xnew = A * x + d * (x * x - y * y)
            let ynew = A * y - 2 * d * x * y
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Lorenz: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-2...2), .f("b",-2...2)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        return SgAr.Lorenz(a:a, b:b)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = (1 + a * b) * x - b * x * y
            let ynew = (1 - b) * y + b * x * x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Cathala: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        return SgAr.Cathala(a:a, b:b)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = a*x + y
            let ynew = b + x*x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.5, y: 0.5) }
}

struct SprottElhadj: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        return SgAr.SprottElhadj(a:a, b:b)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = -a*x/(1 + y*y)
            let ynew = x + b*y
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.5, y: 0.5) }
}

struct ModifiedLozi: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func create(param: SgArParam) -> SgArFormula {
        let a = param.flt("a")
        let b = param.flt("b")
        return SgAr.ModifiedLozi(a:a, b:b)
    }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = 1 + a*(abs(x) - y*y) + y
            let ynew = b * x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.5, y: 0.5) }
}

class SgArFactories {

    static let fmap: [String: SgArFactory] = [
      "Bedhead": Bedhead(),
      "Clifford": Clifford(),
      "FractalDream": FractalDream(),
      "GumowskiMira": GumowskiMira(),
      "Hopalong": Hopalong(),
      "JasonRampe1": JasonRampe1(),
      "JasonRampe2": JasonRampe2(),
      "JasonRampe3": JasonRampe3(),
      "JohnnySvensson": JohnnySvensson(),
      "PeterDeJong": PeterDeJong(),
      "SymmetricIcon": SymmetricIcon(),
      "Tinkerbell": Tinkerbell(),
      "QuadraticStrange": QuadraticStrange(),
      "CubicStrange": CubicStrange(),
      "QuarticStrange": QuarticStrange(),
      "ChossatGolubitsky": ChossatGolubitsky(),
      "Lorenz": Lorenz(),
      "Cathala": Cathala(),
      "SprottElhadj": SprottElhadj(),
      "ModifiedLozi": ModifiedLozi()
    ]

    static func obtain(name: String) -> SgArFactory? { return fmap[name] }
}
