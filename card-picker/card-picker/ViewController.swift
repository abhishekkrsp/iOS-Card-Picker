//
//  ViewController.swift
//  card-picker
//
//  Created by Abhishek Kumar on 10/02/22.
//



//corner radius, stroke width and outlet
// for selection of background color : #colorLiteral()
import UIKit


//?How to make dynamic size button
//?streching
//?buttons have  differnt behaviour after two-click as intial
//?I am not able to increase the font size after clicking it is automaticaly taking the default size
// diffrence between weak var and var

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var faceUp = 0
    
    var emojis = ["🥳", "😜", "😜", "👽", "🥳", "👽", "🤝", "🤝", "👽", "😋", "👽", "😋"]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
   
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let index = cardButtons.firstIndex(of: sender) {
            print("button \(index) is clicked")
            flipCard(with: emojis[index], on: sender)
        }
        else {
            print("Clicked Button is not in Array cardbutton")
        }
        
    }
    
    func flipCard(with emoji: String, on button: UIButton) {
        print("emoji: \(button.currentTitle)")
        if button.currentTitle != nil {
            faceUp -= 1
            button.setTitle(nil, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)

            
        }
        else {
            
            if faceUp < 2 {
                faceUp += 1
                button.setTitle(emoji, for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.titleLabel?.font = button.titleLabel?.font.withSize(50)
            }
        }
        
        if faceUp == 2{
            var flippedUpButton: UIButton? = nil
            for card in cardButtons {
                if !card.isHidden && card.currentTitle != nil {
                    if let flippedUpButton = flippedUpButton {
                        if card.currentTitle == flippedUpButton.currentTitle {
                            print(cardButtons.index(of: card))
                            flippedUpButton.isHidden = true
                            card.isHidden = true
                            faceUp = 0
                            return
                        }
                    }
                    else {
                        print("Flipped button = card")
                        print(cardButtons.index(of: card))
                        flippedUpButton = card
                    }
                }
            }
        }
    }
}

