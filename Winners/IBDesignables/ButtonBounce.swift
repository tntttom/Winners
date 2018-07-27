//
//  ButtonBounce.swift
//  Winners
//
//  Created by Tommy Nguyen on 7/26/18.
//  Copyright © 2018 Tommy Nguyen. All rights reserved.
//

import UIKit

class ButtonBounce: UIButton {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Make the button bigger when touched
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        //Animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            
            //Sets the scale to before we changed it
            self.transform = CGAffineTransform.identity
            
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
        
    }

}
