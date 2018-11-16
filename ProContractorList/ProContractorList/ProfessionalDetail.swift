//
//  DetailViewController.swift
//  ProContractorList
//
//  Created by Anthony Hauger on 11/15/18.
//  Copyright © 2018 HomeAdvisorScreening. All rights reserved.
//

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
    
    var companyName = ""
    var companySpecialty = ""
    var companyRating = ""
    var companyNumRatings = ""
    var companyLocation = ""
    var companyServices = ""
    var companyOverview = ""
    var companyPhone = ""
    var companyEmail = ""
    
    /*
    func setLabels(name: String, specialty: String?, rating: String, numRatings:String, location: String, services: String, overview: String, phone: String, email: String){
        
        //cast ratings and numRatings to allow for logic to be used in formatting
        let floatRating: Float? = Float(rating)
        let intNumRatings: Int? = Int(numRatings)
        
        //set and format the pro label
        proLabel.text = name
        proLabel.font = UIFont(name:"System Font Bold", size: 20.0)
        
        //set and format the ratings label
        if intNumRatings! == 0 {
            ratingLabel.text = "References Available"
            ratingLabel.textColor = UIColor.black
        } else {
            ratingLabel.text = "Rating: \(rating) | \(numRatings) rating(s)"
            
            if floatRating! >= 4.0 {
                ratingLabel.textColor = UIColor.green
            } else if (floatRating! < 4.0) && (floatRating! >= 3.0) {
                ratingLabel.textColor = UIColor.orange
            } else {
                ratingLabel.textColor = UIColor.red
            }
        }
        
        //set and format the services label
        specialtyLabel.text=specialty
        
        //set and format the overview Text View
        overviewView.text=overview
        
        //set and format the phone button
        phoneButton.setTitle("CALL", for: .normal)
        emailButton.setTitle("EMAIL", for: .normal)
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navbar title
        self.title="Details"
        
        //cast ratings and numRatings to allow for logic to be used in formatting
        let floatRating: Float? = Float(self.companyRating)
        let intNumRatings: Int? = Int(self.companyNumRatings)
        
        //set and format the pro label
        proLabel.text = self.companyName
        proLabel.font = UIFont(name:"System Font Bold", size: 20.0)
        
        //set and format the ratings label
        if intNumRatings! == 0 {
            ratingLabel.text = "References Available"
            ratingLabel.textColor = UIColor.black
        } else {
            ratingLabel.text = "Rating: \(self.companyRating) | \(self.companyNumRatings) rating(s)"
            
            if floatRating! >= 4.0 {
                ratingLabel.textColor = UIColor.green
            } else if (floatRating! < 4.0) && (floatRating! >= 3.0) {
                ratingLabel.textColor = UIColor.orange
            } else {
                ratingLabel.textColor = UIColor.red
            }
        }
        
        //set and format the services label
        specialtyLabel.text=self.companySpecialty
        
        //set and format the overview Text View
        overviewView.text=self.companyOverview
        
        //set and format the phone button
        phoneButton.setTitle("CALL", for: .normal)
        emailButton.setTitle("EMAIL", for: .normal)
    }

}
