//
//  ViewController.swift
//  apple pie
//
//  Created by Hari Patel on 1/27/22.

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["glorious", "incandecent", "buccaneer", "bug", "program", "swift"]
    let incorrectmovesallowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: game!
    
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let Letter = Character(letterString.lowercased())
        currentGame.playerGuessed (Letter: Letter)
        
        updateGameState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        newRound()
    }
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = game (word: newWord , incorrectmovesremaining: incorrectmovesallowed, guessedLetters: [])
        enableLetterButtons(true)
        updateUI()
        } else {
            enableLetterButtons(false)
        }
      }
        func enableLetterButtons(_ enable: Bool) {
            for button in letterButtons {
                button.isEnabled = enable
            }
}
        

    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectmovesremaining)")
        scoreLabel.text = "wins: \(totalWins), losses : \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectmovesremaining)")
        
    }
    func updateGameState() {
        if currentGame.incorrectmovesremaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
          totalWins += 1
        } else {
        updateUI()
        }
    }

}