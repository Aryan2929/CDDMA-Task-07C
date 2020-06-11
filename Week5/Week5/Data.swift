//
//  Data.swift
//  Week5
//
//  Created by Aryan Bishnoi on 11/5/20.
//  Copyright © 2020 Aryan Bishnoi. All rights reserved.
//

import Foundation


struct ContactList: Codable {

    let fname: String
    let phno: Int
    let image: Int
}

class Dataw {
    
    var contactlist = [ContactList]()
    var contactlistDuplicate = [ContactList]()
    
    init(){
        retrieveFromJsonFile()
    }
    
    func retrieveFromJsonFile() {
        guard let fm = Bundle.main.path(forResource: "Contacts", ofType: "JSON") else {return}
    
        // Read data from .json file
        do {
            let suppurl = URL(fileURLWithPath: fm)
            let data = try Data(contentsOf: suppurl)
            //converted DATA type data in Contacts.JSON in Bundle to string
            let str: String = String(decoding: data, as: UTF8.self)
            
            //Saved data from Contacts.JSON in Bundle to new file called Contacts.JSON in document directory
            self.save(text: str, toDirectory: self.documentDirectory(), withFileName: "Contacts.JSON")
            self.read(fromDocumentsWithFileName: "Contacts.JSON")
            
            //This is used when i read JSON file from Contacts.JSON which is in Bundle
            /*
            let dataFromJSON = try! JSONDecoder().decode([ContactList].self, from: data)
            self.contactlist = dataFromJSON
            //created duplicate because it was changing the data order when i was sorting
            self.contactlistDuplicate = dataFromJSON
            */
        } catch {
            print(error)
        }
    }
    
    func documentDirectory() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask,
                                                                    true)
        return documentDirectory[0]
    }
    
    private func append(toPath path: String,
                        withPathComponent pathComponent: String) -> String? {
        if var pathURL = URL(string: path) {
            pathURL.appendPathComponent(pathComponent)
            
            return pathURL.absoluteString
        }
        
        return nil
    }
    
    func read(fromDocumentsWithFileName fileName: String) {
        guard let filePath = self.append(toPath: self.documentDirectory(),
                                         withPathComponent: fileName) else {
                                            return
        }
        
        do {
            let savedString = try String(contentsOfFile: filePath)
            let jsonData = savedString.data(using: .utf8)!
            self.contactlist = try! JSONDecoder().decode([ContactList].self, from: jsonData)
            //created duplicate because it was changing the data order when i was sorting
            self.contactlistDuplicate = try! JSONDecoder().decode([ContactList].self, from: jsonData)
        } catch {
            print("Error reading saved file")
        }
    }
    
    
    func save(text: String,
                      toDirectory directory: String,
                      withFileName fileName: String) {
        guard let filePath = self.append(toPath: directory,
                                         withPathComponent: fileName) else {
            return
        }
        
        do {
            try text.write(toFile: filePath,
                           atomically: true,
                           encoding: .utf8)
        } catch {
            print("Error", error)
            return
        }
        
        print("Save successful")
    }
    
}


