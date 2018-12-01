//
//  ViewController.swift
//  Flashcards
//
//  Created by Sandro on 10/13/18.
//  Copyright © 2018 vasikoRago. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    var flashcards = [Flashcard]()
    
    var currentIndex = 0
    
    
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
        
        readSavedFlashcards()
        
        if flashcards.count == 0{
            updateFlashcard(question: "Whats the Capital of Brazil?", answer: "Brasil", extraAnswerOne: "Washington D.C.", extraAnswerTwo: "Kiev", isExisting: true)
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
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
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count-1{
            nextButton.isEnabled = false
        }
        else{
            nextButton.isEnabled = true
        }
        
        if currentIndex == 0{
            prevButton.isEnabled = false
        } else {
            prevButton.isEnabled = true
        }
    }
    
    func updateFlashcard(question: String, answer: String, extraAnswerOne: String?, extraAnswerTwo: String?, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer)
        
        if isExisting{
            flashcards[currentIndex] = flashcard
        } else {
            flashcards.append(flashcard)
            
            print("🤩 Added a new flashcard")
            print("🤩 We now have \(flashcards.count) flashcard(s)")
            
            currentIndex = flashcards.count - 1
            print("🤩 Our current index is \(currentIndex)")
        }
        
        
        frontLabel.text = question;
        backLabel.text = answer;
        
        btnOptionOne.isHidden = false
        btnOptionTwo.isHidden = false
        btnOptionThree.isHidden = false

        btnOptionOne.setTitle(answer, for: .normal)
        btnOptionTwo.setTitle(extraAnswerOne, for: .normal)
        btnOptionThree.setTitle(extraAnswerTwo, for: .normal)
        
        updateNextPrevButtons()
        
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        frontLabel.isHidden = true;
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        btnOptionTwo.isHidden = true;
        //
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true;
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1

        updateLabels()
        
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnPrevious(_ sender: Any) {
        currentIndex = currentIndex - 1
        
        updateLabels()
        
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        print("Deleting...")
        flashcards.remove(at: currentIndex)
        
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        
        if currentIndex < 0 {
            currentIndex = 0
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self;
        
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = frontLabel.text
            creationController.initialAnswer = backLabel.text
        }
    }
    
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        print("🤟 Flaschards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    
}

