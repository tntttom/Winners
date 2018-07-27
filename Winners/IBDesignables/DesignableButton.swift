//
//  DesignableButton.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/26/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: ButtonBounce {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray {
        didSet{
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet{
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0){
        didSet{
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var maskToBounds: Bool = true {
        didSet {
            self.layer.masksToBounds = maskToBounds
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//    }
    
    
}







