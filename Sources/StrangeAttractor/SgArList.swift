import Foundation

extension StrangeAttractor.List {

    mutating func run() throws {
        let names = SgArFactories.factories.map { $0.name }
        let text = names.joined(separator: "\n")
        if let filePath = outputFile {
            try save(text: text, toFilePath: filePath)
        } else {
            print(text)
        }
    }

    func save(text: String, toFilePath: String) throws {
        guard let data = text.data(using: .utf8) else { throw SgArRuntimeError.noUTF8Data }
        let fileURL = URL(fileURLWithPath: toFilePath)
        try data.write(to: fileURL, options: .atomic)
        print("succeeded to write \(toFilePath)")
    }
}
