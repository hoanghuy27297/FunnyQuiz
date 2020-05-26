//
//  UpdatePasswordViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 26/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    var loggedInUser: User? = nil
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitBtn(_ sender: Any) {
        if password.text == confirmPassword.text {
            loggedInUser?.password = password.text
            
            do {
                try managedObjectContext.save()
                dismiss()
            } catch _ {
                let alertController = UIAlertController(title: "Error", message: "Some errors has occurred. Please try again!", preferredStyle: .alert)

                let acceptAction = UIAlertAction(title: "OK", style: .default, handler: nil)

                alertController.addAction(acceptAction)

                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            errorMessage.text = "Confirm password is not matched with password. Please try again!"
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
