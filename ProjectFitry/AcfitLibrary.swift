//
//  AcfitLibrary.swift
//  ProjectFitry
//
//  Created by Faannaka on 30.04.17.
//  Copyright © 2017 Anar Baghirov. All rights reserved.
//

import Foundation
import UIKit

final class AcfitLibrary {
    private init() { }
    
    static let shared = AcfitLibrary()
    
    enum StatusBarColor {
        case white
        case black
    }
    
    enum AnimationType {
        case standard
        case bottomUp
    }
    
    func animate(type: AnimationType, animations: @escaping () -> Void) {
        if type == .standard {
            UIView.animate(withDuration: 1,
                           delay: 0,
                           options: .preferredFramesPerSecond60,
                           animations: animations,
                           completion: nil)
        } else if type == .bottomUp {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 2,
                               delay: 0.5,
                               usingSpringWithDamping: 0.8,
                               initialSpringVelocity: 0.2,
                               options: .preferredFramesPerSecond60,
                               animations: animations,
                               completion: nil)
            }
        }
    }
    
    func set(statusBarTintColor color: StatusBarColor) {
        if color == StatusBarColor.black {
            UIApplication.shared.statusBarStyle = .default
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    func set(statusBarBackgroundColor color: UIColor) {
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
}
