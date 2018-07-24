//
//  ViewController.swift
//  Apple Pie
//
//  Created by jack sanderson on 11/07/2018.
//  Copyright © 2018 jack sanderson. All rights reserved.
//

/*
 //TODO: Use Map instead of Loop in updateUI()
 //TODO: Add a scoring Feature
 //TODO: Add a load screen to start the game
 //TODO: Allow Multy player, same word switch between each player
 //TODO: Allow the player to guess the whole word witha keyboard
 //TODO: Allow words with speical character's 
 */
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var currentWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["food", "names", "hobbies", "animals"]
    let incorrectMovesAllowed = 7
    
    var totalWins : Int = 0 {
        didSet{
            newRound()
        }
       
    }
    
    var totalLosses : Int = 0{
        didSet{
            newRound()
        }
    }
    
    var currentGame: Game!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)! //Not all buttons have titles
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }else{
            updateUI()
        }
    }
    
    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }else{
            enableLetterButtons(false)
        }
    }
    func enableLetterButtons(_ enable:Bool){
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    func updateUI(){
        
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        currentWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    

}

