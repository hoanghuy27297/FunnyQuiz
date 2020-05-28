//
//  HomeViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 26/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mathViewButton: UIButton!
    @IBOutlet weak var geographyViewButton: UIButton!
    @IBOutlet weak var literatureViewButton: UIButton!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    @IBOutlet weak var overallLabel: UILabel!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var frc = NSFetchedResultsController<NSFetchRequestResult>()

    var loggedInUser: User? = nil
    var dismissPoint: Int16 = 0
    var isDismissed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mathViewButton.dropShadow()
        geographyViewButton.dropShadow()
        literatureViewButton.dropShadow()
        
        overallLabel.text = "Hi \(loggedInUser?.name ?? ""), you have earned \(loggedInUser?.totalPoints ?? 0) points in the following attempts"
        
        frc = getFetchedResultsController()
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch _ {
            print("Get attempt data error")
        }
        
    }

    @IBAction func logoutBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Goodbye", message: "\(loggedInUser?.name ?? ""), you have overall \(loggedInUser?.totalPoints ?? 0) points", preferredStyle: .alert)

        let acceptAction = UIAlertAction(title: "OK", style: .default, handler: {(action) in self.logout()})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func logout() {
        performSegue(withIdentifier: "unwindSegueToLogin", sender: self)
    }

    @IBAction func intructionBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "Intruction", message: "Choose an intruction area to know more about how to do the quiz", preferredStyle: .actionSheet)

        let mathAction = UIAlertAction(title: "Math", style: .default, handler: {(action) -> Void in let alertController = UIAlertController(title: "Math intruction", message: "To do the math quizzes, you must fill in your answers in the text field next to the question. Goodluck!", preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(acceptAction)
            self.present(alertController, animated: true, completion: nil)
        })
        let geoAction = UIAlertAction(title: "Geography", style: .default, handler: {(action) -> Void in let alertController = UIAlertController(title: "Geography intruction", message: "To do the geography quizzes, read carefully the question and options of answers. Choose your answer by click to the button and click next to go to the next question. You are also able to go back to previous answer if you want to change it. Goodluck!", preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(acceptAction)
            self.present(alertController, animated: true, completion: nil)
        })
        let literAction = UIAlertAction(title: "Literature", style: .default, handler: {(action) -> Void in let alertController = UIAlertController(title: "Literature intruction", message: "To do the literature quizzes, read carefully the question and options of answers. Choose your answer by click to the button and click next to go to the next question. You are also able to go back to previous answer if you want to change it. Goodluck!", preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(acceptAction)
            self.present(alertController, animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alertController.addAction(mathAction)
        alertController.addAction(geoAction)
        alertController.addAction(literAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return (frc.sections?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (frc.sections?[section].numberOfObjects)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        let attempt = frc.object(at: indexPath as IndexPath) as! Attempts
        cell.textLabel?.text = "\"\(attempt.area ?? "")\" area - attempt started on \(attempt.date ?? "") - points earned \(attempt.points)"
        
        return cell
    }
    
    func getFetchedResultsController(_ key: String = "area") -> NSFetchedResultsController<NSFetchRequestResult>{
        frc = NSFetchedResultsController(fetchRequest: listFetchRequest(key), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }

    func listFetchRequest(_ key: String = "area") -> NSFetchRequest<NSFetchRequestResult>{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Attempts")
        fetchRequest.predicate = NSPredicate(format: "ofUser.email = %@", loggedInUser?.email ?? "")
        let sortDescriptor = NSSortDescriptor(key: key, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    @IBAction func sortAreaBtn(_ sender: Any) {
        frc = getFetchedResultsController()
        frc.delegate = self
        
        do {
            try frc.performFetch()
            tableView.reloadData()
        } catch _ {
            print("Get attempt data error")
        }
    }
    
    @IBAction func sortDateBtn(_ sender: Any) {
        frc = getFetchedResultsController("date")
        frc.delegate = self
        
        do {
            try frc.performFetch()
            tableView.reloadData()
        } catch _ {
            print("Get attempt data error")
        }
    }
    
    func controllerDidChangeContent(_ content: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
        overallLabel.text = "Hi \(loggedInUser?.name ?? ""), you have earned \(loggedInUser?.totalPoints ?? 0) points in the following attempts"
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

