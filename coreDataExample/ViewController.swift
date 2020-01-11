//
//  ViewController.swift
//  coreDataExample
//
//  Created by komaldeep kaur on 2020-01-11.
//  Copyright © 2020 komaldeep kaur. All rights reserved.
//

import UIKit
import Foundation
import CoreData
class ViewController: UIViewController,UIApplicationDelegate {
    
   
    
    @IBOutlet weak var productName: UITextField!
    
    @IBOutlet weak var productPrice: UITextField!
    
    @IBOutlet weak var label: UILabel!
    var dataManager  : NSManagedObjectContext!
    var listArray = [NSManagedObject] ()
    
    @IBAction func btnAdd(_ sender: UIButton)
    {
        let newEntity = NSEntityDescription .
        insertNewObject(forEntityName: "Item", into: dataManager)
            
            newEntity.setValue(productName.text!, forKey: "name")
            newEntity.setValue(productPrice.text!, forKey: "price")
        do {
        try self.dataManager.save()
            listArray.append(newEntity)
        } catch {
        print ("Error saving data")
            }
            label.text?.removeAll()
            
            productName.text?.removeAll()
            productPrice.text?.removeAll()
            fetchData()
    }
    
    @IBAction func btnDelete(_ sender: UIButton)
    {
        let deleteItem = productName.text!
        for item in listArray {
        if item.value(forKey: "name") as! String == deleteItem { dataManager.delete(item)
        }
        }
        do {
        try self.dataManager.save() } catch {
                    print ("Error deleting data")
                }
                label.text?.removeAll()
                productName.text?.removeAll()
                fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        label.text?.removeAll()
        fetchData()
    }
    
    func fetchData() {
    let fetchRequest : NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
    do {
    let result = try dataManager.fetch(fetchRequest)
        listArray = result as! [NSManagedObject]
    for item in listArray {
    let product = item.value(forKey: "name") as! String
        let cost = item.value(forKey: "price") as! String
        label.text! += product + " " + cost + ", "
    }
    } catch {
               print ("Error retrieving data")
           }
    }

}

