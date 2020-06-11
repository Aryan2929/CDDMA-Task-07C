//
//  ViewController.swift
//  Week5
//
//  Created by Aryan Bishnoi on 9/5/20.
//  Copyright © 2020 Aryan Bishnoi. All rights reserved.
//
import UIKit


var datasave = Dataw()

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var TableV: UITableView!
    
    //filter on the basis of Phone number, less then digit 5000 will be printed out
    //for the sake of time I just implemented the functionality for filter
    var db: database = database()
    var data = [ContactList]()
    var dataDuplicate  = [ContactList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        TableV.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        TableV.delegate  = self
        TableV.dataSource = self
        data = datasave.contactlist
        //created contact duplicate because it was changing the data order when i was sorting
        dataDuplicate = datasave.contactlistDuplicate
        
        let i = 0
        db.insert(id: data[i].image, name: data[i].fname, age: data[i].phno, picture: "")
        data = db.read()
        dataDuplicate = db.read()
    }
    
    
    let contactlist2 = datasave.contactlist.filter{ $0.phno < 5000}
    
    @IBAction func options(_ sender: Any) {
        TableV.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var no = data.count + 100
        switch SegmentedControl.selectedSegmentIndex
        {
        case 0:
            return data.count
        case 1:
            return dataDuplicate.count
        case 2:
            return contactlist2.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableV.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        switch SegmentedControl.selectedSegmentIndex
        {
        case 0:
            cell.Fname.text = data[indexPath.row].fname
            cell.Sname.text = String(data[indexPath.row].phno)
            
            cell.ImageV.image = UIImage(named: String(data[indexPath.row].image))
        case 1:
            //sorted the contact List on the basis of firstname letters.
            dataDuplicate.sort{
                $0.fname < $1.fname
            }
            cell.Fname.text = dataDuplicate[indexPath.row].fname
            cell.Sname.text = String(dataDuplicate[indexPath.row].phno)
            cell.ImageV.image = UIImage(named: String(dataDuplicate[indexPath.row].image))
        case 2:
            let contactlist2 = dataDuplicate.filter{ $0.phno < 5000}

            cell.Fname.text = contactlist2[indexPath.row].fname
            cell.Sname.text = String(contactlist2[indexPath.row].phno)
            cell.ImageV.image = UIImage(named: String(contactlist2[indexPath.row].image))
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    //deleting data from table and from database.
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        let i = indexPath.row
        if editingStyle == .delete{
            data.remove(at: indexPath.row)
            db.deleteByID(id: i)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
}


