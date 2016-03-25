//
//  MasterViewController.swift
//  Esoteric Phrase Book
//
//  Created by Alexis Caudle on 3/3/16.
//  Copyright © 2016 Alexis Caudle. All rights reserved.
//

import UIKit

var objects: [String] = [String]()
var currentIndex:Int = 0
var masterView: MasterViewController?
var detailViewController: DetailViewController?

let BLANK_NOTE:String = "(New Note)"
let kNotes:String = "notes"

class MasterViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        objects = ["Fallopian Tube", "Ovary", "Uterus", "Vagina", "Endometrium", "Vulva", "Clitoris", "Urethra", "Labia Minora", "Labia Majora", "Fornix", "Corpus Luteum", "Cervix", "Testical", "Seminal Duct", "Prostate",  "Urethra", "Vas Deferens", "Scrotum", "Penis", "Foreskin", "Erectile Tissue", "Pubic Symphsis", "Epididymis", "Bladder", "Anus", "Rectum" ]
        save()
        load()
        
        masterView = self
        load()
        
        }
    
    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        save()
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if objects.count == 0 {
            insertNewObject(self)
        }
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject){
        
        if detailViewController?.detailDescriptionLabel.editable == false { return
        }
        
        if objects.count == 0 || objects[0] != BLANK_NOTE {
            objects.insert(BLANK_NOTE, atIndex: 0)
            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        currentIndex = 0
        self.performSegueWithIdentifier("showDetail", sender: self)
        
    }
    

    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        detailViewController?.detailDescriptionLabel.editable = false
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                currentIndex = indexPath.row
            }
            let object = objects[currentIndex]
            detailViewController?.detailItem = object
            detailViewController?.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            detailViewController?.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let object = objects[indexPath.row]
        cell.textLabel!.text = object
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
        }
    
    override func setEditing(editing: Bool, animated: Bool)
    {
        super.setEditing(editing, animated: animated)
    }
    
    override func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    func save(){
        NSUserDefaults.standardUserDefaults().setObject(objects, forKey: kNotes)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func load(){
        if let loadedData = NSUserDefaults.standardUserDefaults().arrayForKey(kNotes) as? [String]{
            objects = loadedData
        }
    }
    
    
}

