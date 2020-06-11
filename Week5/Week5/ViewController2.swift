//
//  ViewController2.swift
//  Week5
//
//  Created by Aryan Bishnoi on 26/5/20.
//  Copyright © 2020 Aryan Bishnoi. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var AddImage: UIImageView!

    @IBOutlet weak var picture: UILabel!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var ctno: UILabel!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var fullname: UILabel!
    
    @IBOutlet weak var btn: UIButton!
    var currentImage: UIImage!
    var picker = PickerController()
    let db = database()
    var strBase64 = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ImagePickBtn(_ sender: Any) {
        picker.selectImage(self){ image in
            DispatchQueue.main.async {
                self.AddImage.image = image
                let imagep : UIImage = image
                let imageData:NSData = imagep.pngData()! as NSData
                self.strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                self.db.insert(id: 1, name: "Aryn", age: 23, picture: self.strBase64)
                print(self.db.read())
            }
        }
    }
    
    var imageP = PickerController()
    
    @IBAction func button(_ sender: Any) {
        
    }
    @IBAction func ctname(_ sender: Any) {
    }
    
    @IBAction func ctnumber(_ sender: Any) {
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let VC = segue.destination as? ViewController else {return}
        
    }


}
