//
//  TableViewController.swift
//  GCDRandomApp
//
//  Created by Konstantin Kalivod on 6/6/19.
//  Copyright © 2019 Kostya Kalivod. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var myDataArray : [Titles] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let queue = DispatchQueue.global(qos: .background)
        queue.async {
            MyModel.generatorRandomStrings(length: 1000)
            DispatchQueue.main.async {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                let fetchRequest : NSFetchRequest<Titles> = Titles.fetchRequest()
                do {
                    self.myDataArray = try context.fetch(fetchRequest)
                } catch {
                    print(error.localizedDescription)
                }
                self.tableView.reloadData()
            }
        }
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myDataArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let myArray = myDataArray[indexPath.row]
        cell.textLabel?.text = myArray.title
        // Configure the cell...

        return cell
    }

}
