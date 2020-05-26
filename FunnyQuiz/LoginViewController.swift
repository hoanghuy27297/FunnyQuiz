//
//  LoginViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 25/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

import CoreData

class LoginViewController: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var loginViewContainer: UIView!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewContainer.alpha = 0
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseIn, animations: {
            // animation for app's name
            let scaleTransAppName = CGAffineTransform(scaleX: 0.7, y: 0.7)
            let translateTransAppName = CGAffineTransform(translationX: 0, y: -125)
            self.appName.transform = scaleTransAppName.concatenating(translateTransAppName)
            
            // animation for login view container
            let translateTransLoginView = CGAffineTransform(translationX: 0, y: -125)
            self.loginViewContainer.transform = translateTransLoginView
            self.loginViewContainer.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        let emailInput = email.text
        let passwordInput = password.text
        if (emailInput != "" && passwordInput != "") {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            request.predicate = NSPredicate(format: "email = %@", email.text!)
            request.returnsObjectsAsFaults = false

            do {
                let result = try managedObjectContext.fetch(request)

                if result.count > 0 {
                    for data in result as! [NSManagedObject] {
                        let passwordFromData = data.value(forKey: "password") as! String
                        if passwordInput! == passwordFromData {
                            let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        }
                    }
                } else {
                    errorMessage.text = "Account is not existed. Please try again!"
                }
            } catch _ {
                errorMessage.text = "Some errors might occurred. Please try again!"
            }
        } else {
            errorMessage.text = "Email or password is empty. Please try again!"
        }
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

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.3
      layer.shadowOffset = CGSize(width: 1, height: 0)
      layer.shadowRadius = 5

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
