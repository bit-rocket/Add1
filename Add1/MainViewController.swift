//
//  MainViewController.swift
//  Add1
//
//  Created by itrump on 2018/10/15.
//  Copyright © 2018 fengxiaoyang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var numbersLable: UILabel?
    @IBOutlet weak var scoreLabel: UILabel?
    @IBOutlet weak var inputField: UITextField?
    
    var score:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRandomNumberLable()
        updateScoreLabel()
        
        print("view did load before addtarget")
        inputField?.addTarget(self, action: #selector(textFieldDidChange(textField:)),
                              for: UIControlEvents.editingDidEndOnExit)
        print("view did load after addtarget")
        clearInput()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func textFieldDidChange(textField: UITextField)
    {
        print("in text field did change 1")
        if inputField?.text?.count ?? 0 < 4 {
            print("in text field did change 2")

            return
        }
        print("in text field did change 3")

        if let numbers_text = numbersLable?.text,
           let input_text = inputField?.text,
           let numbers = Int(numbers_text),
           let input = Int(input_text)
        {
            print("comparing: \(input) \(numbers_text) \(input - numbers)")
            
            if input - numbers == 1111
            {
                print("Correct.")
                score += 1
            } else {
                score -= 1
            }
        }
        
        setRandomNumberLable()
        updateScoreLabel()
        clearInput()
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = "\(score)"
    }
    
    func clearInput() {
        inputField?.text = ""
        
        inputField?.becomeFirstResponder()
    }
    
    func setRandomNumberLable() {
        numbersLable?.text = "\(generateRandomNumber())"
    }
    
    func generateRandomNumber() -> Int {
        var result:Int = 0
        for _ in 1...4 {
            let digit = Int(arc4random_uniform(10))
            result = result * 10 + digit
            print("\(result)")
        }
        return result
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
