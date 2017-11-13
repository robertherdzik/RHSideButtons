//
//  RHSideButtonAnimatorProtocol.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 26/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

public protocol RHSideButtonAnimatorProtocol {
    func animateTriggerButton(_ button: RHButtonView, state: RHButtonState, completition: (() -> ())?)
    func animateButtonsPositionX(_ buttonsArr: [RHButtonView], targetPos: CGPoint, completition: (() -> ())?)
}
