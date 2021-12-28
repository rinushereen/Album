//
//  UIView.swift
//  Album
//
//  Created by Shereen on 24/11/20.
//

import Foundation
import UIKit
extension UIView {
    
func roundCorners(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.clipsToBounds = true
}
    func setBorder(color:UIColor) {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    func addShadowToView() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius  = 1.0
        self.layer.shadowOffset  = CGSize(width :0, height :0)
        self.layer.masksToBounds = false
        self.layer.cornerRadius =  10.0
    }
}
