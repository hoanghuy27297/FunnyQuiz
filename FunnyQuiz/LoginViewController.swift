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
        
        // fetch areas quiz data
        let mathFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Math")
        mathFetchRequest.returnsObjectsAsFaults = false
        let geographyFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Geography")
        geographyFetchRequest.returnsObjectsAsFaults = false
        let literatureFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Literature")
        literatureFetchRequest.returnsObjectsAsFaults = false

        do {
            let mathResult = try managedObjectContext.fetch(mathFetchRequest)
            let geographyResult = try managedObjectContext.fetch(geographyFetchRequest)
            let literatureResult = try managedObjectContext.fetch(literatureFetchRequest)

            if mathResult.count == 0 {
                addMathData()
            }
            if geographyResult.count == 0 {
                addGeographyData()
            }
            if literatureResult.count == 0 {
                addLiteratureData()
            }
        } catch _ {
            print("Get quiz data error")
        }
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        errorMessage.text = ""
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
                            homeVC.loggedInUser = data as? User
                            self.navigationController?.pushViewController(homeVC, animated: true)
                        } else {
                            errorMessage.text = "Password is incorrect. Please try again!"
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
    
    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
    
    func addMathData() {
        let question1 = Math(context: managedObjectContext)
        question1.question = "10 + 20"
        question1.result = "30"

        let question2 = Math(context: managedObjectContext)
        question2.question = "15 + 25"
        question2.result = "40"

        let question3 = Math(context: managedObjectContext)
        question3.question = "18 + 22"
        question3.result = "40"

        let question4 = Math(context: managedObjectContext)
        question4.question = "36 + 66"
        question4.result = "102"

        let question5 = Math(context: managedObjectContext)
        question5.question = "123 + 456"
        question5.result = "579"

        let question6 = Math(context: managedObjectContext)
        question6.question = "10 - 20"
        question6.result = "-10"

        let question7 = Math(context: managedObjectContext)
        question7.question = "15 - 25"
        question7.result = "-10"

        let question8 = Math(context: managedObjectContext)
        question8.question = "18 - 22"
        question8.result = "-4"

        let question9 = Math(context: managedObjectContext)
        question9.question = "66 - 36"
        question9.result = "30"

        let question10 = Math(context: managedObjectContext)
        question10.question = "456 - 123"
        question10.result = "333"

        let question11 = Math(context: managedObjectContext)
        question11.question = "10 x 20"
        question11.result = "200"

        let question12 = Math(context: managedObjectContext)
        question12.question = "15 x 20"
        question12.result = "300"

        let question13 = Math(context: managedObjectContext)
        question13.question = "5 x 25"
        question13.result = "125"

        let question14 = Math(context: managedObjectContext)
        question14.question = "412 ÷ 4"
        question14.result = "103"

        let question15 = Math(context: managedObjectContext)
        question15.question = "123 ÷ 3"
        question15.result = "41"
        
        // save to storage
        do {
            try managedObjectContext.save()
        } catch _ {
            print("Save math data error!")
        }
    }
    
    func addGeographyData() {
        let question1 = Geography(context: managedObjectContext)
        question1.question = "In which American city is the Golden Gate Bridge located?"
        question1.firstOption = "San Francisco"
        question1.secondOption = "New York"
        question1.thirdOption = "Las Vegas"
        question1.fourthOption = "Los Angeles"
        question1.result = "San Francisco"
        
        let question2 = Geography(context: managedObjectContext)
        question2.question = "What is the capital of Thailand?"
        question2.firstOption = "Chiang Mai"
        question2.secondOption = "Bangkok"
        question2.thirdOption = "Phuket"
        question2.fourthOption = "Pattaya City"
        question2.result = "Bangkok"
        
        let question3 = Geography(context: managedObjectContext)
        question3.question = "Cairo is the capital of which country?"
        question3.firstOption = "Vietnam"
        question3.secondOption = "Austria"
        question3.thirdOption = "Egypt"
        question3.fourthOption = "Hungary"
        question3.result = "Egypt"
        
        let question4 = Geography(context: managedObjectContext)
        question4.question = "What is the capital of England?"
        question4.firstOption = "Manchester"
        question4.secondOption = "Liverpool"
        question4.thirdOption = "Newcastle"
        question4.fourthOption = "London"
        question4.result = "London"
        
        let question5 = Geography(context: managedObjectContext)
        question5.question = "What is the capital city of Canada?"
        question5.firstOption = "Ottawa"
        question5.secondOption = "Toronto"
        question5.thirdOption = "Vancouver"
        question5.fourthOption = "Victoria"
        question5.result = "Ottawa"
        
        let question6 = Geography(context: managedObjectContext)
        question6.question = "Madagascar is surrounded by which ocean?"
        question6.firstOption = "Atlantic Ocean"
        question6.secondOption = "Indian Ocean"
        question6.thirdOption = "Pacific Ocean"
        question6.fourthOption = "Arctic Ocean"
        question6.result = "Indian Ocean"
        
        let question7 = Geography(context: managedObjectContext)
        question7.question = "Which country is the second biggest in the world?"
        question7.firstOption = "China"
        question7.secondOption = "USA"
        question7.thirdOption = "Canada"
        question7.fourthOption = "Australia"
        question7.result = "Canada"
        
        let question8 = Geography(context: managedObjectContext)
        question8.question = "Which is the largest country in the world?"
        question8.firstOption = "USA"
        question8.secondOption = "China"
        question8.thirdOption = "Canada"
        question8.fourthOption = "Russia"
        question8.result = "Russia"
        
        let question9 = Geography(context: managedObjectContext)
        question9.question = "The US consists of how many states?"
        question9.firstOption = "50"
        question9.secondOption = "51"
        question9.thirdOption = "52"
        question9.fourthOption = "53"
        question9.result = "50"
        
        let question10 = Geography(context: managedObjectContext)
        question10.question = "Which country has the largest population in the world?"
        question10.firstOption = "USA"
        question10.secondOption = "China"
        question10.thirdOption = "Russia"
        question10.fourthOption = "England"
        question10.result = "China"
        
        let question11 = Geography(context: managedObjectContext)
        question11.question = "What is the color of the motorways on road maps of the UK?"
        question11.firstOption = "Yellow"
        question11.secondOption = "Red"
        question11.thirdOption = "Blue"
        question11.fourthOption = "White"
        question11.result = "Blue"
        
        let question12 = Geography(context: managedObjectContext)
        question12.question = "What is the largest country in Scandinavia?"
        question12.firstOption = "Hungary"
        question12.secondOption = "Sweden"
        question12.thirdOption = "German"
        question12.fourthOption = "Austria"
        question12.result = "Sweden"
        
        let question13 = Geography(context: managedObjectContext)
        question13.question = "What is the hottest continent on Earth?"
        question13.firstOption = "America"
        question13.secondOption = "Europe"
        question13.thirdOption = "Asia"
        question13.fourthOption = "Africa"
        question13.result = "Africa"
        
        let question14 = Geography(context: managedObjectContext)
        question14.question = "Dublin is the largest city in which country?"
        question14.firstOption = "Ireland"
        question14.secondOption = "England"
        question14.thirdOption = "French"
        question14.fourthOption = "Italy"
        question14.result = "Ireland"
        
        let question15 = Geography(context: managedObjectContext)
        question15.question = "What is a nickname for New York City?"
        question15.firstOption = "The Big City"
        question15.secondOption = "The Wolf"
        question15.thirdOption = "The Big Apple"
        question15.fourthOption = "The Small Apple"
        question15.result = "The Big Apple"
    }
    
    func addLiteratureData() {
        let question1 = Literature(context: managedObjectContext)
        question1.question = "The Invisible Man , a classic science fiction novel, was written by what author?"
        question1.firstOption = "Robert Louis Stevenson"
        question1.secondOption = "H. G. Wells"
        question1.thirdOption = "Oscar Wilde"
        question1.fourthOption = "Jules Vern"
        question1.result = "H. G. Wells"
        
        let question2 = Literature(context: managedObjectContext)
        question2.question = "Which one of the following was not one of The Three Musketeers?"
        question2.firstOption = "Aramis"
        question2.secondOption = "Athos"
        question2.thirdOption = "D' Artagnan"
        question2.fourthOption = "Porthos"
        question2.result = "D' Artagnan"
        
        let question3 = Literature(context: managedObjectContext)
        question3.question = "Where would one find Munchkin Country, Quadling Country, Gillikin Country and Winkie Country?"
        question3.firstOption = "The Land of Oz"
        question3.secondOption = "Middle Earth"
        question3.thirdOption = "Never-Never land"
        question3.fourthOption = "Transylvania"
        question3.result = "The Land of Oz"
        
        let question4 = Literature(context: managedObjectContext)
        question4.question = "Who wrote Rip Van Winkle?"
        question4.firstOption = "James Fenimore Cooper"
        question4.secondOption = "Nathaniel Hawthorne"
        question4.thirdOption = "Washington Irving"
        question4.fourthOption = "Robert Louis Stevenson"
        question4.result = "Washington Irving"
        
        let question5 = Literature(context: managedObjectContext)
        question5.question = "Who wrote the sonnet that starts out \"Much  have I travell'd in the realms of gold\"?"
        question5.firstOption = "John Donne"
        question5.secondOption = "John Keats"
        question5.thirdOption = "John Milton"
        question5.fourthOption = "John Smith"
        question5.result = "John Keats"
        
        let question6 = Literature(context: managedObjectContext)
        question6.question = "In The Phantom Tollbooth, a Norton Juster's  1962 novel, the city of Dictionopolis is the rival of what other city?"
        question6.firstOption = "Alphaville"
        question6.secondOption = "Audiopolis"
        question6.thirdOption = "Digitopolis"
        question6.fourthOption = "Metropolis"
        question6.result = "Digitopolis"
        
        let question7 = Literature(context: managedObjectContext)
        question7.question = "Edward Lear is famous for what kind of poem?"
        question7.firstOption = "ballad"
        question7.secondOption = "limerick"
        question7.thirdOption = "sonnet"
        question7.fourthOption = "freedom"
        question7.result = "limerick"
        
        let question8 = Literature(context: managedObjectContext)
        question8.question = "The lines, \"Oh, East is East and West is West, / And never the twain shall meet\" were written by whom?"
        question8.firstOption = "Lord Byron"
        question8.secondOption = "G.K. Chesterton"
        question8.thirdOption = "Thomas Hood"
        question8.fourthOption = "Rudyard Kipling"
        question8.result = "Rudyard Kipling"
        
        let question9 = Literature(context: managedObjectContext)
        question9.question = "Who wrote the early science fiction work titled \"Voyage to the Moon\"?"
        question9.firstOption = "Francis Bacon"
        question9.secondOption = "Cyrano de Bergerac"
        question9.thirdOption = "Rene Descartes"
        question9.fourthOption = "William Shakespeare"
        question9.result = "Rene Descartes"
        
        let question10 = Literature(context: managedObjectContext)
        question10.question = "From Gulliver's Travels, in what year was Lemuel Gulliver ship wrecked on Lilliput?"
        question10.firstOption = "1599"
        question10.secondOption = "1699"
        question10.thirdOption = "1799"
        question10.fourthOption = "1899"
        question10.result = "1699"
        
        let question11 = Literature(context: managedObjectContext)
        question11.question = "Which of the following authors was not also a doctor?"
        question11.firstOption = "Anton Chekhov"
        question11.secondOption = "Somerset Maugham"
        question11.thirdOption = "Voltaire"
        question11.fourthOption = "William Carlos Williams"
        question11.result = "Voltaire"
        
        let question12 = Literature(context: managedObjectContext)
        question12.question = "In Alice in Wonderland, which character is most often seen weeping?"
        question12.firstOption = "Bill the Lizard"
        question12.secondOption = "the Dormouse"
        question12.thirdOption = "the Gryphon"
        question12.fourthOption = "the Mock Turtle"
        question12.result = "the Mock Turtle"
        
        let question13 = Literature(context: managedObjectContext)
        question13.question = "What subject are the series of books, Birnbaum, Fielding, Fodor, and Frommer written about?"
        question13.firstOption = "cooking"
        question13.secondOption = "computers"
        question13.thirdOption = "nature"
        question13.fourthOption = "travel"
        question13.result = "travel"
        
        let question14 = Literature(context: managedObjectContext)
        question14.question = "In Charles Dickens's novel \"A Tale of Two Cities\", what are names of the two cities?"
        question14.firstOption = "Boston and New York"
        question14.secondOption = "Rome and Venice"
        question14.thirdOption = "Brussels and Moscow"
        question14.fourthOption = "London and Paris"
        question14.result = "London and Paris"
        
        let question15 = Literature(context: managedObjectContext)
        question15.question = "In a Mark twain novel, a mechanic from what New England state went back in time and visited King Arthur's court?"
        question15.firstOption = "Massachusetts"
        question15.secondOption = "Connecticut"
        question15.thirdOption = "Rhode Island"
        question15.fourthOption = "New Hampshire"
        question15.result = "Connecticut"
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
