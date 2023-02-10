import Foundation

extension StrangeAttractor.Export {

    mutating func run() throws {
        let drivers = try SgArFile.read(from: inputFile)
        let text = try createText(drivers: drivers)
        if let filePath = outputFile {
            try save(text: text, toFilePath: filePath)
        } else {
            print(text)
        }
    }

    func createText(drivers: [SgArDriver]) throws -> String {
        let algorithm = SgAr()
        var buf: [String] = []
        var prev: String = ""
        for driver in drivers {
            let formula = driver.formula
            if formula.name != prev {
                let hdr = driver.head + SgArVisual.head
                buf.append(hdr.joined(separator: ", "))
                prev = formula.name
            }
            let vis = SgArVisual()
            try algorithm.draw(n: iterations, driver: driver, plotter: vis, progress: EmptyProgress())
            let list: [String] = driver.csv + vis.csv
            let line = list.joined(separator: ", ")
            buf.append(line)
        }
        return buf.joined(separator: "\n")
    }

    func save(text: String, toFilePath: String) throws {
        guard let data = text.data(using: .utf8) else { throw SgArRuntimeError.noUTF8Data }
        let fileURL = URL(fileURLWithPath: toFilePath)
        try data.write(to: fileURL, options: .atomic)
        print("succeeded to write \(toFilePath)")
    }
}
