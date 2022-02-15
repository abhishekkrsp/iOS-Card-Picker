//
//  Card.swift
//  card-picker
//
//  Created by Abhishek Kumar on 11/02/22.
//

import Foundation

enum CardStates {
    case faceUp, faceDown
}

struct Card {
    var isFace: CardStates = .faceDown
    var isMatched = false
    var emoji = String()
    var identifier: Int
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1;
        return identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

}

