//
//  SignupViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 25/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit
import CoreData

class SignupViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var frc = NSFetchedResultsController<NSFetchRequestResult>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        errorMessage.alpha = 0
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        errorMessage.alpha = 0
        let ent = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext)
        let newUser = User(entity: ent!, insertInto: managedObjectContext)
        
        if email.text != nil && password.text != nil && userName != nil {
            newUser.email = email.text!
            newUser.password = password.text!
            newUser.name = userName.text!
            do {
                try managedObjectContext.save()
                let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                self.navigationController?.pushViewController(homeVC, animated: true)
                print("Registered success!")
            } catch _ {
                errorMessage.alpha = 1
            }
        } else {
            errorMessage.text = "All fields must be not empty. Please try again!"
            errorMessage.alpha = 1
        }
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss()
    }

    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }


}
