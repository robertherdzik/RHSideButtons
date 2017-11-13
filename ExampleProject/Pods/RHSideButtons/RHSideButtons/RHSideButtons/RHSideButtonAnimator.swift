//
//  RHSideButtonAnimator.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 24/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

struct RHSideButtonAnimator {
    
    let commonAnimationDuration = TimeInterval(0.4)
    let commonSpringDumping = CGFloat(0.4)
    let commonInitSpringVelocity = CGFloat(0.1)
    
    fileprivate func commonAnimation(_ delay: TimeInterval = 0, animations: @escaping () -> (), completition: ((Bool) -> ())? = nil) {
        UIView.animate(withDuration: commonAnimationDuration, delay: delay, usingSpringWithDamping: commonSpringDumping, initialSpringVelocity: commonInitSpringVelocity, options: .curveEaseOut, animations: animations, completion: completition)
    }
}

extension RHSideButtonAnimator: RHSideButtonAnimatorProtocol {
    
    func animateTriggerButton(_ button: RHButtonView, state: RHButtonState, completition: (() -> ())?) {
        let scale = state == .hidden ? CGFloat(1) : CGFloat (0.7)
        let trans = CGAffineTransform(scaleX: scale, y: scale)
        
        commonAnimation(animations: {
            button.transform = trans
        }) { finish in
            if finish { completition?() }
        }
    }
    
    func animateButtonsPositionX(_ buttonsArr: [RHButtonView], targetPos: CGPoint, completition: (() -> ())? = nil) {
        
        var delay: TimeInterval = 0
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
