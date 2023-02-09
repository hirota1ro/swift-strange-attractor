import Foundation

protocol SgArFactory {
    var args: [SgArArg] { get }
    func create(param: SgArParam) -> SgArFormula
}

class SgArFactories {
    struct Bedhead: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.Bedhead(a: a, b: b)
        }
    }
    struct Clifford: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.Clifford(a: a, b: b, c: c, d: d)
        }
    }
    struct FractalDream: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.FractalDream(a: a, b: b, c: c, d: d)
        }
    }
    struct GumowskiMira: SgArFactory {
        var args: [SgArArg] { return [.i("f"), .i("g"), .f("a"), .f("s"), .f("m")] }
        func create(param: SgArParam) -> SgArFormula {
            let f = param.int("f")
            let g = param.int("g")
            let a = param.flt("a")
            let s = param.flt("s")
            let m = param.flt("m")
            return SgAr.GumowskiMira(f:f, g:g, a:a, s:s, m:m)
        }
    }
    struct Hopalong: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            return SgAr.Hopalong(a:a, b:b, c:c)
        }
    }
    struct JasonRampe1: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.JasonRampe1(a:a, b:b, c:c, d:d)
        }
    }
    struct JasonRampe2: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.JasonRampe2(a:a, b:b, c:c, d:d)
        }
    }
    struct JasonRampe3: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.JasonRampe3(a:a, b:b, c:c, d:d)
        }
    }
    struct JohnnySvensson: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.JohnnySvensson(a:a, b:b, c:c, d:d)
        }
    }
    struct PeterDeJong: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.PeterDeJong(a:a, b:b, c:c, d:d)
        }
    }
    struct SymmetricIcon: SgArFactory {
        var args: [SgArArg] { return [.f("l"), .f("a"), .f("b"), .f("g"), .f("o"), .i("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let l = param.flt("l")
            let a = param.flt("a")
            let b = param.flt("b")
            let g = param.flt("g")
            let o = param.flt("o")
            let d = param.int("d")
            return SgAr.SymmetricIcon(l:l, a:a, b:b, g:g, o:o, d:d)
        }
    }
    struct Tinkerbell: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d"), .f("x0"), .f("y0")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            let x0 = param.flt("x0")
            let y0 = param.flt("y0")
            return SgAr.Tinkerbell(a:a, b:b, c:c, d:d, x0:x0, y0:y0)
        }
    }
    struct QuadraticStrange: SgArFactory {
        var args: [SgArArg] { return [.s("a")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.str("a")
            return SgAr.QuadraticStrange(a)
        }
    }
    struct CubicStrange: SgArFactory {
        var args: [SgArArg] { return [.s("a")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.str("a")
            return SgAr.CubicStrange(a)
        }
    }
    struct QuarticStrange: SgArFactory {
        var args: [SgArArg] { return [.s("a")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.str("a")
            return SgAr.QuarticStrange(a)
        }
    }
    struct ChossatGolubitsky: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b"), .f("c"), .f("d")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            let c = param.flt("c")
            let d = param.flt("d")
            return SgAr.ChossatGolubitsky(a:a, b:b, c:c, d:d)
        }
    }
    struct Lorenz: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.Lorenz(a:a, b:b)
        }
    }
    struct Cathala: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.Cathala(a:a, b:b)
        }
    }
    struct SprottElhadj: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.SprottElhadj(a:a, b:b)
        }
    }
    struct ModifiedLozi: SgArFactory {
        var args: [SgArArg] { return [.f("a"), .f("b")] }
        func create(param: SgArParam) -> SgArFormula {
            let a = param.flt("a")
            let b = param.flt("b")
            return SgAr.ModifiedLozi(a:a, b:b)
        }
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
