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


class ViewController: UIViewController {
    
    var flippedUpButton: UIButton? = nil
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var faceUp = 0
    
    var emojis = ["🥳", "😜", "😜", "👽", "🥳", "👽", "🤝", "🤝", "👽", "😋", "👽", "😋"]
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    func processFlip(with firstButton: UIButton) {
        if let flippedUpButton = flippedUpButton {
            if firstButton.currentTitle == flippedUpButton.currentTitle {
                firstButton.isHidden = true;
                flippedUpButton.isHidden = true;
            }
            else {
                switchCardState(with: firstButton, as: nil, .faceDown)
                switchCardState(with: flippedUpButton, as: nil, .faceDown)
            }
            faceUp = 0;
        }
        if faceUp == 0 {
            flippedUpButton = nil
        }
        else {
            flippedUpButton = firstButton
        }
    }
    
    func switchCardState(with button: UIButton, as title: String?, _ state: CardStates) {
        button.setTitle(title, for: .normal);
        switch state {
        case .faceUp:
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        case .faceDown:
            button.backgroundColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        }
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let index = cardButtons.firstIndex(of: sender) {
            flipCard(with: emojis[index], on: sender)
        }
        else {
            print("Clicked Button is not in Array cardbutton")
        }
        
    }
    
    func flipCard(with emoji: String, on button: UIButton) {
        if button.currentTitle != nil {
            faceUp -= 1
            switchCardState(with: button, as: nil, .faceDown)
            flippedUpButton = nil
        }
        else {
            faceUp += 1
            switchCardState(with: button, as: emoji, .faceUp)
            let timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { [self] timer in
                              processFlip(with: button)
                        }
        }
    }
}

