import Foundation

struct SgArFile {
}

extension SgArFile {

    static func read(from filePath: String) throws -> [SgArFormula] {

        let fileURL = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileURL)
        let json = try JSONSerialization.jsonObject(with: data)

        if let dict = json as? [String: Any] {
            let f = try read(fromDict: dict)
            return [f]
        }
        if let array = json as? [Any] {
            return try read(fromArray: array)
        }
        throw SgArError.invalidJSON
    }

    static func read(fromDict dict: [String: Any]) throws -> SgArFormula {
        guard let name = dict["name"] as? String else {
            throw SgArError.noName
        }
        guard let factory = SgArFactories.obtain(name: "\(name)") else {
            throw SgArError.noFactory(name)
        }
        let param = SgArParam(dict: dict)
        do {
            return try factory.create(param: param)
        } catch SgArError.noParam(let key) {
            throw SgArError.missing(name, key)
        }
    }

    static func read(fromArray array: [Any]) throws -> [SgArFormula] {
        return try array.compactMap { elt throws -> SgArFormula? in
            guard let dict = elt as? [String: Any] else { return nil }
            return try read(fromDict: dict)
        }
    }

}

enum SgArError: Error {
    case invalidJSON
    case noName
    case noFactory(String)
    case noParam(String)
    case missing(String, String)
}

protocol SgArFactory {
    func create(param: SgArParam) throws -> SgArFormula
}

struct SgArParam {
    let dict: [String: Any]

    func flt(_ key: String) throws -> CGFloat {
        if let val = dict[key] {
            if let fval = Float("\(val)") {
                return CGFloat(fval)
            }
        }
        throw SgArError.noParam(key)
    }
    func str(_ key: String) throws -> String {
        if let val = dict[key] {
            return "\(val)"
        }
        throw SgArError.noParam(key)
    }
}

class SgArFactories {
    struct Bedhead: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.Bedhead(a:try param.flt("a"), b:try param.flt("b"))
        }
    }
    struct Clifford: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.Clifford(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct FractalDream: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.FractalDream(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct GumowskiMira: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.GumowskiMira(f:Int(try param.flt("f")), g:Int(try param.flt("g")), a:try param.flt("a"), s:try param.flt("s"), m:try param.flt("m"))
        }
    }
    struct Hopalong: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.Hopalong(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"))
        }
    }
    struct JasonRampe1: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.JasonRampe1(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct JasonRampe2: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.JasonRampe2(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct JasonRampe3: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.JasonRampe3(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct JohnnySvensson: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.JohnnySvensson(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct PeterDeJong: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.PeterDeJong(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct SymmetricIcon: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.SymmetricIcon(l:try param.flt("l"), a:try param.flt("a"), b:try param.flt("b"), g:try param.flt("g"), o:try param.flt("o"), d:Int(try param.flt("d")))
        }
    }
    struct Tinkerbell: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.Tinkerbell(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"), x0:try param.flt("x0"), y0:try param.flt("y0"))
        }
    }
    struct QuadraticStrange: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.QuadraticStrange(try param.str("a"))
        }
    }
    struct CubicStrange: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.CubicStrange(try param.str("a"))
        }
    }
    struct QuarticStrange: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.QuarticStrange(try param.str("a"))
        }
    }
    struct ChossatGolubitsky: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.ChossatGolubitsky(a:try param.flt("a"), b:try param.flt("b"), c:try param.flt("c"), d:try param.flt("d"))
        }
    }
    struct Lorenz: SgArFactory {
        func create(param: SgArParam) throws -> SgArFormula {
            return SgAr.Lorenz(a:try param.flt("a"), b:try param.flt("b"))
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
      "Lorenz": Lorenz()
    ]

    static func obtain(name: String) -> SgArFactory? {
        return fmap[name]
    }
}
