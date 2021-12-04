//
//  ViewController.swift
//  HWS_UIKit_Project2
//
//  Created by Nick Pfister on 11/23/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    let maxGuesses = 10
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var totalAnswered = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action, target: self, action: #selector(shareScore)
        )
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia", "spain", "uk", "us"]
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "[Score: \(score)] \(countries[correctAnswer].uppercased())"
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        totalAnswered += 1
        
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Good job!"
        } else {
            title = "Wrong"
            message = "You selected the flag for \(countries[sender.tag].uppercased())"
        }
            
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let handler = totalAnswered == maxGuesses ? gameOver : askQuestion
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: handler))
        present(ac, animated: true)
    }
    
    func gameOver(action: UIAlertAction!) {
        title = "Game Over!"
        let message = "You guessed \(score)/\(maxGuesses) flags correctly."
        let ac = UIAlertController(title: "Game Over!", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: startOver))
        ac.addAction(UIAlertAction(title: "Share", style: .default, handler: shareFinalScore))
        present(ac, animated: true)
    }
    
    func shareFinalScore(action: UIAlertAction!) {
        shareScore()
        startOver(action: action)
    }
    
    @objc func shareScore() {
        let vc = UIActivityViewController(activityItems: ["I guessed \(score)/\(maxGuesses) flags correctly. Can you beat my score?"], applicationActivities: [])
        present(vc, animated: true)
    }
    
    func startOver(action: UIAlertAction!) {
        score = 0
        totalAnswered = 0
        askQuestion()
    }
    
}

