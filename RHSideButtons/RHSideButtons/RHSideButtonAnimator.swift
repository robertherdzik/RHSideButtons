//
//  RHSideButtonAnimator.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 24/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

struct RHSideButtonAnimator {
    
    let commonAnimationDuration = NSTimeInterval(0.4)
    let commonSpringDumping = CGFloat(0.4)
    let commonInitSpringVelocity = CGFloat(0.1)
    
    private func commonAnimation(delay: NSTimeInterval = 0, animations: () -> (), completition: ((Bool) -> ())? = nil) {
        UIView.animateWithDuration(commonAnimationDuration, delay: delay, usingSpringWithDamping: commonSpringDumping, initialSpringVelocity: commonInitSpringVelocity, options: .CurveEaseOut, animations: animations, completion: completition)
    }
}

extension RHSideButtonAnimator: RHSideButtonAnimatorProtocol {
    
    func animateTriggerButton(button: RHButtonView, state: RHButtonState, completition: (() -> ())?) {
        let scale = state == .Hidden ? CGFloat(1) : CGFloat (0.7)
        let trans = CGAffineTransformMakeScale(scale, scale)
        
        commonAnimation(animations: {
            button.transform = trans
        }) { finish in
            if finish { completition?() }
        }
    }
    
    func animateButtonsPositionX(buttonsArr: [RHButtonView], targetPos: CGPoint, completition: (() -> ())? = nil) {
        
        var delay: NSTimeInterval = 0
        for button in buttonsArr {
            let completitionBlock = button.isEqual(buttonsArr.last) ? completition : nil
            
            commonAnimation(delay, animations: {
                button.frame = CGRect(origin: CGPoint(x: targetPos.x, y: button.frame.origin.y), size: button.bounds.size)
                
            }) { finish in
                if finish { completitionBlock?() }
            }
            
            delay += 0.1
        }
    }
}