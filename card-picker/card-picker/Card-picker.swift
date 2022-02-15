//
//  Card-picker.swift
//  card-picker
//
//  Created by Abhishek Kumar on 11/02/22.
//

import Foundation


class CardPicker {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if cards[index].state != .matched  {
            cards[index].state = .faceUp
        }
    }
    
    func matchCard(at index: Int) {
        if cards[index].state != .matched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, index != matchIndex {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].state = .matched
                    cards[matchIndex].state = .matched
                } else {
                    cards[index].state = .faceDown
                    cards[matchIndex].state = .faceDown
                }
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card]
        }
    }
}
