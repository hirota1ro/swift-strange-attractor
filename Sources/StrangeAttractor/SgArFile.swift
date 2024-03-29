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
        guard let factory = SgArFactories.singleton.obtain(name: "\(name)") else {
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
    case strCount(String)
}

enum SgArArgType {
    case i(String, ClosedRange<Int>)     // integer(key, range)
    case f(String, ClosedRange<CGFloat>) // CGfloat(key, range)
    case s(String, Int)                  // AYsystem(key, count)
}

extension SgArArgType {

    var key: String {
        switch self {
        case let .i(key, _):
            return key
        case let .f(key, _):
            return key
        case let .s(key, _):
            return key
        }
    }
}

struct SgArParam {
    let dict: [String: Any]
}

extension SgArParam {

    static func build(args: [SgArArgType], dict: [String: Any]) throws -> SgArParam {
        var d: [String: Any] = [:]
        for arg in args {
            switch arg {
            case let .i(key, _):
                d[key] = try SgArParam.asInt(dict, key)
            case let .f(key, _):
                d[key] = try SgArParam.asFloat(dict, key)
            case let .s(key, count):
                let s = try SgArParam.asStr(dict, key)
                guard s.count == count else { throw SgArError.strCount(key) }
                d[key] = s
            }
        }
        if let x0 = try? SgArParam.asFloat(dict, "x0"),
           let y0 = try? SgArParam.asFloat(dict, "y0") {
            d["x0"] = x0
            d["y0"] = y0
        }
        return SgArParam(dict: d)
    }
    static func asInt(_ dict: [String: Any], _ key: String) throws -> Int {
        if let val = dict[key] {
            if let ival = Int("\(val)") {
                return ival
            }
        }
        throw SgArError.noParam(key)
    }
    static func asFloat(_ dict: [String: Any], _ key: String) throws -> CGFloat {
        if let val = dict[key] {
            if let fval = Float("\(val)") {
                return CGFloat(fval)
            }
        }
        throw SgArError.noParam(key)
    }
    static func asStr(_ dict: [String: Any], _ key: String) throws -> String {
        if let val = dict[key] {
            return "\(val)"
        }
        throw SgArError.noParam(key)
    }
}
extension SgArParam {
    func int(_ key: String) -> Int { return dict[key] as! Int }
    func flt(_ key: String) -> CGFloat { return dict[key] as! CGFloat }
    func str(_ key: String) -> String { return dict[key] as! String }

    func getFloat(_ key: String) -> CGFloat? { return dict[key] as? CGFloat }

    func value(of key: String) -> Any? { return dict[key] }
}
