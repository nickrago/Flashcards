//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Sandro on 11/10/18.
//  Copyright © 2018 vasikoRago. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraOne: UITextField!
    @IBOutlet weak var extraTwo: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionTextField.text
        let answerText = answerTextField.text
        let extraOneText = extraOne.text
        let extraTwoText = extraTwo.text
        
        
        if (questionText == nil || answerText == nil || extraOneText == nil || extraTwoText == nil || questionText!.isEmpty || answerText!.isEmpty || extraOneText!.isEmpty || extraTwoText!.isEmpty){
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter a question, an answer, and two wrong answers", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        else{
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extraAnswerOne: extraOneText!, extraAnswerTwo: extraTwoText!)
            
            dismiss(animated:true)
        }
        
        
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
