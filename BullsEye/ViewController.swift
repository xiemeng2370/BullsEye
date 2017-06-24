//
//  ViewController.swift
//  BullsEye
//
//  Created by Meng Xie on 6/23/17.
//  Copyright © 2017 Meng Xie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var currentValue = 0
    var targetValue = 0
    var score = 0
    var round = 0
    
    //tell Interface Builder that connect slider/label to a UI object
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //receiver.methodName(parameters); self.startNewGame()
        startNewGame()
        updateLabels()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //the @IBAction specifier allows Interface Builder to see the method so you can connect it to buttons, sliders, labels and so on
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
    }
    
    @IBAction func showAlert(){
        //abs() function - "absolute value"; let create a constant
        let difference = abs(targetValue - currentValue)
        /* Algorithm 1
        var difference: Int
        if currentValue >= targetValue {
            difference = currentValue - targetValue
        }
        else {
            difference = targetValue - currentValue
        }
        */
        
        /* Algorithm 2
        var difference = currentValue - targetValue
        if difference < 0 {
            difference *= -1 or difference = -difference
        }
        */
        let points = 100 - difference
        
        score += points
        
        let message = "The value of the slider is: \(currentValue)" + "\nThe target value is: \(targetValue)" + "\nThe difference is: \(difference)"
        
        let alert = UIAlertController(title: "You scored \(points) points",
                                      message: message,
                                      preferredStyle: .alert)
        //The third parameter, handler, tells the alert what should happen when the button is pressed
        let action = UIAlertAction(title: "OK", style: .default,
                                   handler: { action in
                                                //inside closures you do have to use self to refer to the view controller
                                                self.startNewRound()
                                                self.updateLabels()
                                            })
        
        alert.addAction(action)
        //make the alert visible:
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    func startNewRound() {
        round += 1
        //generate random number
        targetValue = 1 + Int(arc4random_uniform(100))
        //resets the position of the slider to middle(50)
        currentValue = 50
        //slider value type is float, so convert currentValue type from int to float
        slider.value = Float(currentValue)
    }
    
    func updateLabels() {
        //text value type is string, so convert targetValue type from int to string; targetLabel.text = "\(targetValue)"
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }

}

