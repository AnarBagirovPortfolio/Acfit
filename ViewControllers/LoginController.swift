//
//  LoginController.swift
//  ProjectFitry
//
//  Created by Faannaka on 30.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import UIKit
import Photos

class LoginController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginView: UIView!
    
    var logoImage: UIImageView!
    var firstStart = true
    
    lazy var imagePicker: UIImagePickerController! = {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        
        return picker
    }()
    
    lazy var standardTopConstraint: CGFloat! = {
        return (self.view.bounds.height - self.heightConstraint.constant) / 2
    }()
    
    lazy var openKeyboardTopConstraint: CGFloat! = {
        return 30
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loginView = Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)?.first as? LoginView {
            loginView.setImageButton.addTarget(self, action: #selector(setImageButtonPressed), for: .touchDown)
            loginView.superViewController = self
            
            self.loginView.addSubview(loginView)
            self.logoImage = loginView.logo
        }
        
        DispatchQueue.main.async {
            self.view.addGestureRecognizer({
                return UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
            }())
        }
        
        AcfitLibrary.shared.set(statusBarTintColor: .white)
        AcfitLibrary.shared.set(statusBarBackgroundColor: .mainColor)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if firstStart {
            topConstraint.constant = view.bounds.height
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if firstStart {
            edit(topConstraintConstant: self.standardTopConstraint, type: .bottomUp)
            firstStart = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        imagePicker = nil
        standardTopConstraint = nil
        openKeyboardTopConstraint = nil
        logoImage = nil
    }
    
}

extension LoginController: UIImagePickerControllerDelegate {
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
            let constraint = standardTopConstraint - keyboardSize.height / 2 + 5
            
            edit(topConstraintConstant: constraint, type: .standard)
        } else {
            edit(topConstraintConstant: openKeyboardTopConstraint, type: .standard)
        }
    }
    
    func setImageButtonPressed() {
        autoreleasepool {
            present(imagePicker, animated: true, completion: {
                AcfitLibrary.shared.set(statusBarTintColor: .black)
                AcfitLibrary.shared.set(statusBarBackgroundColor: .clear)
            })
            
            imagePicker = nil
        }
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let url = info[UIImagePickerControllerReferenceURL] as! URL
        let assets = PHAsset.fetchAssets(withALAssetURLs: [url], options: nil)
        let asset = assets.firstObject!
        let size = CGSize(width: 500, height: 500)
        let request = PHImageManager.default().requestImage
        
        let _ = request(asset, size, .aspectFit, nil) { (result, info) in
            self.logoImage.image = result
        }
        
        imagePickerControllerDidCancel(picker)
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: {
            AcfitLibrary.shared.set(statusBarTintColor: .white)
            AcfitLibrary.shared.set(statusBarBackgroundColor: .mainColor)
        })
    }
}
