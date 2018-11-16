//
//  ViewController.swift
//  ProContractorList
//
//  Created by Anthony Hauger on 11/14/18.
//  Copyright © 2018 HomeAdvisorScreening. All rights reserved.
//


/********************************************
 OKAY HERE'S HOW YOU'RE GOING TO TACKLE IT:
 >PARSE THE JSON FILE
 1. You know that this is coming in as an array right now, but moving forward you can't be certain of that fact.
 2. So what you're going to do is either: wrap the dictionary in an array like the current JSON file
 3. Return an array of Professional Objects to display
 
 >PARSE THE RETURNED ARRAY INTO INDIVIDUAL OBJECTS TO BE DISPLAYED
 1. Create a function that will iterate through each/for object in array:
 2. Create a Professional struct/possibly extension if this moves fast enough that will contain each key for each professional
 3. ALPHABETIZE THE PROFESSIONALS HERE
 
 >DISPLAY THE RETURNED PROFESSIONALS
 1. On the UITableViewController, list each Professional as a cell:
    1a. Display the Professionals name in a formatted way
    1b. Display the Professionals rating in a formatted way
 2. TAPPING ON A PRO WILL MOVE TO A DETAILS SCREEN
 
 >DISPLAY THE DETAILS SCREEN
 1. The Professionals Name, Speciality, Rating, Location, Services and Overfiew will be displayed in a formatted way
 2. There will be CALL and EMAIL buttons on the bottom of the screen
 3. Tapping call will print 'phone=<phone number>', tapping email will print 'email=<email>'
 ********************************************/

/**************** DOCUMENTATION ****************
 PURPOSE:
 Load the table view with the professional names and the professional's ratings
 **************** DOCUMENTATION ****************/
 
 

import UIKit

class ViewController: UITableViewController {
    
    //create a struct that takes each professional in a JSON file and creates a Professional object
    //Decodable allows JSONDecoder to be able to decode JSON data into this data type
    struct Professional: Decodable {
        let entityId: String
        let companyName: String
        let ratingCount: String
        let compositeRating: String
        let companyOverview: String
        let canadianSP: Bool
        let spanishSpeaking: Bool
        let phoneNumber: String
        let latitude: Float?
        let longitude: Float?
        let servicesOffered: String?
        let specialty: String
        let primaryLocation: String
        let email: String
    }
    
    //variable declarations for access globally
    var name = ""
    var specialty = ""
    var rating = ""
    var numRatings = ""
    var location = ""
    var services = ""
    var overview = ""
    var phone = ""
    var email = ""
    
    //create an array of Professional objects -> []() means create the empty array now
    var professionals = [Professional]()
    
    //read the JSON data and then put it into the professionals array
    private func readJSON(data: Data){
        
        //use the built in JSONDecoder to decode our JSON data into Professional data
        do {
            let decoder = JSONDecoder()
            self.professionals = try decoder.decode([Professional].self, from: data)
        } catch let error {
            print(error)
        }
    }

    override func viewDidLoad() {
        //load the basic controller before doing anything else
        super.viewDidLoad()
        
        /* NAVBAR FORMATTING */
        self.title="Pros"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)
        ]
        
        //find the JSON file in the local directory using Bundle
        if let path = Bundle.main.path(forResource: "pro_data", ofType: "json"){
            do{
                //translate the contents of the JSON file into type Data
                let professionalData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                //Send the Data to our readJSON function
                readJSON(data: professionalData)
            } catch {
                print("JSON file not found")
            }
        }

        //sort the professionals array alphabetically
        professionals = professionals.sorted{ $0.companyName < $1.companyName }
    }
    
    /**********************************************
     THE FOLLOWING CREATES THE CELLS IN THE TABLE
     
     We changed Main.storyboard in the following ways:
     1. Changed the default view controller to a UITableViewController
     2. Changed the UITableViewController's class to link it to this ViewController file
     3. Changed the UITableViewController to be initialized upon opening the application
     4. Changed the Cell's Identifier to "ProfessionalCell" as we are going to display a professional in each cell
     5. EMBEDDED OUR UITableViewController IN A NAVIGATION CONTROLLER
     6. Created a ProfessionalCell file to link our ProfessionalCell to with our Cell formatting and logic
     ***********************************************/
    
    //determines how many rows the table view should show
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return professionals.count
    }
    
    //Generates all cells one cell at a time with the formatting in our ProfessionalCell file
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //gather the professional from the row of the array
        let professional = professionals[indexPath.row]
        
        //dequeueReusableCell will recycle a cell once its past the top/bottom of the screen
        //cast this cell as our ProfessionalCell
        //ProfessionalCell contains the cell logic for strings
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfessionalCell", for: indexPath) as! ProfessionalCell
        
        //format our cells in the designated fashion
        cell.setCellLabels(name: professional.companyName, rating: professional.compositeRating, numRatings: professional.ratingCount)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        let professional = professionals[indexPath.row]
        
        self.name = professional.companyName
        self.specialty = professional.specialty
        self.rating = professional.compositeRating
        self.numRatings = professional.ratingCount
        self.location = professional.primaryLocation
        self.services = professional.servicesOffered ?? "Services Not Available"
        self.overview = professional.companyOverview
        self.phone = professional.phoneNumber
        self.email = professional.email
        
        performSegue(withIdentifier: "detailView", sender: self)
        
        
        /* OLD CODE
        if let professionalDetail = storyboard?.instantiateViewController(withIdentifier: "ProfessionalDetail") as? ProfessionalDetail {
            let professional = professionals[indexPath.row]
            
            professionalDetail.setLabels(name: professional.companyName, specialty: professional.specialty, rating: professional.compositeRating, numRatings: professional.ratingCount, location: professional.primaryLocation, services: professional.servicesOffered ?? "Services Not Available", overview: professional.companyOverview, phone: professional.phoneNumber, email: professional.email)
            
            navigationController?.pushViewController(professionalDetail, animated: true)
        } OLD CODE */
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var viewController = segue.destination as! ProfessionalDetail
        
        viewController.companyName = self.name
        viewController.companySpecialty = self.specialty
        viewController.companyRating = self.rating
        viewController.companyNumRatings = self.numRatings
        viewController.companyLocation = self.location
        viewController.companyServices = self.services
        viewController.companyOverview = self.overview
        viewController.companyPhone = self.phone
        viewController.companyEmail = self.email
        
    }
}

