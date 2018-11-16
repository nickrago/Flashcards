//
//  ViewController.swift
//  Flashcards
//
//  Created by Sandro on 10/13/18.
//  Copyright © 2018 vasikoRago. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //round the corners
        frontLabel.layer.cornerRadius = 20.1;
        frontLabel.clipsToBounds = true;
        backLabel.layer.cornerRadius = 20.0;
        backLabel.clipsToBounds = true;
        
        //customize buttons
        btnOptionOne.layer.borderWidth = 2.0
        btnOptionTwo.layer.borderWidth = 2.0
        btnOptionThree.layer.borderWidth = 2.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        btnOptionOne.layer.cornerRadius = 20.0;
        btnOptionTwo.layer.cornerRadius = 20.0;
        btnOptionThree.layer.cornerRadius = 20.0;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapFlashcard(_ sender: Any) {
        if(frontLabel.isHidden == true){
            frontLabel.isHidden = false;
        }
        else{
            frontLabel.isHidden = true;
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = "question"
        backLabel.text = "swer"
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        btnOptionTwo.isHidden = true;
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true;
    }
}

