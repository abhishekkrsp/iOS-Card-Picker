//
//  Card-picker.swift
//  card-picker
//
//  Created by Abhishek Kumar on 11/02/22.
//

import Foundation


class CardPicker {
    var cards = [Card]()
    static var faceUpCardCount = 0
    func pickCard(at index: Int)
    {
        if cards[index].isFaceUp
        {
            if CardPicker.faceUpCardCount < 2
            {
                CardPicker.faceUpCardCount += 1
                cards[index].isFaceUp.toggle()
            }
            else
            {
                print("Already 2 cards faced UP, Please     face Down some of those to face UP     others")
            }
        }
        else
        {
            
        }
    }
}
