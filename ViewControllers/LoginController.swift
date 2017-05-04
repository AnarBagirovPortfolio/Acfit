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
    
    lazy var standardTopConstraint: CGFloat = {
        return (self.view.bounds.height - self.heightConstraint.constant) / 2
    }()
    
    lazy var openKeyboardTopConstraint: CGFloat = {
        return 30
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loginView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as? LoginView {
            self.loginView.addSubview(loginView)
        }
        
        DispatchQueue.main.async {
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
            
            self.view.addGestureRecognizer({
                return UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            }())
        }
        
        
        AcfitLibrary.shared.set(statusBarTintColor: .white)
        AcfitLibrary.shared.set(statusBarBackgroundColor: .mainColor)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        topConstraint.constant = view.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        edit(topConstraintConstant: self.standardTopConstraint, type: .bottomUp)
    }
    
}

extension LoginController {
    func edit(topConstraintConstant: CGFloat, type: AcfitLibrary.AnimationType) {
        topConstraint.constant = topConstraintConstant
        
        AcfitLibrary.shared.animate(type: type) {
            self.view.layoutIfNeeded()
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func keyboardWillHide() {
        edit(topConstraintConstant: standardTopConstraint, type: .standard)
    }
    
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let constraint = standardTopConstraint - keyboardSize.height / 2
            
            edit(topConstraintConstant: constraint, type: .standard)
        } else {
            edit(topConstraintConstant: openKeyboardTopConstraint, type: .standard)
        }
    }
}
