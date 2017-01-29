//
//  ViewController.swift
//  Core Data Demo
//
//  Created by Maalik Hornbuckle on 1/29/17.
//  Copyright © 2017 Maalik Hornbuckle. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext //manager variables (similar to location or audio) to access core data from entity
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context) //Creating object of Users entity
        
        
        //creation of new user
        newUser.setValue("Maalik", forKey: "username")
        newUser.setValue("myPass", forKey: "password")
        newUser.setValue(21, forKey: "age")
    

        //do try catch loop that saves user

    
        do {
            try context.save() //saves data in the context manager 
            print("Saved")
            
        } catch {
            
            print("There was an error") //error catching
            
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users") //allows me to get data back from database by setting request on entity named users
        
        request.returnsObjectsAsFaults = false //returns Object as false because we want to get actual value
        
        do {
            
            let results = try context.fetch(request) //results variable equal to fetch request
            
            if results.count > 0 { //checks to see if there are any values in the fetch request
                
                for result in results as! [NSManagedObject] { //if so, we loop through those objects as NSManagedObjects
                    
                    if let username = result.value(forKey: "username") as? String { //originally cast as NSManagedObject but want to bring in as string, trying to retrieve username from Users table, username attribute
                        
                        print(username) //prints usernames in colnsole
                        
                    }
                }
            } else {
                
                print("No Results") //if count is not greater than 0, prints message
            }
            
        } catch {
            
            print("Couldn't fetch Results") //error catching
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

