//
//  MultipleChoiceQuestionViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 27/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit
import CoreData

class MultipleChoiceQuestionViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    
    @IBOutlet weak var nextViewButton: UIButton!
    @IBOutlet weak var prevViewButton: UIButton!
    
    var quizArea: String = "Geography"
    var loggedInUser: User? = nil
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var geoQuizArray = [Geography]()
    var literQuizArray = [Literature]()
    var currentQuestionIndex = 0
    var correctAns = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // prevQuestionButton is not appear from beginning
        prevViewButton.alpha = 0
        // Get random 5 question from Math data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: quizArea)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            print(quizArea)
            print(result)
            if result.count > 0 {
                for i in 1...5 {
                    let randomIndex = Int.random(in: 0...result.count - 1)
                    if quizArea == "Literature" {
                        let quiz = result[randomIndex] as! Literature
                        literQuizArray.append(quiz)
                        if i == 1 {
                            question.text = "Question 1: \(quiz.question!)"
                            optionA.setTitle(quiz.firstOption, for: .normal)
                            optionB.setTitle(quiz.secondOption, for: .normal)
                            optionC.setTitle(quiz.thirdOption, for: .normal)
                            optionD.setTitle(quiz.fourthOption, for: .normal)
                            correctAns = quiz.result!
                        }
                    } else {
                        let quiz = result[randomIndex] as! Geography
                        geoQuizArray.append(quiz)
                        if i == 1 {
                            question.text = "Question 1: \(quiz.question!)"
                            optionA.setTitle(quiz.firstOption, for: .normal)
                            optionB.setTitle(quiz.secondOption, for: .normal)
                            optionC.setTitle(quiz.thirdOption, for: .normal)
                            optionD.setTitle(quiz.fourthOption, for: .normal)
                            correctAns = quiz.result!
                        }
                    }
                }
            }
        } catch _ {
            print("Get quiz data errors")
        }
    }
    
    
    @IBAction func chooseAns(_ sender: UIButton) {
        print(sender.currentTitle)
    }
    
    
    @IBAction func nextBtn(_ sender: Any) {
        if currentQuestionIndex < 4 {
            currentQuestionIndex += 1
            if currentQuestionIndex > 0 {
                prevViewButton.alpha = 1
            }
            if currentQuestionIndex == 4 {
                nextViewButton.setTitle("Submit", for: .normal)
            }

            if quizArea == "Literature" {
                let quiz = literQuizArray[currentQuestionIndex]
                question.text = "Question \(String(describing: currentQuestionIndex + 1)): \(quiz.question!)"
                optionA.setTitle(quiz.firstOption, for: .normal)
                optionB.setTitle(quiz.secondOption, for: .normal)
                optionC.setTitle(quiz.thirdOption, for: .normal)
                optionD.setTitle(quiz.fourthOption, for: .normal)
                correctAns = quiz.result!
            } else {
                let quiz = geoQuizArray[currentQuestionIndex]
                question.text = "Question \(String(describing: currentQuestionIndex + 1)): \(quiz.question!)"
                optionA.setTitle(quiz.firstOption, for: .normal)
                optionB.setTitle(quiz.secondOption, for: .normal)
                optionC.setTitle(quiz.thirdOption, for: .normal)
                optionD.setTitle(quiz.fourthOption, for: .normal)
                correctAns = quiz.result!
            }
        } else {
            
        }
    }
    
    @IBAction func prevBtn(_ sender: Any) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            if currentQuestionIndex == 0 {
                prevViewButton.alpha = 0
            }
            if quizArea == "Literature" {
                let quiz = literQuizArray[currentQuestionIndex]
                question.text = "Question \(String(describing: currentQuestionIndex + 1)): \(quiz.question!)"
                optionA.setTitle(quiz.firstOption, for: .normal)
                optionB.setTitle(quiz.secondOption, for: .normal)
                optionC.setTitle(quiz.thirdOption, for: .normal)
                optionD.setTitle(quiz.fourthOption, for: .normal)
                correctAns = quiz.result!
            } else {
                let quiz = geoQuizArray[currentQuestionIndex]
                question.text = "Question \(String(describing: currentQuestionIndex + 1)): \(quiz.question!)"
                optionA.setTitle(quiz.firstOption, for: .normal)
                optionB.setTitle(quiz.secondOption, for: .normal)
                optionC.setTitle(quiz.thirdOption, for: .normal)
                optionD.setTitle(quiz.fourthOption, for: .normal)
                correctAns = quiz.result!
            }
        }

        
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss()
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
