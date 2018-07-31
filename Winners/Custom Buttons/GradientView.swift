//
//  GradientView.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/26/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import UIKit
@IBDesignable
class GradientView: UIView {
    @IBInspectable var FirstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
            
        }
    }
   

    @IBInspectable var SecondColor: UIColor = UIColor.clear{
        didSet {
            updateView()
            
        }
    }
    
    @IBInspectable var horizontalGradient: Bool = false {
        didSet {
            updateView()
        }
    }

    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
        
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [FirstColor.cgColor, SecondColor.cgColor]
        
        if horizontalGradient {
            layer.startPoint = CGPoint(x: 0.0, y: 0.5)
            layer.endPoint = CGPoint(x: 1, y: 0.5)
        } else{
            layer.startPoint = CGPoint(x: 0, y: 0)
            layer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        
    }
    
    
}
