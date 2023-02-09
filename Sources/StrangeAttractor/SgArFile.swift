import Foundation

struct SgArFile {
}

extension SgArFile {

    static func read(from filePath: String) throws -> [SgArDriver] {
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

    static func read(fromDict dict: [String: Any]) throws -> SgArDriver {
        guard let name = dict["name"] as? String else {
            throw SgArError.noName
        }
        guard let factory = SgArFactories.obtain(name: "\(name)") else {
            throw SgArError.noFactory(name)
        }
        do {
            let param = try SgArParam.build(args: factory.args, dict: dict)
            return SgArDriver(factory: factory, param: param)
        } catch SgArError.noParam(let key) {
            throw SgArError.missing(name, key)
        }
    }

    static func read(fromArray array: [Any]) throws -> [SgArDriver] {
        return try array.compactMap { elt throws -> SgArDriver? in
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

enum SgArParamType {
    case integer
    case float
    case string
}

struct SgArArg {
    let name: String
    let type: SgArParamType
}
extension SgArArg {
    static func i(_ name: String) -> SgArArg { return SgArArg(name: name, type: .integer) }
    static func f(_ name: String) -> SgArArg { return SgArArg(name: name, type: .float) }
    static func s(_ name: String) -> SgArArg { return SgArArg(name: name, type: .string) }
}

struct SgArParam {
    let dict: [String: Any]
}
extension SgArParam {
    static func build(args: [SgArArg], dict: [String: Any]) throws -> SgArParam {
        var d: [String: Any] = [:]
        for arg in args {
            let name = arg.name
            var val: Any? = nil
            switch arg.type {
            case .integer:
                val = SgArParam.asInt(dict, name)
            case .float:
                val = SgArParam.asFloat(dict, name)
            case .string:
                val = SgArParam.asStr(dict, name)
            }
            if let v = val {
                d[name] = v
            } else {
                throw SgArError.noParam(name)
            }
        }
        return SgArParam(dict: d)
    }
    static func asInt(_ dict: [String: Any], _ key: String) -> Int? {
        if let val = dict[key] {
            if let ival = Int("\(val)") {
                return ival
            }
        }
        return nil
    }
    static func asFloat(_ dict: [String: Any], _ key: String) -> CGFloat? {
        if let val = dict[key] {
            if let fval = Float("\(val)") {
                return CGFloat(fval)
            }
        }
        return nil
    }
    static func asStr(_ dict: [String: Any], _ key: String) -> String? {
        if let val = dict[key] {
            return "\(val)"
        }
        return nil
    }
}
extension SgArParam {
    func int(_ key: String) -> Int { return dict[key] as! Int }
    func flt(_ key: String) -> CGFloat { return dict[key] as! CGFloat }
    func str(_ key: String) -> String { return dict[key] as! String }
}

struct SgArDriver {
    let factory: SgArFactory
    let param: SgArParam
}
extension SgArDriver {
    var formula: SgArFormula { return factory.create(param: param) }
}
