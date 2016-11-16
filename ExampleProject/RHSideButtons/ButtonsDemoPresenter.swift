//
//  ButtonsDemoPresenter.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 17/07/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import Foundation

class ButtonsDemoPresenter: NSObject {
    
    weak var mainViewController: MainViewController?
    
    init(mainViewController: MainViewController) {
        self.mainViewController = mainViewController
        
        super.init()
    }
    
    func start() {
        perform(#selector(delayShow), with: nil, afterDelay: 1)
        perform(#selector(delayHide), with: nil, afterDelay: 2)
    }
    
    func delayShow() {
        mainViewController?.castView().sideButtonsView?.showButtons()
    }
    
    func delayHide() {
        mainViewController?.castView().sideButtonsView?.hideButtons()
    }
}
