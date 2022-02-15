//
//  Card-picker.swift
//  card-picker
//
//  Created by Abhishek Kumar on 11/02/22.
//

import Foundation


class CardPicker {
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFace == .faceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                if index == newValue {
                    cards[index].isFace = .faceUp
                } else {
                    cards[index].isFace = .faceDown
                }
            }
        }
    }
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                cards[index].isFace = .faceUp
                
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...12 {
            let card = Card()
            cards += [card]
        }
    }
}
