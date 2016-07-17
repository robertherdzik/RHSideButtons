//
//  ViewController.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 20/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var demoPresenter: ButtonsDemoPresenter?
    var buttonsArr = [RHButtonView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
     
        castView().sideButtonsView?.reloadButtons()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        // We want to see demo after view did appear
        demoPresenter?.start()
    }
    
    override func loadView() {
        view = MainView()
    }
    
    func castView() -> MainView {
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
        
        let sideButtonsView = RHSideButtons(parentView: castView(), triggerButton: triggerButton)
        sideButtonsView.delegate = self
        sideButtonsView.dataSource = self
        
        for index in 1...3 {
            buttonsArr.append(generateButton(withImgName: "icon_\(index)"))
        }
        
        castView().set(sideButtonsView: sideButtonsView)
        castView().sideButtonsView?.reloadButtons()
    }
    
    private func generateButton(withImgName imgName: String) -> RHButtonView {
        
        return RHButtonView {
            $0.image = UIImage(named: imgName)
            $0.hasShadow = true
        }
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

