//
//  WelcomeViewController.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/26/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//
import UIKit


class WelcomeViewController: UIViewController {
    @IBOutlet weak var signupButton: DesignableButton!
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
    //@IBOutlet var gradientView: GradientView!
    @IBOutlet weak var loginButton: DesignableButton!
    
    var currentColorIndex = -1
    var colorArray: [(color1: UIColor, color2: UIColor)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        


        
        animateBackgroundColor()
    }
    
    func animateBackgroundColor() {
        colorArray.append((color1: #colorLiteral(red: 1, green: 0.7390024928, blue: 0.8163025352, alpha: 1), color2: #colorLiteral(red: 0.5882352941, green: 0.8509803922, blue: 0.8901960784, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), color2: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)))
        colorArray.append((color1: #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1), color2: #colorLiteral(red: 1, green: 0.7390024928, blue: 0.8163025352, alpha: 1)))
        
        
        //Ternary Conditional Operator VARIABLE = (condition ? true : false)
        currentColorIndex = currentColorIndex == (colorArray.count - 1) ? 0: currentColorIndex + 1
        
        
        
        UIView.transition(with: gradientView, duration: 3, options: [.transitionCrossDissolve], animations: {
            
            self.gradientView.FirstColor = self.colorArray[self.currentColorIndex].color1
            self.gradientView.SecondColor = self.colorArray[self.currentColorIndex].color2
            
            UIView.transition(with: self.winnerLabel, duration: 0.5, options: [.transitionCrossDissolve], animations: {
                if self.currentColorIndex == 1 || self.currentColorIndex == 2 {
                    self.winnerLabel.textColor = UIColor.white
                } else {
                    self.winnerLabel.textColor = UIColor.black
                }
            }, completion: nil)
            
        }) { (success) in
            //RECURSION
            self.animateBackgroundColor()
        }
        
    }
    
    
}


