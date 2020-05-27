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

    // initialize user answers array with empty answers as default
    var ansArray = Array(repeating: "", count: 5)

    override func viewDidLoad() {
        super.viewDidLoad()
        // prevQuestionButton is not appear from beginning
        prevViewButton.alpha = 0
        
        // set answer buttons initial colors
        optionA.backgroundColor = UIColor.systemBlue
        optionB.backgroundColor = UIColor.systemBlue
        optionC.backgroundColor = UIColor.systemBlue
        optionD.backgroundColor = UIColor.systemBlue
        
        // Get random 5 question from Math data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: quizArea)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
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
                        }
                    }
                }
            }
        } catch _ {
            print("Get quiz data errors")
        }
    }
    
    
    @IBAction func chooseAns(_ sender: UIButton) {
        ansArray[currentQuestionIndex] = sender.currentTitle!
        // reset colors
        switch sender.tag {
        case 1:
            optionA.backgroundColor = UIColor.blue
            optionB.backgroundColor = UIColor.systemBlue
            optionC.backgroundColor = UIColor.systemBlue
            optionD.backgroundColor = UIColor.systemBlue
        case 2:
            optionA.backgroundColor = UIColor.systemBlue
            optionB.backgroundColor = UIColor.blue
            optionC.backgroundColor = UIColor.systemBlue
            optionD.backgroundColor = UIColor.systemBlue
            break
        case 3:
            optionA.backgroundColor = UIColor.systemBlue
            optionB.backgroundColor = UIColor.systemBlue
            optionC.backgroundColor = UIColor.blue
            optionD.backgroundColor = UIColor.systemBlue
            break
        case 4:
            optionA.backgroundColor = UIColor.systemBlue
            optionB.backgroundColor = UIColor.systemBlue
            optionC.backgroundColor = UIColor.systemBlue
            optionD.backgroundColor = UIColor.blue
            break
        default:
            break
        }
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
                
                // update button colors if user has chosen the answer
                if ansArray[currentQuestionIndex] == quiz.firstOption {
                      optionA.backgroundColor = UIColor.blue
                      optionB.backgroundColor = UIColor.systemBlue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.secondOption {
                      optionA.backgroundColor = UIColor.systemBlue
                      optionB.backgroundColor = UIColor.blue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.thirdOption {
                     optionA.backgroundColor = UIColor.systemBlue
                     optionB.backgroundColor = UIColor.systemBlue
                     optionC.backgroundColor = UIColor.blue
                     optionD.backgroundColor = UIColor.systemBlue
                 } else if ansArray[currentQuestionIndex] == quiz.fourthOption {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.blue
                } else {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.systemBlue
                }
            } else {
                let quiz = geoQuizArray[currentQuestionIndex]
                question.text = "Question \(String(describing: currentQuestionIndex + 1)): \(quiz.question!)"
                optionA.setTitle(quiz.firstOption, for: .normal)
                optionB.setTitle(quiz.secondOption, for: .normal)
                optionC.setTitle(quiz.thirdOption, for: .normal)
                optionD.setTitle(quiz.fourthOption, for: .normal)
                
                // update button colors if user has chosen the answer
                if ansArray[currentQuestionIndex] == quiz.firstOption {
                      optionA.backgroundColor = UIColor.blue
                      optionB.backgroundColor = UIColor.systemBlue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.secondOption {
                      optionA.backgroundColor = UIColor.systemBlue
                      optionB.backgroundColor = UIColor.blue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.thirdOption {
                     optionA.backgroundColor = UIColor.systemBlue
                     optionB.backgroundColor = UIColor.systemBlue
                     optionC.backgroundColor = UIColor.blue
                     optionD.backgroundColor = UIColor.systemBlue
                 } else if ansArray[currentQuestionIndex] == quiz.fourthOption {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.blue
                } else {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.systemBlue
                }
            }
        } else {
            var correctAnsCount: Int16 = 0
            // calc correct answers
            for i in 0...ansArray.count - 1 {
                if quizArea == "Literature" {
                    if ansArray[i] == literQuizArray[i].result {
                        correctAnsCount += 1
                    }
                } else {
                    if ansArray[i] == geoQuizArray[i].result {
                        correctAnsCount += 1
                    }
                }
            }

            // calc incorrect ans
            let incorrectAnsCount: Int16 = 5 - correctAnsCount
            // calc earned points
            let earnedPoint: Int16 = correctAnsCount * 5 - incorrectAnsCount * 2
            
            // update total points of user
            loggedInUser?.totalPoints += earnedPoint
            do {
                try managedObjectContext.save()
            } catch _ {
                print("Save point error")
            }
            
            let message = "You have finished the '\(quizArea == "Literature" ? "Literature" : "Geography" )' quiz with \(correctAnsCount) correct \(incorrectAnsCount) incorrect answers. You have earned \(earnedPoint) points for this attempt. Overall you have \(loggedInUser?.totalPoints ?? 0) points."
            let alertController = UIAlertController(title: "Congratulation!", message: message, preferredStyle: .alert)

            let acceptAction = UIAlertAction(title: "OK", style: .default, handler: {action in self.dismiss()})

            alertController.addAction(acceptAction)

            self.present(alertController, animated: true, completion: nil)
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
                
                // update button colors if user has chosen the answer
                if ansArray[currentQuestionIndex] == quiz.firstOption {
                      optionA.backgroundColor = UIColor.blue
                      optionB.backgroundColor = UIColor.systemBlue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.secondOption {
                      optionA.backgroundColor = UIColor.systemBlue
                      optionB.backgroundColor = UIColor.blue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.thirdOption {
                     optionA.backgroundColor = UIColor.systemBlue
                     optionB.backgroundColor = UIColor.systemBlue
                     optionC.backgroundColor = UIColor.blue
                     optionD.backgroundColor = UIColor.systemBlue
                 } else if ansArray[currentQuestionIndex] == quiz.fourthOption {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.blue
                } else {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.systemBlue
                }
            } else {
                let quiz = geoQuizArray[currentQuestionIndex]
                question.text = "Question \(String(describing: currentQuestionIndex + 1)): \(quiz.question!)"
                optionA.setTitle(quiz.firstOption, for: .normal)
                optionB.setTitle(quiz.secondOption, for: .normal)
                optionC.setTitle(quiz.thirdOption, for: .normal)
                optionD.setTitle(quiz.fourthOption, for: .normal)
                
                // update button colors if user has chosen the answer
                if ansArray[currentQuestionIndex] == quiz.firstOption {
                      optionA.backgroundColor = UIColor.blue
                      optionB.backgroundColor = UIColor.systemBlue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.secondOption {
                      optionA.backgroundColor = UIColor.systemBlue
                      optionB.backgroundColor = UIColor.blue
                      optionC.backgroundColor = UIColor.systemBlue
                      optionD.backgroundColor = UIColor.systemBlue
                  } else if ansArray[currentQuestionIndex] == quiz.thirdOption {
                     optionA.backgroundColor = UIColor.systemBlue
                     optionB.backgroundColor = UIColor.systemBlue
                     optionC.backgroundColor = UIColor.blue
                     optionD.backgroundColor = UIColor.systemBlue
                 } else if ansArray[currentQuestionIndex] == quiz.fourthOption {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.blue
                } else {
                    optionA.backgroundColor = UIColor.systemBlue
                    optionB.backgroundColor = UIColor.systemBlue
                    optionC.backgroundColor = UIColor.systemBlue
                    optionD.backgroundColor = UIColor.systemBlue
                }
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
