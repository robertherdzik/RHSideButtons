//
//  RHSideButtonAnimatorProtocol.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 26/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

protocol RHSideButtonAnimatorProtocol {
    func animateTriggerButton(button: RHButtonView, state: RHButtonState, completition: (() -> ())?)
    func animateButtonsPositionX(buttonsArr: [RHButtonView], targetPos: CGPoint, completition: (() -> ())?)
}