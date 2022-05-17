import Foundation

protocol SgArRandomFactory {
    func randomCreate() -> SgArFormula
}

struct SgArRandom {
}

extension SgArRandom {
    struct Bedhead: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -1 ... 1)
            let b = CGFloat.random(in: -1 ... 1)
            return SgAr.Bedhead(a: a, b: b)
        }
    }
    struct Clifford: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -3 ... 3)
            let b = CGFloat.random(in: -3 ... 3)
            let c = CGFloat.random(in: -3 ... 3)
            let d = CGFloat.random(in: -3 ... 3)
            return SgAr.Clifford(a: a, b: b, c: c, d: d)
        }
    }
    struct FractalDream: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -3 ... 3)
            let b = CGFloat.random(in: -3 ... 3)
            let c = CGFloat.random(in: -0.5 ... 1.5)
            let d = CGFloat.random(in: -0.5 ... 1.5)
            return SgAr.FractalDream(a: a, b: b, c: c, d: d)
        }
    }
    struct GumowskiMira: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let f = Int.random(in: 1 ... 2)
            let g = Int.random(in: 1 ... 2)
            let a = CGFloat.random(in: -1 ... 1)
            let s = CGFloat.random(in: -1 ... 1)
            let m = CGFloat.random(in: -1 ... 1)
            return SgAr.GumowskiMira(f: f, g: g, a: a, s: s, m: m)
        }
    }
    struct Hopalong: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: 0 ... 10)
            let b = CGFloat.random(in: 0 ... 10)
            let c = CGFloat.random(in: 0 ... 10)
            return SgAr.Hopalong(a: a, b: b, c: c)
        }
    }
    struct JasonRampe1: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -3 ... 3)
            let b = CGFloat.random(in: -3 ... 3)
            let c = CGFloat.random(in: -3 ... 3)
            let d = CGFloat.random(in: -3 ... 3)
            return SgAr.JasonRampe1(a: a, b: b, c: c, d: d)
        }
    }
    struct JasonRampe2: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -3 ... 3)
            let b = CGFloat.random(in: -3 ... 3)
            let c = CGFloat.random(in: -3 ... 3)
            let d = CGFloat.random(in: -3 ... 3)
            return SgAr.JasonRampe2(a: a, b: b, c: c, d: d)
        }
    }
    struct JasonRampe3: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -3 ... 3)
            let b = CGFloat.random(in: -3 ... 3)
            let c = CGFloat.random(in: -3 ... 3)
            let d = CGFloat.random(in: -3 ... 3)
            return SgAr.JasonRampe3(a: a, b: b, c: c, d: d)
        }
    }
    struct JohnnySvensson: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -3 ... 3)
            let b = CGFloat.random(in: -3 ... 3)
            let c = CGFloat.random(in: -3 ... 3)
            let d = CGFloat.random(in: -3 ... 3)
            return SgAr.JohnnySvensson(a: a, b: b, c: c, d: d)
        }
    }
    struct PeterDeJong: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -3 ... 3)
            let b = CGFloat.random(in: -3 ... 3)
            let c = CGFloat.random(in: -3 ... 3)
            let d = CGFloat.random(in: -3 ... 3)
            return SgAr.PeterDeJong(a: a, b: b, c: c, d: d)
        }
    }
    struct SymmetricIcon: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let l = CGFloat.random(in: -3 ... 3)
            let a = CGFloat.random(in: -3 ... 5)
            let b = CGFloat.random(in: -17 ... 2)
            let g = CGFloat.random(in: -1 ... 1)
            let o = CGFloat.random(in: -0.2 ... 0.2)
            let d = Int.random(in: 3 ... 24)
            return SgAr.SymmetricIcon(l: l, a: a, b: b, g: g, o: o, d: d)
        }
    }
    struct Tinkerbell: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a: CGFloat = 0.03
            let b: CGFloat = -0.29
            let c: CGFloat = -1.93
            let d: CGFloat = 0.87
            let x0 = CGFloat.random(in: -0.01 ... 0.01)
            let y0 = CGFloat.random(in: -0.01 ... 0.01)
            return SgAr.Tinkerbell(a: a, b: b, c: c, d: d, x0: x0, y0: y0)
        }
        func XXXXrandomCreateXXX() -> SgArFormula {
            let a = CGFloat.random(in: -1 ... 1)
            let b = CGFloat.random(in: -1 ... 1)
            let c = CGFloat.random(in: -2 ... 2)
            let d = CGFloat.random(in: -1 ... 1)
            let x0 = CGFloat.random(in: -0.01 ... 0.01)
            let y0 = CGFloat.random(in: -0.01 ... 0.01)
            return SgAr.Tinkerbell(a: a, b: b, c: c, d: d, x0: x0, y0: y0)
        }
    }
    struct QuadraticStrange: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a: [CGFloat] = (0 ..< 12).map { _ in return CGFloat.random(in: -1.2 ... 1.2) }
            let code: String = AYSystem.encode(a)
            return SgAr.QuadraticStrange(code)
        }
    }
    struct CubicStrange: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a: [CGFloat] = (0 ..< 20).map { _ in return CGFloat.random(in: -1.2 ... 1.2) }
            let code: String = AYSystem.encode(a)
            return SgAr.QuadraticStrange(code)
        }
    }
    struct QuarticStrange: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a: [CGFloat] = (0 ..< 30).map { _ in return CGFloat.random(in: -1.2 ... 1.2) }
            let code: String = AYSystem.encode(a)
            return SgAr.QuadraticStrange(code)
        }
    }
    struct ChossatGolubitsky: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -2 ... 2)
            let b = CGFloat.random(in: -0.2 ... 0.2)
            let c = CGFloat.random(in: -3 ... 3)
            let d = CGFloat.random(in: -1 ... 1)
            return SgAr.ChossatGolubitsky(a: a, b: b, c: c, d: d)
        }
    }
    struct Lorenz: SgArRandomFactory {
        func randomCreate() -> SgArFormula {
            let a = CGFloat.random(in: -2 ... 2)
            let b = CGFloat.random(in: -2 ... 2)
            return SgAr.Lorenz(a: a, b: b)
        }
    }
}

extension SgArRandom {
    static let fmap: [String: SgArRandomFactory] = [
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
      "Lorenz": Lorenz()
    ]
    static func obtain(name: String) -> SgArRandomFactory? {
        return fmap[name]
    }
}

protocol SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula
}

extension SgAr.Bedhead: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb)
    }
}

extension SgAr.Clifford: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.FractalDream: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.GumowskiMira: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δs = CGFloat.random(in: -factor ... factor)
        let Δm = CGFloat.random(in: -factor ... factor)
        return Self(f: nf, g: ng, a:alpha + Δa, s: sigma + Δs, m: mu + Δm)
    }
}

extension SgAr.Hopalong: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc)
    }
}

extension SgAr.JasonRampe1: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.JasonRampe2: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.JasonRampe3: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.JohnnySvensson: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.PeterDeJong: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.SymmetricIcon: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δl = CGFloat.random(in: -factor ... factor)
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δg = CGFloat.random(in: -factor ... factor)
        let Δo = CGFloat.random(in: -factor ... factor)
        return Self(l: λ + Δl, a: α + Δa, b: β + Δb, g: γ + Δg, o: ω + Δo, d: d)
    }
}

extension SgAr.Tinkerbell: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd, x0:x0, y0:y0)
    }
}

extension SgAr.QuadraticStrange: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let newA = a.map { AYSystem.clamp($0 + .random(in: -factor ... factor)) }
        let code = AYSystem.encode(newA)
        return Self(code)
    }
}

extension SgAr.CubicStrange: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let newA = a.map { AYSystem.clamp($0 + .random(in: -factor ... factor)) }
        let code = AYSystem.encode(newA)
        return Self(code)
    }
}

extension SgAr.QuarticStrange: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let newA = a.map { AYSystem.clamp($0 + .random(in: -factor ... factor)) }
        let code = AYSystem.encode(newA)
        return Self(code)
    }
}

extension SgAr.ChossatGolubitsky: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        let Δc = CGFloat.random(in: -factor ... factor)
        let Δd = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb, c: c + Δc, d: d + Δd)
    }
}

extension SgAr.Lorenz: SgArMutation {
    func mutated(factor: CGFloat) -> SgArFormula {
        let Δa = CGFloat.random(in: -factor ... factor)
        let Δb = CGFloat.random(in: -factor ... factor)
        return Self(a: a + Δa, b: b + Δb)
    }
}
