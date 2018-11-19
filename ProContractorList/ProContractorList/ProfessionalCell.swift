//
//  TableViewCell.swift
//  ProContractorList
//
//  Created by Anthony Hauger on 11/15/18.
//  Copyright © 2018 HomeAdvisorScreening. All rights reserved.
//

/**************** DOCUMENTATION ****************
 Purpose:
 To load and stylize our UITableCells
 
 Description:
 1. Create outlets from the IB to here for the company name label and the rating label
 2. Create a way for the cell's labels to be set externally through our setCellLabel function
 ->2b. formats the labels' text, font and color (based on provided logic)
 
 Details:
 ALL CONSTRAINTS ARE FOUND IN THE IB
 
 Last Modified:
 17 November 2018 - Documentation, project part 1 completed
 16 November 2018 - fixed constraints in IB
 15 November 2018 - Initial Creation. Created a way to set labels and stylize labels
 **************** DOCUMENTATION ****************/

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
            compositeRatingLabel.text="Ratings: \(rating) | \(numRatings) rating(s)"
            
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
