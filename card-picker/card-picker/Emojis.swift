//
//  Emojis.swift
//  card-picker
//
//  Created by Abhishek Kumar on 17/02/22.
//

import Foundation

final class Emojis {
    private var emojiChoices = [String]()
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil,
           emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return card.state == .faceUp ? (emoji[card.identifier] ?? "?") : ""
    }
    
    func setEmojiChoices() {
        for i in 0x1F601...0x1F64F {
            emojiChoices.append(String(UnicodeScalar(i) ?? "-"))
        }
    }
    
}
