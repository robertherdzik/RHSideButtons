//
//  RHTriggerButtonView.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 26/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

public class RHTriggerButtonView: RHButtonView {
    
    fileprivate var notPressedImageHolder: UIImage?
    fileprivate var pressedImage: UIImage?
    
    public init(frame: CGRect, pressedImage: UIImage) {
        self.pressedImage = pressedImage
        
        super.init(frame: frame)
    }
    
    convenience public init(pressedImage: UIImage, builder: BuildCellBlock) {
        self.init(frame: CGRect.zero, pressedImage: pressedImage)
        
        builder(self)
    }
    
    convenience public init(pressedImage: UIImage, builder: RHButtonViewConfigProtocol) {
        self.init(frame: CGRect.zero, pressedImage: pressedImage)
        
        bgColor = builder.bgColor
        image = builder.image
        hasShadow = builder.hasShadow
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func markAsPressed(_ pressed: Bool) {
        if notPressedImageHolder == nil { notPressedImageHolder = image }
        
        image = pressed ? pressedImage : notPressedImageHolder
    }
}
