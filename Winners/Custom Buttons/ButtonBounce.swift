//
//  ButtonBounce.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/26/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import UIKit

class ButtonBounce: DesignableButton {
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Make the button bigger when touched
        
        
        //Animation
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            
            //Sets the scale to before we changed it
            self.transform = CGAffineTransform(scaleX: 1.5 , y: 1.5)
            
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Animation
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .allowUserInteraction, animations: {
            
            //Sets the scale to before we changed it
            self.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
        super.touchesEnded(touches, with: event)
    }

}
