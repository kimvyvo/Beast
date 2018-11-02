//
//  BeastedTVC.swift
//  belt_exam
//
//  Created by Kim Vy Vo on 9/21/18.
//  Copyright © 2018 Kim Vy Vo. All rights reserved.
//

import UIKit
import CoreData

class BeastedTVC: UITableViewController, EditBeastDelegate {
    
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
        fetchAllBeasts()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beastList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastedCell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = beastList[indexPath.row].name
        cell.detailTextLabel?.text = beastList[indexPath.row].date!
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
            let val = "1"
            request.predicate = NSPredicate(format: "isBeasted == %@", val)
            let fetchedBeasts = try context.fetch(request)
            beastList = fetchedBeasts
        } catch {
            print("error with fetching")
        }

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
