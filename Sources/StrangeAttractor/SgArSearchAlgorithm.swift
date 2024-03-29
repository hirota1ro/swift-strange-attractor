import Foundation

protocol SgArSearchSource {
    func create() -> SgArDriver
}

struct SgArSearchAlgorithm {
    let count: Int
    let iterations: Int
    let threshold: Float
    let concession: Int
}

extension SgArSearchAlgorithm {

    func search(source: SgArSearchSource) -> [SgArDriver] {
        let progress = MeasurementProgress(DeterminableProgress())
        progress.begin()
        defer { progress.end() }
        let algorithm = SgArAlgorithm()
        var threshold = self.threshold
        var failed: Int = 0
        var found: [SgArDriver] = []
        while found.count < count {
            let driver = source.create()
            do {
                let vis = SgArVisual()
                try algorithm.draw(n: iterations, driver: driver, plotter: vis, progress: EmptyProgress())
                if vis.divergent {
                    print("skip: divergent")
                    failed += 1
                } else {
                    let paint = SgArPaintRatio(size: CGSize(width: 128, height: 128), vis: vis)
                    try algorithm.draw(n: iterations, driver: driver, plotter: paint, progress: EmptyProgress())
                    let ratio = paint.ratio
                    if ratio > threshold {
                        found.append(driver)
                        progress.progress(Float(found.count) / Float(count))
                        print("good: \(ratio) > \(threshold)")
                        failed = 0
                    } else {
                        print("bad:  \(ratio) < \(threshold)")
                        failed += 1
                    }
                }
            } catch {
                print("skip: error=\(error)")
                failed += 1
            }
            if failed > concession {
                failed = 0
                threshold *= 0.5
                print("conceded => threshold=\(threshold)")
            }
        }
        return found
    }
}
