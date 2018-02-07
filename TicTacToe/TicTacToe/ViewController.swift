//
//  ViewController.swift
//  TicTacToe
//
//  Created by Chen Shih Chia on 10/26/17.
//  Copyright © 2017 ShihChia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var winLab: UILabel!
    @IBOutlet weak var playAgainBut: UIButton!
    
    @IBAction func playAgain(_ sender: Any) {
        activeGame = true
        activePlayer = 1
        gameStatus = [0, 0, 0, 0, 0, 0, 0, 0, 0]

        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                button.setImage(nil, for: [])
            }
        }
        winLab.isHidden = true
        playAgainBut.isHidden = true
        winLab.center = CGPoint(x: winLab.center.x - 500, y: winLab.center.y)
        playAgainBut.center = CGPoint(x: playAgainBut.center.x - 500, y: playAgainBut.center.y)
    }
    
    var activeGame = true
    var activePlayer = 1    // 1 is nought, 2 is cross
    var gameStatus = [0, 0, 0, 0, 0, 0, 0, 0, 0] // 0 is empty, 1 is nought, 2 is cross
    let winningCombinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    @IBAction func buttonPressed(_ sender: Any) {
        if gameStatus[(sender as AnyObject).tag - 1] == 0 && activeGame{
            if activePlayer == 1 {
                (sender as AnyObject).setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
                gameStatus[(sender as AnyObject).tag - 1] = 1
                
            } else {
                (sender as AnyObject).setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
                gameStatus[(sender as AnyObject).tag - 1] = 2
            }
        }
        for com in winningCombinations {
            if gameStatus[com[0]] != 0 && gameStatus[com[0]] == gameStatus[com[1]] && gameStatus[com[1]] == gameStatus[com[2]] {
                //win state
                activeGame = false
                winLab.isHidden = false
                playAgainBut.isHidden = false
                
                if gameStatus[com[0]] == 1 {
                    winLab.text = "Noughts has won!"
                } else {
                    winLab.text = "Crosses has won!"
                }
                
                UIView.animate(withDuration: 1, animations: {
                    self.winLab.center = CGPoint(x: self.winLab.center.x + 500, y: self.winLab.center.y)
                    self.playAgainBut.center = CGPoint(x: self.playAgainBut.center.x + 500, y: self.playAgainBut.center.y)
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        winLab.isHidden = true
        playAgainBut.isHidden = true
        winLab.center = CGPoint(x: winLab.center.x - 500, y: winLab.center.y)
        playAgainBut.center = CGPoint(x: playAgainBut.center.x - 500, y: playAgainBut.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

