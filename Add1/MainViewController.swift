//
//  MainViewController.swift
//  Add1
//
//  Created by itrump on 2018/10/15.
//  Copyright © 2018 fengxiaoyang. All rights reserved.
//

import UIKit
import MBProgressHUD

class MainViewController: UIViewController {
    
    @IBOutlet weak var numbersLable: UILabel?
    @IBOutlet weak var scoreLabel: UILabel?
    @IBOutlet weak var inputField: UITextField?
    @IBOutlet weak var timeLable: UILabel?
    
    var score:Int = 0
    var hud: MBProgressHUD?
    
    var timer: Timer?
    var seconds: Int = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hud = MBProgressHUD(view: self.view)
        if hud != nil
        {
            self.view.addSubview(hud!)
        }
        
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
                showHudWithAnswer(isRight: true)
            } else {
                if score > 0
                {
                    score -= 1
                }
                showHudWithAnswer(isRight: false)
            }
        }
        
        setRandomNumberLable()
        updateScoreLabel()
        clearInput()
        
        if (timer == nil)
        {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onUpdateTimer), userInfo: nil, repeats: true)
        }
        if score == 2
        {
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(onUpdateTimer), userInfo: nil, repeats: true)
        }
    }
    
    func updateTimerLable()
    {
        if (timeLable != nil)
        {
            let min: Int = (seconds / 60) % 60
            let sec: Int = seconds % 60
            
            let min_p: String = String(format: "%02d", min)
            let sec_p: String = String(format: "%02d", sec)
            
            timeLable?.text = "\(min_p):\(sec_p)"
        }
    }
    
    @objc func onUpdateTimer() -> Void
    {
        if (seconds > 0 && seconds <= 60)
        {
            seconds -= 1
            updateTimerLable()
        } else if (seconds <= 0)
        {
            if (timer != nil)
            {
                timer?.invalidate()
                timer = nil
                
                let alertController = UIAlertController(title: "Time up!", message: "Your time is up! Score: \(score)", preferredStyle: .alert)
                let restartAction = UIAlertAction(title: "Restart", style: .default, handler: nil)
                
                alertController.addAction(restartAction)
                self.present(alertController, animated: true, completion: nil)
                
                score = 0
                seconds = 60
                updateTimerLable()
                updateScoreLabel()
                setRandomNumberLable()
            }
        }
    }
    
    func showHudWithAnswer(isRight: Bool)
    {
        var imageView: UIImageView?
        if isRight
        {
            imageView = UIImageView(image: UIImage(named: "thumbs-up"))
        } else
        {
            imageView = UIImageView(image: UIImage(named: "thumbs-down"))
        }
        if (imageView != nil)
        {
            hud?.mode = MBProgressHUDMode.customView
            hud?.customView = imageView
            
            hud?.show(animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.hud?.hide(animated: true)
                self.inputField?.text = ""
            })
        }
    }
    
    func updateScoreLabel() {
        scoreLabel?.text = "\(score)"
    }
    
    func clearInput() {
        inputField?.text = ""
        
        print("\(String(describing: inputField?.becomeFirstResponder()))")
    }
    
    func setRandomNumberLable() {
        numbersLable?.text = String(format: "%04d", generateRandomNumber())
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
