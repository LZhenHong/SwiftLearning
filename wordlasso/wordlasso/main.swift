//
//  main.swift
//  wordlasso
//
//  Created by Eden on 2022/10/29.
//

import Foundation
import ArgumentParser

struct Wordlasso: ParsableCommand {
    @Argument(help: """
        The word template to match, with \(WordFinder.wildcard) as \
        placeholders. Leaving this blank will enter interactive mode.
        """)
    var template: String?
    
    @Flag(name: .shortAndLong, help: "Perform case-insensitive matches.")
    var ignoreCase: Bool = false
    
    @Option(name: .customLong("wordfile"), help: "Path to a newline-delimited word list.")
    var wordListPath: String = "/usr/share/dict/words"
    
    func run() throws {
        let wordFinder = try WordFinder(wordListPath: wordListPath, ignoreCase: ignoreCase)
        
        let args = CommandLine.arguments
        print("Command-line arguments: \(args)")
        
        if let template = template {
            findAndPrintMatches(for: template, using: wordFinder)
        } else {
            while true {
                print("Enter word template: ", terminator: "")
                let template = readLine() ?? ""
                if template.isEmpty {
                    return
                }
                findAndPrintMatches(for: template, using: wordFinder)
            }
        }
    }
    
    private func findAndPrintMatches(for template: String, using wordFinder: WordFinder) {
        let matches = wordFinder.findMatches(for: template)
        print("Found \(matches.count) \(matches.count == 1 ? "match" : "matches"):")
        for match in matches {
            print(match)
        }
    }
}

Wordlasso.main()
