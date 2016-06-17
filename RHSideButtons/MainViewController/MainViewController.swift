//
//  ViewController.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 20/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var sideButtonsView: RHSideButtons!
    var buttonsArr = [RHButtonView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        sideButtonsView.setTriggerButtonPosition(CGPoint(x: castView().bounds.width - 85, y: castView().frame.size.height - 85))
        sideButtonsView.reloadButtons()
        
        performSelector(#selector(delayShow), withObject: nil, afterDelay: 1)
        performSelector(#selector(delayHide), withObject: nil, afterDelay: 2)
    }
    
    func delayShow() {
        sideButtonsView.showButtons()
    }
    
    func delayHide() {
        sideButtonsView.hideButtons()
    }
    
    override func loadView() {
        view = MainView()
    }
    
    private func castView() -> MainView {
        return view as! MainView
    }
    
    private func setup() {
        addSideButtons()
    }
    
    private func addSideButtons() {
        
        let triggerButton = RHTriggerButtonView(pressedImage: UIImage(named: "exit_icon")!) {
            $0.image = UIImage(named: "trigger_img")
            $0.hasShadow = true
        }
        
        sideButtonsView = RHSideButtons(parentView: castView(), triggerButton: triggerButton)
        sideButtonsView.delegate = self
        sideButtonsView.dataSource = self
        
        let button_1 = RHButtonView {
            $0.image = UIImage(named: "icon_1")
            $0.hasShadow = true
        }
        
        let button_2 = RHButtonView {
            $0.image = UIImage(named: "icon_2")
            $0.hasShadow = true
        }
        
        let button_3 = RHButtonView {
            $0.image = UIImage(named: "icon_3")
            $0.hasShadow = true
        }
        
        buttonsArr.appendContentsOf([button_1, button_2, button_3])
     
        sideButtonsView.reloadButtons()
    }
}

extension MainViewController: RHSideButtonsDataSource {
    
    func sideButtonsNumberOfButtons(sideButtons: RHSideButtons) -> Int {
        return buttonsArr.count
    }
    
    func sideButtons(sideButtons: RHSideButtons, buttonAtIndex index: Int) -> RHButtonView {
        return buttonsArr[index]
    }
}

extension MainViewController: RHSideButtonsDelegate {
    
    func sideButtons(sideButtons: RHSideButtons, didSelectButtonAtIndex index: Int) {
        print("🍭 button index tapped: \(index)")
    }
    
    func sideButtons(sideButtons: RHSideButtons, didTriggerButtonChangeStateTo state: RHButtonState) {
        print("🍭 Trigger button")
    }
}

