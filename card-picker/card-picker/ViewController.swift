//
//  ViewController.swift
//  card-picker
//
//  Created by Abhishek Kumar on 10/02/22.
//



//corner radius, stroke width and outlet
// for selection of background color : #colorLiteral()
import UIKit

//day1
//?How to make dynamic size button
//?streching
//?buttons have  differnt behaviour after two-click as intial
//?I am not able to increase the font size after clicking it is automaticaly taking the default size

//day2
// diffrence between weak var and var
//sleep() -- dispatchQueue, timer


//enum CardStates {
//    case faceUp, faceDown
//}

//userinteraction
class ViewController: UIViewController {
    
    lazy var game = CardPicker(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        (cardButtons.count+1)/2
    }
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    func switchCardState(with button: UIButton, for card: Card) {
        switch card.isFace {
        case .faceUp:
            button.setTitle(emoji(for: card), for: .normal);
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .faceDown:
            button.setTitle("", for: .normal)
            button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.2172311246, blue: 1, alpha: 0) : #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)   //+
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
//            let timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { [self] timer in
//                                          processFlip(with: button)
//                                    }
            updateViewFromModel()
        }
        else {
            print("Clicked Button is not in Array cardbutton")
        }
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            print(card.isFace, card.identifier)
            switchCardState(with: button, for: card)
        }
    }
    
    var emojiChoices = ["🥳", "😜", "🤝", "👽", "😋", "✌️", "🥳", "😜", "🤝", "👽", "😋", "✌️"]

    var emoji = [Int: String]()
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}

