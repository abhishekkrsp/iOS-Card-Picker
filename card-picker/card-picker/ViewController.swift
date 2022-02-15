//
//  ViewController.swift
//  card-picker
//
//  Created by Abhishek Kumar on 10/02/22.
//



import UIKit


class ViewController: UIViewController {
    lazy var game = CardPicker(numberOfPairsOfCards: numberOfPairsOfCards)
    var numberOfPairsOfCards: Int {
        cardButtons.count
    }
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    func switchCardState(with button: UIButton, for card: Card) {
        switch card.state {
        case .faceUp:
            button.setTitle(emoji(for: card), for: .normal);
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .faceDown:
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        case .matched:
            button.setTitle("", for: .normal)
            button.isUserInteractionEnabled = false
            button.backgroundColor = #colorLiteral(red: 1, green: 0.2172311246, blue: 1, alpha: 0)
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            game.matchCard(at: cardNumber)
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateViewFromModel), userInfo: nil, repeats: false)
        }
        else {
            print("Clicked Button is not in Array cardbutton")
        }
        
    }
    
    @objc func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
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

