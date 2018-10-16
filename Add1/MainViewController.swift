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
    @IBOutlet weak var inputField: UITextView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateRandomNumber() -> String {
        var result:String = ""
        for _ in 1...4 {
            let digit = Int(arc4random_uniform(10))
            result += "\(digit)"
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
