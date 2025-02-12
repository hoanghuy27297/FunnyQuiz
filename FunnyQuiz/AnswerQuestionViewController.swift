//
//  AnswerQuestionViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 26/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit
import CoreData

class AnswerQuestionViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var firstQuestion: UILabel!
    @IBOutlet weak var secondQuestion: UILabel!
    @IBOutlet weak var thirdQuestion: UILabel!
    @IBOutlet weak var fourthQuestion: UILabel!
    @IBOutlet weak var fifthQuestion: UILabel!

    @IBOutlet weak var firstAnswer: UITextField!
    @IBOutlet weak var secondAnswer: UITextField!
    @IBOutlet weak var thirdAnswer: UITextField!
    @IBOutlet weak var fourthAnswer: UITextField!
    @IBOutlet weak var fifthAnswer: UITextField!

    var firstCorrectAnswer: String = ""
    var secondCorrectAnswer: String = ""
    var thirdCorrectAnswer: String = ""
    var fourthCorrectAnswer: String = ""
    var fifthCorrectAnswer: String = ""

    var loggedInUser: User? = nil
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get random 5 question from Math data
        let mathFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Math")
        mathFetchRequest.returnsObjectsAsFaults = false
        
        do {
            let mathResult = try managedObjectContext.fetch(mathFetchRequest)
            var indexArray = [Int]()
            if mathResult.count > 0 {
                for i in 1...5 {
                    var randomIndex = Int.random(in: 0...mathResult.count - 1)
                    // if randomIndex is duplicate with previous random index, keep get new random index
                    if indexArray.count > 0 {
                        while indexArray.contains(randomIndex) {
                            randomIndex = Int.random(in: 0...mathResult.count - 1)
                        }
                    }
                    indexArray.append(randomIndex)

                    let quiz: Math = mathResult[randomIndex] as! Math

                    switch i {
                        case 1:
                            firstQuestion.text = quiz.question!
                            firstCorrectAnswer = quiz.result!
                            break
                        case 2:
                            secondQuestion.text = quiz.question!
                            secondCorrectAnswer = quiz.result!
                            break
                        case 3:
                            thirdQuestion.text = quiz.question!
                            thirdCorrectAnswer = quiz.result!
                            break
                        case 4:
                            fourthQuestion.text = quiz.question!
                            fourthCorrectAnswer = quiz.result!
                            break
                        case 5:
                            fifthQuestion.text = quiz.question!
                            fifthCorrectAnswer = quiz.result!
                            break
                        default:
                            print("Error")
                            break
                    }
                }
            }
        } catch _ {
            print("Get math data errors")
        }
    }

    @IBAction func submitBtn(_ sender: Any) {
        var correctAnsCount: Int16 = 0
        
        // check correct answer
        if firstAnswer.text == firstCorrectAnswer {
            correctAnsCount += 1
        }
        if secondAnswer.text == secondCorrectAnswer {
            correctAnsCount += 1
        }
        if thirdAnswer.text == thirdCorrectAnswer {
            correctAnsCount += 1
        }
        if fourthAnswer.text == fourthCorrectAnswer {
            correctAnsCount += 1
        }
        if fifthAnswer.text == fifthCorrectAnswer {
            correctAnsCount += 1
        }

        // calc incorrect ans
        let incorrectAnsCount: Int16 = 5 - correctAnsCount
        // calc earned points
        let earnedPoint: Int16 = correctAnsCount * 5 - incorrectAnsCount * 2
        
        // update total points of user
        loggedInUser?.totalPoints += earnedPoint
        
        // add attempt
        let attempt = Attempts(context: managedObjectContext)
        attempt.area = "Math"
        attempt.points = earnedPoint
        
        // add attempt time
        let date = DateFormatter()
        date.dateFormat = "HH:mm dd/MM/yyyy"
        date.timeZone = TimeZone.current
        attempt.date = date.string(from: Date())
        
        // add attempt to user
        attempt.ofUser = loggedInUser

        do {
            try managedObjectContext.save()
        } catch _ {
            print("Save point error")
        }
        
        let message = "You have finished the 'Math' quiz with \(correctAnsCount) correct \(incorrectAnsCount) incorrect answers. You have earned \(earnedPoint) points for this attempt. Overall you have \(loggedInUser?.totalPoints ?? 0) points."
        let alertController = UIAlertController(title: "Congratulation!", message: message, preferredStyle: .alert)

        let acceptAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.dismiss()})

        alertController.addAction(acceptAction)

        self.present(alertController, animated: true, completion: nil)
        
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
