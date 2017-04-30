//
//  LoginController.swift
//  ProjectFitry
//
//  Created by Faannaka on 30.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure("before")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configure("after")
        
        AcfitLibrary.shared.animateBottomUp {
            self.view.layoutIfNeeded()
        }
    }
    
}

extension LoginController {
    func configure(_ configuration: String) {
        if configuration == "before" {
            AcfitLibrary.shared.set(statusBarColor: .white)
            
            //Initial value for top constraint before starting animating
            topConstraint.constant = view.bounds.height
            
            //Configure loginView
            loginView.layer.cornerRadius = 5
            loginView.layer.shadowOffset = CGSize(width: 0, height: 0)
            loginView.layer.shadowColor = UIColor.black.cgColor
            loginView.layer.shadowOpacity = 0.5
        } else if configuration == "after" {
            //Starting animating
            self.topConstraint.constant = (self.view.bounds.height - self.heightConstraint.constant) / 2
        }
    }
}
