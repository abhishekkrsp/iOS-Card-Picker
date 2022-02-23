//
//  Card-picker.swift
//  card-picker
//
//  Created by Abhishek Kumar on 11/02/22.
//

import Foundation


final class CardPicker {
    var cards = [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int?
    var remainingCards : Int
    
    func chooseCard(at index: Int) {
        cards[index].state = .faceUp
    }
    
    func matchCard(at index: Int) -> (Int?, Int?) {
        if let matchIndex = indexOfOneAndOnlyFaceUpCard,
           index != matchIndex {
            if cards[index].identifier == cards[matchIndex].identifier {
                cards[index].state = .matched
                cards[matchIndex].state = .matched
                remainingCards -= 1
            } else {
                cards[index].state = .faceDown
                cards[matchIndex].state = .faceDown
            }
            indexOfOneAndOnlyFaceUpCard = nil
            return (matchIndex,index)
            
        } else {
            indexOfOneAndOnlyFaceUpCard = index
            return (nil,nil)
        }
    }
    
    func canProceed(with index: Int) -> Bool {
        if cards[index].state == .matched {
            return false
        }
        return true
    }
    
    
    init(numberOfPairsOfCards: Int) {
        remainingCards = numberOfPairsOfCards
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
    }
}
