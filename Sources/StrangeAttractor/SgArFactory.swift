import Foundation

protocol SgArFactory {
    var args: [SgArArgType] { get }
    func create(param: SgArParam) -> SgArFormula
    var start: CGPoint { get }
}
extension SgArFactory {
    var name: String { return String(describing: type(of: self)) }
}

class SgArFactories {
    struct Bedhead: SgArFactory {
        var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.Bedhead(a: a, b: b)
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
        var start: CGPoint { return CGPoint(x: 0.01, y: 0.01) }
    }
    struct QuadraticStrange: SgArFactory {
        var args: [SgArArgType] { return [.s("a", 12)] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.str("a")
            return SgAr.QuadraticStrange(a)
        }
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
    }
    struct CubicStrange: SgArFactory {
        var args: [SgArArgType] { return [.s("a", 20)] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.str("a")
            return SgAr.CubicStrange(a)
        }
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
    }
    struct QuarticStrange: SgArFactory {
        var args: [SgArArgType] { return [.s("a", 30)] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.str("a")
            return SgAr.QuarticStrange(a)
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
        var start: CGPoint { return CGPoint(x: 0.1, y: 0.1) }
    }
    struct Lorenz: SgArFactory {
        var args: [SgArArgType] { return [.f("a",-2...2), .f("b",-2...2)] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.Lorenz(a:a, b:b)
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
        var start: CGPoint { return CGPoint(x: 0.5, y: 0.5) }
    }
    struct SprottElhadj: SgArFactory {
        var args: [SgArArgType] { return [.f("a", -1...1), .f("b", -1...1)] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.SprottElhadj(a:a, b:b)
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
        var start: CGPoint { return CGPoint(x: 0.5, y: 0.5) }
    }
}

extension SgArFactories {

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

    static func obtain(name: String) -> SgArFactory? {
        return fmap[name]
    }
}
