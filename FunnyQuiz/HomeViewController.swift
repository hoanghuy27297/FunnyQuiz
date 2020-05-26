//
//  HomeViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 26/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func userActionBtn(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)

        let changePasswordAction = UIAlertAction(title: "Change password", style: .default, handler: {(action) -> Void in print("I agree")})
        let checkPointAction = UIAlertAction(title: "Earned points", style: .default, handler: {(action) -> Void in print("I agree")})
        let logoutAction = UIAlertAction(title: "Log out", style: .destructive, handler: {(action) -> Void in print("I disagree")})
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) -> Void in print("Cancel button clicked")})

        alertController.addAction(changePasswordAction)
        alertController.addAction(checkPointAction)
        alertController.addAction(logoutAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
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
