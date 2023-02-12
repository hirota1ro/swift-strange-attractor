import Foundation

extension StrangeAttractor.Mutation {

    mutating func run() throws {
        let progress = MeasurementProgress(DeterminableProgress())
        progress.begin()
        defer { progress.end() }
        let drivers = try SgArFile.read(from: inputFile)
        guard let driver = drivers.first else {
            print("not contains formula in \(inputFile)")
            return
        }
        let algo = SgArSearchAlgorithm(count: count, iterations:iterations, threshold:threshold, concession:concession)
        let found = algo.search(source: MutationSearchSource(base: driver, factor: CGFloat(factor)))
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

struct MutationSearchSource {
    let base: SgArDriver
    let factor: CGFloat
}
extension MutationSearchSource: SgArSearchSource {
    func create() -> SgArDriver { return base.mutated(factor: factor) }
}
