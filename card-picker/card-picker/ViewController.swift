//
//  ViewController.swift
//  card-picker
//
//  Created by Abhishek Kumar on 10/02/22.
//



import UIKit

extension UIColor {
    static let flipUpColor: UIColor = UIColor(named: "flipUpColor")!
    static let flipDownColor: UIColor = UIColor(named: "flipDownColor")!
    static let matchedColor: UIColor = UIColor(named: "matchedColor")!
}


class ViewController: UIViewController {
    lazy var game = CardPicker(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var emojis = Emojis()
    
    var numberOfPairsOfCards: Int {
        (cardButtons.count+1)/2
    }
    
    var activeButtons : UIButton?
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var timer:Timer?
    
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    var flipIndex: (Int?, Int?)
    
    func switchCardState(with index: Int?) {
        if index == nil {
            return
        }
        let button = cardButtons[index!]
        let card = game.cards[index!]
        button.setTitle(emojis.emoji(for: card), for: .normal);
        switch card.state {
        case .faceUp:
            button.backgroundColor = UIColor.flipUpColor
        case .faceDown:
            button.backgroundColor = UIColor.flipDownColor
        case .matched:
            button.isUserInteractionEnabled = false
            button.backgroundColor = UIColor.matchedColor
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            self.timer?.invalidate()
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel(of: cardNumber)
            flipIndex = game.matchCard(at: cardNumber)

            self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
                self.updateViewFromModel(of: cardNumber)
            }
        }
    }
    
    func updateViewFromModel(of index: Int) {
        switchCardState(with: index)
        switchCardState(with: flipIndex.0)
        switchCardState(with: flipIndex.1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardButtons = cardButtons.shuffled();
    }
    
}

