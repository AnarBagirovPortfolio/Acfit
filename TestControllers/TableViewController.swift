//
//  TableViewController.swift
//  ProjectFitry
//
//  Created by Faannaka on 27.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    @IBAction func buttonClicked(sender: Any) {
        print("Choose image")
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    lazy var imagePicker: UIImagePickerController = {
        let controller = UIImagePickerController()
        
        controller.allowsEditing = false
        controller.sourceType = .photoLibrary
        controller.delegate = self
        
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension TableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            print(image)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

