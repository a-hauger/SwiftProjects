//
//  TableViewCell.swift
//  ProContractorList
//
//  Created by Anthony Hauger on 11/15/18.
//  Copyright © 2018 HomeAdvisorScreening. All rights reserved.
//

import UIKit

class ProfessionalCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var compositeRatingLabel: UILabel!
    
    func setCellLabels(name: String, rating:
        String, numRatings: String){
        
        companyNameLabel.text = name
        
        //formatting Company Name Label font
        companyNameLabel.font = UIFont(name:"System Font Bold", size: 18.0)
        
        //cast the parameter strings to floats/ints
        let floatRating: Float? = Float(rating)
        let intNumRatings: Int? = Int(numRatings)
        
        //formatting ratings label based on rating
        if intNumRatings! == 0{
            compositeRatingLabel.text = "References Available"
            compositeRatingLabel.textColor = UIColor.black
        } else {
            compositeRatingLabel.text="Rating: \(rating) | \(numRatings) rating(s)"
            
            if floatRating! >= 4.0 {
                compositeRatingLabel.textColor=UIColor.green
            } else if (floatRating! < 4.0) && (floatRating! >= 3.0) {
                compositeRatingLabel.textColor=UIColor.orange
            } else {
                compositeRatingLabel.textColor=UIColor.red
            }
        }
        //formatting Composite Rating Label
        compositeRatingLabel.font = UIFont(name:"System Font Regular", size: 16.0)
    }
}
