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
    
    @IBOutlet weak var gameOver: UILabel!
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
    
    func switchCardState(ofCard index: Int?) {
        guard let index = index else {
            return
        }
        let button = cardButtons[index]
        let card = game.cards[index]
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
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            self.timer?.invalidate()
            updateViewFromModelOfflipIndex()
            if !game.canProceed(with: cardNumber){
                return
            }
            flipCount += 1
            game.chooseCard(at: cardNumber)
            switchCardState(ofCard: cardNumber)
            flipIndex = game.matchCard(at: cardNumber)

            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5,
                                              repeats: false) { _ in
                self.updateViewFromModelOfflipIndex()
            }
        }
    }
    func gameOverMessage() {
        let mString = "Game\n Over\n" + "Score: \(flipCount)"
        gameOver.text = mString
        flipCountLabel.text = ""
    }
    func updateViewFromModelOfflipIndex() {
        switchCardState(ofCard: flipIndex.0)
        switchCardState(ofCard: flipIndex.1)
        flipIndex = (nil, nil)
        if game.remainingCards <= 0 {
            gameOverMessage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardButtons = cardButtons.shuffled();
        emojis.setEmojiChoices()
    }
    
}

