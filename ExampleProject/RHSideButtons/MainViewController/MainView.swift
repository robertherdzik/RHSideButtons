//
//  MainView.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 20/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit
import RHSideButtons

class MainView: UIView {
    
    fileprivate let triggerButtonMargin = CGFloat(85)
    
    var sideButtonsView: RHSideButtons?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Layout Buttons
        sideButtonsView?.setTriggerButtonPosition(CGPoint(x: bounds.width - triggerButtonMargin, y: bounds.height - triggerButtonMargin))
    }
    
    fileprivate func setup() {
        backgroundColor = UIColor.lightGray
    }
    
    func set(sideButtonsView view: RHSideButtons) {
        sideButtonsView = view
    }
}
