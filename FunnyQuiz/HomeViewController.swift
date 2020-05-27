//
//  HomeViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 26/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var mathViewButton: UIButton!
    @IBOutlet weak var geographyViewButton: UIButton!
    @IBOutlet weak var literatureViewButton: UIButton!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var loggedInUser: User? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mathViewButton.dropShadow()
        geographyViewButton.dropShadow()
        literatureViewButton.dropShadow()
    }

    @IBAction func logoutBtn(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToLogin", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "updatePasswordSegue" {
            let updatePasswordVC: UpdatePasswordViewController = segue.destination as! UpdatePasswordViewController
            updatePasswordVC.loggedInUser = loggedInUser
        } else if segue.identifier == "MathSegue" {
            let vc: AnswerQuestionViewController = segue.destination as! AnswerQuestionViewController
            vc.loggedInUser = loggedInUser
        } else if segue.identifier == "GeographySegue" {
            let vc: MultipleChoiceQuestionViewController = segue.destination as! MultipleChoiceQuestionViewController
            vc.loggedInUser = loggedInUser
            vc.quizArea = "Geography"
        } else if segue.identifier == "LiteratureSegue" {
            let vc: MultipleChoiceQuestionViewController = segue.destination as! MultipleChoiceQuestionViewController
            vc.loggedInUser = loggedInUser
            vc.quizArea = "Literature"
        }
    }
}
