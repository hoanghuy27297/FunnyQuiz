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

    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get random 5 question from Math data
        let mathFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Math")
        mathFetchRequest.returnsObjectsAsFaults = false
        
        do {
            let mathResult = try managedObjectContext.fetch(mathFetchRequest)
            for i in 1...5 {
                let randomIndex = Int.random(in: 0...mathResult.count - 1)
                let quiz: Math = mathResult[randomIndex] as! Math
                print(quiz.question!)
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
        } catch _ {
            print("Get math data errors")
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
