//
//  RHSideButtons.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 20/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

protocol RHSideButtonsDelegate: class {
    func sideButtons(sideButtons: RHSideButtons, didSelectButtonAtIndex index: Int)
    func sideButtons(sideButtons: RHSideButtons, didTriggerButtonChangeStateTo state: RHButtonState)
}

protocol RHSideButtonsDataSource: class {
    func sideButtonsNumberOfButtons(sideButtons: RHSideButtons) -> Int
    func sideButtons(sideButtons: RHSideButtons, buttonAtIndex index: Int) -> RHButtonView
}

enum RHButtonState: Int {
    case Hidden = 0
    case Shown
}

class RHSideButtons {
    
    weak var parentView: UIView?
    weak var delegate: RHSideButtonsDelegate?
    weak var dataSource: RHSideButtonsDataSource?

    private let buttonSize = CGSize(width: 55, height: 55)
    private let verticalSpacing = CGFloat(15)
    private var hideStateOffset: CGFloat {
        get {
            guard let parentView = parentView else { return 0 }
            
            let parentViewWidth = parentView.bounds.width
            let hideOffsetX = buttonSize.width * (3/2)
            var resultPosX = parentViewWidth + hideOffsetX
            if (triggerButton.frame.origin.x + buttonSize.width/2 < parentViewWidth / 2) {
                resultPosX = -(hideOffsetX + buttonSize.width)
            }
            
            return resultPosX
        }
    }
    
    private var buttonsArr = [RHButtonView]()
    private let buttonsAnimator: RHSideButtonAnimatorProtocol
    private var descriptionArr = [String]()
    
    private(set) var state: RHButtonState = .Hidden {
        didSet {
            aniamateButtonForState(state) {}
            markTriggerButtonAsPressed(state == .Shown)
            buttonsAnimator.animateTriggerButton(triggerButton, state: state) {}
        }
    }
    
    var triggerButton: RHTriggerButtonView!
    
    init(parentView: UIView, triggerButton: RHTriggerButtonView, buttonsAnimator: RHSideButtonAnimatorProtocol) {
        self.parentView = parentView
        self.triggerButton = triggerButton
        self.buttonsAnimator = buttonsAnimator
        
        setup()
    }
    
    convenience init(parentView: UIView, triggerButton: RHTriggerButtonView) {
        // At this moment "RHSideButtonAnimator" is only existing and default button animator
        self.init(parentView: parentView, triggerButton: triggerButton, buttonsAnimator: RHSideButtonAnimator())
    }
    
    private func setup() {
        setDefaultTriggerButtonPosition()
        setupTriggerButton()
        layoutButtons()
    }
    
    private func setupTriggerButton() {
        guard let parentView = parentView else { return }

        setDefaultTriggerButtonPosition()
        triggerButton.delegate = self
        
        parentView.addSubview(triggerButton)
        parentView.bringSubviewToFront(triggerButton)
    }
    
    private func setDefaultTriggerButtonPosition() {
        guard let parentView = parentView else { return }
        
        triggerButton.frame = CGRect(x: parentView.bounds.width - buttonSize.width, y: parentView.bounds.height - buttonSize.height, width: buttonSize.width, height: buttonSize.height)
    }
    
    private func markTriggerButtonAsPressed(pressed: Bool) {
        triggerButton.markAsPressed(pressed)
    }
    
    private func layoutButtons() {
        var prevButton: RHButtonView? = nil
        for button in buttonsArr {
            var buttonPosY = CGFloat(0)
            if let prevButton = prevButton {
                buttonPosY = prevButton.frame.minY - verticalSpacing - buttonSize.height
            } else {
                // Spacing has to be applied to prevent jumping rest of buttons
                let spacingFromTriggerButtonY = CGFloat(18) // TODO add offset according to scale
                buttonPosY = triggerButton.frame.midY - spacingFromTriggerButtonY - verticalSpacing - buttonSize.height
            }

            let buttonPosX = getButtonPoxXAccordingToState(state)
            // Buttons should be laid out according to center of trigger button
            button.frame = CGRect(origin: CGPoint(x: buttonPosX, y: buttonPosY), size: buttonSize)
            
            prevButton = button
        }
    }

    private func getButtonPoxXAccordingToState(state: RHButtonState) -> CGFloat {
        return state == .Hidden ? hideStateOffset : triggerButton.frame.midX - buttonSize.width/2
    }
    
    private func removeButtons() {
        _ = buttonsArr.map{ $0.removeFromSuperview() }
        buttonsArr.removeAll()
    }
    
    private func addButtons() {
        guard let numberOfButtons = dataSource?.sideButtonsNumberOfButtons(self) else { return }
        
        for index in 0..<numberOfButtons {
            guard let button = dataSource?.sideButtons(self, buttonAtIndex: index) else { return }
            
            button.delegate = self
            parentView?.addSubview(button)
            parentView?.bringSubviewToFront(button)
            buttonsArr.append(button)
        }
    }
    
    private func aniamateButtonForState(state: RHButtonState, completition: (() -> ())? = nil) {
        let buttonPosX = getButtonPoxXAccordingToState(state)
        let targetPoint = CGPoint(x: buttonPosX, y: 0)
        
        buttonsAnimator.animateButtonsPositionX(buttonsArr, targetPos: targetPoint, completition: completition)
    }
    
    /**
     Method reload whole buttons. Use this method right after you made some changes in Side Buttons model.
     */
    func reloadButtons() {
        removeButtons()
        addButtons()
        layoutButtons()
    }
    
    /**
     Use this method for positioning of trigger button (should be invoken right after your view of ViewController is loaded).
     
     - parameter position: position of right button, have in mind that if you set position of trigger button you need to substract/add his width or height (it depends on position in view axis)
     */
    func setTriggerButtonPosition(position: CGPoint) {
        let scale = state == .Hidden ? CGFloat(1) : CGFloat (0.5)
        let offset = triggerButton.frame.size.width/2 * scale
        let newPosition = state == .Hidden ? position : CGPoint(x: position.x + offset, y: position.y + offset)
        triggerButton.frame = CGRect(origin: newPosition, size: triggerButton.frame.size)
    }
    
    /**
     If you want to hide trigger button in some point of lifecycle of your VC you can using this method
     */
    func hideTriggerButton() {
        hideButtons()
        triggerButton.hidden = true
    }
    
    /**
     Method shows trigger button (if was hidden before)
     */
    func showTriggerButton() {
        hideButtons()
        triggerButton.hidden = false
    }
    
    /**
     Method show with animation all side buttons
     */
    func showButtons() {
        state = .Shown
    }
    
    /**
     Method hide with animation all side buttons
     */
    func hideButtons() {
        state = .Hidden
    }
}

extension RHSideButtons: RHButtonViewDelegate {
    
    func didSelectButton(buttonView: RHButtonView) {
        if let indexOfButton = buttonsArr.indexOf(buttonView) {
            delegate?.sideButtons(self, didSelectButtonAtIndex: indexOfButton)
           
            state = .Hidden
        } else {
            state = state == .Shown ? .Hidden : .Shown
            
            delegate?.sideButtons(self, didTriggerButtonChangeStateTo: state)
        }
    }
}