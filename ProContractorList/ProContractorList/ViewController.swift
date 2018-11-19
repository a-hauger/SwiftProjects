//
//  ViewController.swift
//  ProContractorList
//
//  Created by Anthony Hauger on 11/14/18.
//  Copyright © 2018 HomeAdvisorScreening. All rights reserved.
//

/**************** DOCUMENTATION ****************
 Purpose:
 To load the UITableViewController, UITableCells for each professional listed and instantiate the Detail View if a professional is tapped/clicked
 
 Description:
 1. Create a Professional struct type Decodable that will decode our JSON file
 2. Instantiate global variables
 3. Load the table view with the professional names and the professional's ratings
 4. Decodes the JSON file through a function
 5. Loads the initial view window
 
 Details:
 ALL CONSTRAINTS ARE FOUND IN THE IB
 
 Last Modified:
 17 November 2018 - Documentation, project part 1 completed
 16 November 2018 - removed segue, instead understood how to pass to the detail screen, fixed constraints in IB
 15 November 2018 - Created the UITableView and UITableCells, loading in the professional names, created a segue to the detail view
 14 November 2018 - Initial Creation
 **************** DOCUMENTATION ****************/

/**********************************************
 We changed Main.storyboard in the following ways:
 1. Changed the default view controller to a UITableViewController
 2. Changed the UITableViewController's class to link it to this ViewController file
 3. Changed the UITableViewController to be initialized upon opening the application
 4. Changed the Cell's Identifier to "ProfessionalCell" as we are going to display a professional in each cell
 5. EMBEDDED OUR UITableViewController IN A NAVIGATION CONTROLLER
 6. Created a ProfessionalCell file to link our ProfessionalCell to our Cell formatting and logic
 7. Created constraints for labels found in each cell
 ***********************************************/
 

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
    
    /**********************************************
    THE FOLLOWING LOADS THE UITableViewController
    ***ALL CONSTRAINTS ARE LOCATED IN THE IB***
     
     1. Changes the navigation title to Pros with bold System Font 18.0
     2. imports the JSON data from the JSON file and calls readJSON to fill in our professionals array
     ->2b. SORTS THE PROFESSIONALS ALPHABETICALLY
    ***********************************************/
    
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
     1. uses numberOfRowsInSection to find the number of cells we should load
     2. uses cellForRowAt to generate each cell
     ->2a. gathers a professional from our professionals array
     ->2b. instantiates a cell that recycles once off screen as type ProfessionalCell
     ->2c. set the cell labels as our professional attributes
     ----> You cannot do this for new view controller screens (?)
     3. returns that cell for use in our UITableViewController
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
    
    /**********************************************
    THE FOLLOWING CREATES THE DETAILS SCREEN FOR THE SELECTED PROFESSIONAL
     
     1. instantiate an immutable professional variable with the selected professional's details (all details)
     2. set global variables with specific professional details
     >> Can be passed into the detail screen without this, keeping global variables for potential use in upcoming parts
     3. Instantiate the professional details screen of type ProfessionalDetail ***All details found in ProfessionalDetail.swift***
     4. Push this screen to the navigation controller
     5. Set global variables in the detail screen with professional's details USING THE GLOBAL VARIABLES
    **********************************************/
    
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
        
        if let professionalDetail = storyboard?.instantiateViewController(withIdentifier: "ProfessionalDetail") as? ProfessionalDetail {

            navigationController?.pushViewController(professionalDetail, animated: true)
            
            professionalDetail.companyName = self.name
            professionalDetail.companySpecialty = self.specialty
            professionalDetail.companyRating = self.rating
            professionalDetail.companyNumRatings = self.numRatings
            professionalDetail.companyLocation = self.location
            professionalDetail.companyServices = self.services
            professionalDetail.companyOverview = self.overview
            professionalDetail.companyPhone = self.phone
            professionalDetail.companyEmail = self.email
        }
    }
}

