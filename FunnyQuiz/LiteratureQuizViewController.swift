//
//  LiteratureQuizViewController.swift
//  FunnyQuiz
//
//  Created by Huy Hoang on 27/5/20.
//  Copyright © 2020 Huy Hoang. All rights reserved.
//

import UIKit

class LiteratureQuizViewController: UIViewController {

    var loggedInUser: User? = nil
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
