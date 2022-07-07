//
// Word.swift
// Werddinary
//


import Foundation

struct Word: Codable {
    let word: String?
    let results: [WordDetail]?
}

struct WordDetail: Codable {
    let definition: String?
    let synonyms: [String]?
    let antonyms: [String]?
    let examples: [String]?
    let partOfSpeech: String?
}
