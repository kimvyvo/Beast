//
//  ViewController.swift
//  belt_exam
//
//  Created by Kim Vy Vo on 9/21/18.
//  Copyright © 2018 Kim Vy Vo. All rights reserved.
//

import UIKit
import CoreData

class ToBeastTVC: UITableViewController, BeastedDelegate, EditBeastDelegate {
    
    var beastList = [Beast]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllBeasts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beastList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToBeastCell", for: indexPath) as! ToBeastCell
        cell.nameLabel.text = beastList[indexPath.row].name
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let deleteBeast =  beastList[indexPath.row]
            beastList.remove(at: indexPath.row)
            context.delete(deleteBeast)
            saveContext()
            tableView.reloadData()
        }
    }
    
    func fetchAllBeasts() {
        let request: NSFetchRequest<Beast> = Beast.fetchRequest()
        do {
            let val = "0"
            request.predicate = NSPredicate(format: "isBeasted == %@", val)
            let fetchedBeasts = try context.fetch(request)
            beastList = fetchedBeasts
        } catch {
            print("error with fetching")
        }
    
    }

    @IBAction func unwindToToBeastTVC(_ segue: UIStoryboardSegue) {
        let src = segue.source as! AddBeastVC
        let newBeast = Beast(context: self.context)
        newBeast.name = src.nameTextField.text
        newBeast.date = ""
        newBeast.isBeasted = "0"
        beastList.append(newBeast)
        saveContext()
        tableView.reloadData()
    }
    
    func beastThatCell(by controller: ToBeastCell, with date: String, at indexPath: IndexPath) {
        beastList[indexPath.row].isBeasted = "1"
        beastList[indexPath.row].date = date
        saveContext()
        fetchAllBeasts()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditBeastSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EditBeastSegue") {
            let navigationController = segue.destination as! UINavigationController
            let EditBeastViewController = navigationController.topViewController as! EditBeastVC
            EditBeastViewController.delegate = self
            EditBeastViewController.title = "Edit Beast"
            let indexPath = sender as! NSIndexPath
            EditBeastViewController.indexPath = indexPath
            EditBeastViewController.name = beastList[indexPath.row].name!
        }
    }
    
    func editBeast(by controller: EditBeastVC, with name: String, for indexPath: IndexPath) {
        beastList[indexPath.row].name = name
        saveContext()
        tableView.reloadData()
    }
    
}

