//
//  DetailViewController.swift
//  ProContractorList
//
//  Created by Anthony Hauger on 11/15/18.
//  Copyright © 2018 HomeAdvisorScreening. All rights reserved.
//

/**************** DOCUMENTATION ****************
 Purpose:
 To create and format the details view controller for the Professional sent to this View Controller
 
 Description:
 1. Create outlets for all labels and buttons
 2. Create global variables to be accessed from the ViewController.swift file
 3. Created actions for the CALL and EMAIL buttons on press (print phone or email = <company phone or company email>
 4. Formatted all labels and buttons according to specifications
 
 Details:
 ALL CONSTRAINTS ARE FOUND IN THE IB
    
 Last Modified:
 18 November 18 - Created Actions for the CALL and EMAIL buttons.  Part 1 Completed
 16 November 18 - Finished formatting for labels, need to figure out font for Buttons
 15 November 18 - Initial Creation. Created outlets for all buttons and labels and some formatting for most labels
**************** DOCUMENTATION ****************/
import UIKit

class ProfessionalDetail: UIViewController {
    
    //label outlets to allow me to change the text
    @IBOutlet weak var proLabel: UILabel!
    @IBOutlet weak var specialtyLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var servicesLabel: UILabel!
    @IBOutlet weak var overviewView: UITextView!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    //variable declarations to be accessed globally
    var companyName = ""
    var companySpecialty = ""
    var companyRating = ""
    var companyNumRatings = ""
    var companyLocation = ""
    var companyServices = ""
    var companyOverview = ""
    var companyPhone = ""
    var companyEmail = ""
    
    //set call button press action
    @IBAction func callPress(_ sender: Any) {
        print("phone = \(self.companyPhone)")
    }
    
    //set email button press action
    @IBAction func emailPress(_ sender: Any) {
        print("email = \(self.companyEmail)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navbar title
        self.title="Details"
        
        //cast ratings and numRatings to allow for logic to be used in formatting
        let intNumRatings: Int? = Int(self.companyNumRatings)
        
        //set and format the pro label
        proLabel.text = self.companyName
        proLabel.font = UIFont(name:"System Font Bold", size: 20.0)
        
        //set and format the services label
        specialtyLabel.text=self.companySpecialty
        specialtyLabel.font=UIFont(name:"System Font Medium", size: 18.0)
        
        //set and format the ratings label
        if intNumRatings! == 0 {
            ratingLabel.text = "References Available"
        } else {
            ratingLabel.text = "Ratings: \(self.companyRating) | \(self.companyNumRatings) rating(s)"
        }
        ratingLabel.textColor = UIColor.black
        ratingLabel.font = UIFont(name:"System Font Bold", size: 16.0)
        
        //set and format primary location label
        locationLabel.text = self.companyLocation
        locationLabel.font = UIFont(name:"System Font", size: 16.0)
        
        //set and format services label
        servicesLabel.text = self.companyServices
        servicesLabel.font = UIFont(name:"System Font", size: 16.0)
        
        //set and format the overview Text View
        overviewView.text=self.companyOverview
        overviewView.font = UIFont(name:"System Font", size: 14.0)
        
        //set and format the phone button
        phoneButton.setTitle("CALL", for: .normal)
        phoneButton.titleLabel?.font = .systemFont(ofSize: 16.0)
        
        //set and format the email button
        emailButton.setTitle("EMAIL", for: .normal)
        emailButton.titleLabel?.font = .systemFont(ofSize: 16.0)
    }
}
