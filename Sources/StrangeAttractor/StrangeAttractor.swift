import Foundation
import ArgumentParser

@main
struct StrangeAttractor: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Utilities for Strange Attractors.",
      subcommands: [Image.self, Search.self, Mutation.self, Export.self, List.self, Catalog.self],
      defaultSubcommand: Image.self,
      helpNames: [.long, .customShort("?")])
}

extension StrangeAttractor {
    struct Image: ParsableCommand {
        static var configuration
          = CommandConfiguration(abstract: "Create PNG image files of the specified Attractors.")

        @Argument
        var inputFile: String

        @Option(name: .shortAndLong, help: "The number of image width")
        var width: Int = 512

        @Option(name: .shortAndLong, help: "The number of image height (default: same as width)")
        var height: Int?

        @Option(name: [.customShort("N"), .long], help: "The number of iterations")
        var iterations: Int = 100_000

        @Option(name: .long, help: "The number of iterations for visual")
        var visualIterations: Int = 100_000

        @Option(name: .shortAndLong, help: "The number of high density")
        var density: Int = 1

        @Option(name: .shortAndLong, help: "gamma adjust input power (enabled when density>1)")
        var gamma: Float = 1

        @Flag(name: .long, inversion: .prefixedNo, help: "If true, assumes a black background")
        var dark: Bool = true

        @Flag(name: .long, help: "If false, fill background opaque color")
        var transparent: Bool = false

        @Option(name: [.customShort("s"), .long], help: "scale factor")
        var scaleFactor: Float = 0.95

        @Flag(name: [.customShort("t"), .long], help: "draw title")
        var drawTitle: Bool = false

        @Option(name: .shortAndLong, help: "output file path")
        var outputFile: String = "attractor.png"
    }
}

extension StrangeAttractor {
    struct Export: ParsableCommand {
        static var configuration
          = CommandConfiguration(abstract: "export csv file of the specified attractor.")

        @Argument
        var inputFile: String

        @Option(name: [.customShort("N"), .long], help: "The number of iterations (use to create visual information)")
        var iterations: Int = 10_000

        @Option(name: .shortAndLong, help: "output file path")
        var outputFile: String?
    }
}

extension StrangeAttractor {
    struct Search: ParsableCommand {
        static var configuration
          = CommandConfiguration(abstract: "Search randomly variants of the specified Attractor.")

        @Argument(help: "The name of attractor to search randomly (e.g. PeterDeJong)")
        var name: String

        @Option(name: .shortAndLong, help: "count to find")
        var count: Int = 10

        @Option(name: .shortAndLong, help: "threshold to descide goodness of image")
        var threshold: Float = 0.1

        @Option(name: [.customShort("C"), .long], help: "number of concession")
        var concession: Int = 100

        @Option(name: [.customShort("N"), .long], help: "number of iterations")
        var iterations: Int = 10_000

        @Option(name: .shortAndLong, help: "output file path")
        var outputFile: String?
    }
}

extension StrangeAttractor {
    struct Mutation: ParsableCommand {
        static var configuration
          = CommandConfiguration(abstract: "Finds mutations of the specified Attractor.")

        @Argument
        var inputFile: String

        @Option(name: .shortAndLong, help: "count to find")
        var count: Int = 10

        @Option(name: .shortAndLong, help: "mutation factor")
        var factor: Float = 0.1

        @Option(name: .shortAndLong, help: "threshold to descide goodness of image")
        var threshold: Float = 0.1

        @Option(name: [.customShort("C"), .long], help: "number of concession")
        var concession: Int = 100

        @Option(name: [.customShort("N"), .long], help: "The number of iterations")
        var iterations: Int = 10_000

        @Option(name: .shortAndLong, help: "output file path")
        var outputFile: String?
    }
}

extension StrangeAttractor {
    struct List: ParsableCommand {
        static var configuration
          = CommandConfiguration(abstract: "output list of attractor-names.")

        @Option(name: .shortAndLong, help: "output file path")
        var outputFile: String?
    }
}

extension StrangeAttractor {
    struct Catalog: ParsableCommand {
        static var configuration
          = CommandConfiguration(abstract: "output catalog image file attractor-names.")

        @Argument(help: "input *.png file names")
        var inputFiles: [String]

        @Option(name: .shortAndLong, help: "output png file path")
        var outputFile: String?

        @Option(name: .shortAndLong, help: "parameter name for x-axis")
        var xAxis: String = "a"

        @Option(name: .shortAndLong, help: "parameter name for y-axis")
        var yAxis: String = "b"

        @Flag(name: .long, help: "debug mode")
        var debug: Bool = false

        @Flag(name: .shortAndLong, help: "dark mode")
        var dark: Bool = false
    }
}
