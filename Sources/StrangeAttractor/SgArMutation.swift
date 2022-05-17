import Foundation

extension StrangeAttractor.Mutation {

    mutating func run() throws {
        let progress = MeasurementProgress(DeterminableProgress())
        progress.begin()
        defer { progress.end() }
        let formulas = try SgArFile.read(from: inputFile)
        guard let fmla = formulas.first else {
            print("not contains formula in \(inputFile)")
            return
        }
        guard let base: SgArMutation = fmla as? SgArMutation else {
            print("not confirm Mutation protocol \(fmla)")
            return
        }
        let driver = SgArSearchUtil(count: count, iterations:iterations, threshold:threshold, concession:concession)
        let found = driver.search(source: MutationSearchSource(base: base, factor: CGFloat(factor)))
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
    let base: SgArMutation
    let factor: CGFloat
}
extension MutationSearchSource: SgArSearchSource {
    func create() -> SgArFormula { return base.mutated(factor: factor) }
}
