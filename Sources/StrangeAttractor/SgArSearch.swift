import Foundation

extension StrangeAttractor.Search {

    mutating func run() {
        guard let factory = SgArFactories.singleton.obtain(name: name) else {
            print("failed: \(name)")
            return
        }
        let util = SgArSearchUtil(count: count, iterations:iterations, threshold:threshold, concession:concession)
        let found = util.search(source: RandomSearchSource(factory: factory))
        if let outputFile = outputFile {
            let json = found.map { $0.json }
            do {
                let data = try JSONSerialization.data(withJSONObject: json, options: [ .prettyPrinted, .sortedKeys ])
                let fileURL = URL(fileURLWithPath: outputFile)
                try data.write(to: fileURL, options: .atomic)
                print("succeeded to write \(outputFile)")
            } catch {
                print("\(error)")
            }
        } else {
            for f in found {
                print("\(f)")
            }
        }
    }
}

struct RandomSearchSource {
    let factory: SgArFactory
}
extension RandomSearchSource: SgArSearchSource {
    func create() -> SgArDriver { return SgArDriver(factory: factory, param: factory.createParamRandomly()) }
}
