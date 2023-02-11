import Foundation

struct SgArDriver {
    let factory: SgArFactory
    let param: SgArParam
}

extension SgArDriver {

    var formula: SgArFormula { return factory.create(param: param) }

    var start: CGPoint {
        if let x0 = param.getFloat("x0"),
           let y0 = param.getFloat("y0") {
            return CGPoint(x: x0, y: y0)
        }
        return factory.start
    }

    func createRandomly() -> SgArDriver {
        return SgArDriver(factory: factory, param: factory.createParamRandomly())
    }

    func mutated(factor: CGFloat) -> SgArDriver {
        var d: [String: Any] = [:]
        for arg in factory.args {
            switch arg {
            case let .i(key, _):
                let Δ = Int.random(in: -Int(factor) ... Int(factor))
                d[key] = param.int(key) + Δ
            case let .f(key, _):
                let Δ = CGFloat.random(in: -factor ... factor)
                d[key] = param.flt(key) + Δ
            case let .s(key, _):
                d[key] = AYSystem.mutated(param.str(key), factor: factor)
            }
        }
        return SgArDriver(factory: factory, param: SgArParam(dict: d))
    }

    var name: String { return factory.name }

    var json: [String: Any] {
        var d: [String: Any] = ["name": name]
        for arg in factory.args {
            let key = arg.key
            d[key] = param.value(of: key)
        }
        return d
    }

    var head: [String] {
        let keys = factory.args.map { $0.key }
        return ["#name"] + keys
    }

    var csv: [String] {
        let keys = factory.args.map { $0.key }
        let values = keys.compactMap { param.value(of: $0) }
        let record = values.map { "\($0)" }
        return [name] + record
    }
}

extension SgArDriver: CustomStringConvertible {

    var description: String {
        var a: [String] = []
        for arg in factory.args {
            switch arg {
            case let .i(key, _):
                let ival = param.int(key)
                a.append("\(key)=\(ival)")
            case let .f(key, _):
                let fval = param.flt(key)
                a.append("\(key)=\(fval.f2)")
            case let .s(key, _):
                let sval = param.str(key)
                a.append("\(key)=\(sval)")
            }
        }
        let b = a.joined(separator: ",")
        return "\(name)(\(b))"
    }
}

extension SgArFactory {

    func createParamRandomly() -> SgArParam {
        var d: [String: Any] = [:]
        for arg in args {
            switch arg {
            case let .i(key, range):
                d[key] = Int.random(in: range)
            case let .f(key, range):
                d[key] = CGFloat.random(in: range)
            case let .s(key, count):
                d[key] = AYSystem.random(count: count)
            }
        }
        return SgArParam(dict: d)
    }
}
