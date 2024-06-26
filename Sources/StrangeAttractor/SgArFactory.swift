import Foundation

protocol SgArFactory {
    var args: [SgArArgType] { get }
    func next(param: SgArParam) -> SgArNext
    var start: CGPoint { get }
}

extension SgArFactory {
    var name: String { return String(describing: type(of: self)) }
}

typealias SgArNext = (_ x: CGFloat, _ y: CGFloat) -> CGPoint

struct Bedhead: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
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
    func next(param: SgArParam) -> SgArNext {
        let nf = param.int("f")
        let ng = param.int("g")
        let a = param.flt("a")
        let s = param.flt("s")
        let m = param.flt("m")
        typealias GFunc = (CGFloat) -> CGFloat
        let g1: GFunc = { (_ x: CGFloat) -> CGFloat in
            let x² = x*x
            return m * x + (2 * (1 - m) * x²) / (1 + x²)
        }
        let g2: GFunc = { (_ x: CGFloat) -> CGFloat in
            let x² = x*x
            return m * x + (1 - m) * x² * CGFloat(exp((1 - x²) / CGFloat(4)))
        }
        let g: GFunc = (ng == 1) ? g1 : g2
        let f1: SgArNext = { (_ x:CGFloat, _ y:CGFloat) -> CGPoint in
            let xnew =  y + g(x)
            let ynew = -x + g(xnew)
            return CGPoint(x: xnew, y: ynew)
        }
        let f2: SgArNext = { (_ x:CGFloat, _ y:CGFloat) -> CGPoint in
            let xnew =  y + a * y * (1 - s * y*y) + g(x)
            let ynew = -x + g(xnew)
            return CGPoint(x: xnew, y: ynew)
        }
        let f: SgArNext = (nf == 1) ? f1 : f2
        return f
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Hopalong: SgArFactory {
    var args: [SgArArgType] { return [.f("a",0...10), .f("b",0...10), .f("c",0...10)] }
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

struct Hopalong2: SgArFactory {
    var args: [SgArArgType] { return [.f("a",0...10), .f("b",0...10), .f("c",0...10)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = y - x.sign*sqrt(abs(b*x - c))
            let ynew = a - x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.5, y: 0.5) }
}

struct JasonRampe1: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3), .f("d",-3...3)] }
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
    func next(param: SgArParam) -> SgArNext {
        let λ = param.flt("l")
        let α = param.flt("a")
        let β = param.flt("b")
        let γ = param.flt("g")
        let ω = param.flt("o")
        let d = param.int("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let z = Complex(re: x, im: y).pow(d - 1)
            let zn = x*z.re - y*z.im
            let p = α*(x*x + y*y) + β*zn + λ
            let xnew = p*x + γ*z.re - ω*y
            let ynew = p*y - γ*z.im + ω*x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.01, y: 0.01) }
}

struct Tinkerbell: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-1...1), .f("b",-1...1), .f("c",-2...2), .f("d",-1...1)] }
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
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -2...2)] }
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
    var args: [SgArArgType] { return [.f("a", -4...4), .f("b", -2...2)] }
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
    var args: [SgArArgType] { return [.f("a", -2...2), .f("b", -2...2)] }
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

struct MultifoldHenon: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("b", -1...1)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = 1 - a*sin(x) + b*y
            let ynew = x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 1.0, y: 1.0) }
}

struct Mira: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let f = { (_ x: CGFloat) -> CGFloat in return a*x+(2.0*(1.0-a)*x*x)/(1.0+x*x) }
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = b*y + f(x)
            let ynew = -x + f(xnew)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 12.0, y: 0.0) }
}

struct Martin: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = y - sin(x)
            let ynew = a - x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.5) }
}

struct Popcorn: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -3...3), .f("b", -3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = a*sin(y + tan(b*y))
            let ynew = a*sin(x + tan(b*x))
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.6, y: 0.2) }
}

struct Ushiki: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-4...4), .f("b",-3...3), .f("c",-4...4), .f("d",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        let d = param.flt("d")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = (a - x - b*y)*x
            let ynew = (c - y - d*x)*y
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct StrelkovaAnishchenko: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -3...3), .f("b", -3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = 1 - a*x*x + b*(y - x)
            let ynew = 1 - a*y*y + b*(x - y)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 1.0) }
}

struct Arnold: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = (x + y + a*cos(2*CGFloat.pi*y)).remainder(dividingBy: 1)
            let ynew = (x + 2*y).remainder(dividingBy: 1)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Cat: SgArFactory {
    var args: [SgArArgType] { return [] }
    func next(param: SgArParam) -> SgArNext {
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = (2*x + y).remainder(dividingBy: 1)
            let ynew = (x + y).remainder(dividingBy: 1)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct HeagyHammel: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("s", -4...4), .f("b", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let s = param.flt("s")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = a*(1 - s*cos(2*CGFloat.pi*y))*x*(1 - x)
            let ynew = (y + b).remainder(dividingBy: 1)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct HyperChaotic: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("c", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let c = param.flt("c")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = 1 - a*x*x + c*(y*y - x*x)
            let ynew = 1 - a*y*y + c*(x*x - y*y)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 1.0, y: 0.5) }
}

struct CoupledLogisticMap: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("b", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = (1 - a)*b*(1 - x)*x + a*b*(1 - y)*y
            let ynew = (1 - a)*b*(1 - y)*y + a*b*(1 - x)*x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.3, y: 0.1) }
}

struct JoshiBlackmore: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("b", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let cos2πb = cos(2.0*CGFloat.pi*b)
        let sin2πb = sin(2.0*CGFloat.pi*b)
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = a*exp(-x*x - y*y)*(x*cos2πb - y*sin2πb)
            let ynew = a*exp(-x*x - y*y)*(x*sin2πb + y*cos2πb)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct LimitCycle: SgArFactory {
    var args: [SgArArgType] { return [] }
    func next(param: SgArParam) -> SgArNext {
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = -y + x*(1 - x*x - y*y)
            let ynew = x + y*(1 - x*x - y*y)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.001, y: 0.001) }
}

struct WuYang: SgArFactory {
    var args: [SgArArgType] { return [.f("r", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let r = param.flt("r")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = r*(3*y    + 1)*x*(1 - x)
            let ynew = r*(3*xnew + 1)*y*(1 - y)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.8909, y: 0.3342) }
}

struct CubicHenon: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = a*x - x*x*x - y
            let ynew = x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.8, y: 0.49) }
}

struct KhovanovLuchinsky: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = y
            let ynew = -a*x + b*y - y*y*y + c
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct MaynardSmith: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = y
            let ynew = a*y + b - x*x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Gingerbread: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = 1 - a*abs(x) + b*y
            let ynew = x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 4.0, y: -2.10) }
}

struct MacMillan: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = y
            let ynew = -x + 2*a*(y/(1 + y*y)) + b*y
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct ModifiedMira: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let f = { (_ x: CGFloat) -> CGFloat in return a*x - (3 - a)/(a + exp(b*x)) }
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = b*y + f(x)
            let ynew = -x + f(xnew)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: -1.0, y: 8.0) }
}

struct ElhadjSprottA: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("b", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = 1 - a*y*y + b*x
            let ynew = x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct ElhadjSprottC: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("b", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = -a*x*x + y
            let ynew = b - abs(x)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct BusinessCycle: SgArFactory {
    var args: [SgArArgType] { return [.f("a", -4...4), .f("b", -4...4)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = x + y
            let ynew = a*y - (a + 1)*y*y*y - b*x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct DualHenon: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("c",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let c = param.flt("c")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = a*x + b*y - c*x*x*x
            let ynew = x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct SineSine: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = sin(x) - sin(a*y)
            let ynew = x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Serpentine: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = atan(cot(pow(2,a)*x))
            let ynew = sin(pow(2,a)*y)*cos(pow(2,a)*y)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

@inlinable func cot(_ x: CGFloat) -> CGFloat { return 1 / tan(x) }

struct CrossChaotic: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = 1 - a*y*y
            let ynew = cos(b*acos(x))
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct ProvenzaleBalmforth: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = (a*y + b)*x*(1 - x)
            let ynew = 4*y*(1 - y)
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Ikeda: SgArFactory {
    var args: [SgArArgType] { return [.f("c",-3...3), .f("u",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let c = param.flt("c")
        let u = param.flt("u")
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let t = c - 6/(1 + x*x + y*y)
            let xnew = 1 + u*(x*cos(t) - y*sin(t))
            let ynew = u*(x*sin(t) + y*cos(t))
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Belykh: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3), .f("k",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let k = param.flt("k")
        let L = { (_ x: CGFloat, _ y: CGFloat) -> CGFloat in return k*(2*x - 1) + 2*y - 1 }
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let c = L(x, y)
            let xnew = c <= 0 ? a*x : a*(x - 1) + 1
            let ynew = c <= 0 ? b*y : b*(y - 1) + 1
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

struct Belykh1: SgArFactory {
    var args: [SgArArgType] { return [.f("a",-3...3), .f("b",-3...3)] }
    func next(param: SgArParam) -> SgArNext {
        let a = param.flt("a")
        let b = param.flt("b")
        let S = { (_ x: CGFloat) -> CGFloat in return x < 0 ? -1 : 1 }
        return { (_ x: CGFloat, _ y: CGFloat) -> CGPoint in
            let xnew = S(x) - a*x + b*y
            let ynew = x
            return CGPoint(x: xnew, y: ynew)
        }
    }
    var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
}

class SgArFactories {
    let fmap: [String: SgArFactory]

    init(factories: [SgArFactory]) {
        self.fmap = factories.reduce([String: SgArFactory]()) { (d, f) in
            return d.merging([f.name: f]) { (_, new) in new }
        }
    }

    func obtain(name: String) -> SgArFactory? { return fmap[name] }

    static let singleton = SgArFactories(factories: SgArFactories.factories)

    static let factories: [SgArFactory] = [
      Bedhead(),
      Clifford(),
      FractalDream(),
      GumowskiMira(),
      Hopalong(),
      Hopalong2(),
      JasonRampe1(),
      JasonRampe2(),
      JasonRampe3(),
      JohnnySvensson(),
      PeterDeJong(),
      SymmetricIcon(),
      Tinkerbell(),
      QuadraticStrange(),
      CubicStrange(),
      QuarticStrange(),
      ChossatGolubitsky(),
      Lorenz(),
      Cathala(),
      SprottElhadj(),
      ModifiedLozi(),
      MultifoldHenon(),
      Mira(),
      Martin(),
      Popcorn(),
      Ushiki(),
      StrelkovaAnishchenko(),
      Arnold(),
      Cat(),
      HeagyHammel(),
      HyperChaotic(),
      CoupledLogisticMap(),
      JoshiBlackmore(),
      LimitCycle(),
      WuYang(),
      KhovanovLuchinsky(),
      CubicHenon(),
      MaynardSmith(),
      Gingerbread(),
      MacMillan(),
      ModifiedMira(),
      ElhadjSprottA(),
      ElhadjSprottC(),
      BusinessCycle(),
      DualHenon(),
      SineSine(),
      Serpentine(),
      CrossChaotic(),
      ProvenzaleBalmforth(),
      Ikeda(),
      Belykh(),
      Belykh1(),
    ]
}
