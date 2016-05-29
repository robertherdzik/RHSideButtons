//
//  RHButtonView.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 22/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

protocol RHButtonViewDelegate: class {
    func didSelectButton(buttonView: RHButtonView)
}

class RHButtonView: UIView, RHButtonViewConfigProtocol {
    
    typealias BuildCellBlock = (RHButtonViewConfigProtocol) -> Void
    
    weak var delegate: RHButtonViewDelegate?
    
    var bgColor: UIColor = UIColor.whiteColor() {
        didSet {
            backgroundColor = bgColor
        }
    }
    var image: UIImage? {
        didSet {
            setupImageViewIfNeeded()
            updateImageView()
            
            layoutIfNeeded()
        }
    }
    var hasShadow: Bool = true {
        didSet {
            hasShadow ? addShadow() : removeShadow()
            
            layoutIfNeeded()
        }
    }
    var imgView: UIImageView?
    
    private let overlayView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    convenience init(builder: BuildCellBlock) {
        self.init(frame: CGRect.zero)
        
        builder(self)
    }
    
    convenience init(builder: RHButtonViewConfigProtocol) {
        self.init(frame: CGRect.zero)
        
        bgColor = builder.bgColor
        image = builder.image
        hasShadow = builder.hasShadow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // View Appearance
        layer.cornerRadius = bounds.width/2
        
        //Overlay Layer
        overlayView.frame = bounds
        overlayView.layer.cornerRadius = layer.cornerRadius
        
        // Image View
        imgView?.frame = bounds
        imgView?.layer.cornerRadius = layer.cornerRadius
        
        // Shadow
        setShadowOffset(false)
    }
    
    private func setup() {
        setupOverlayLayer()
    }
    
    private func setupOverlayLayer() {
        overlayView.backgroundColor = UIColor.clearColor()
        overlayView.userInteractionEnabled = false
        addSubview(overlayView)
    }
    
    private func setupImageViewIfNeeded() {
        if imgView != nil { return }
        
        imgView = UIImageView(image: image)
        insertSubview(imgView!, belowSubview: overlayView)
    }
    
    private func updateImageView() {
        imgView?.image = image
        imgView?.contentMode = .ScaleAspectFit
        imgView?.clipsToBounds = true
    }
    
    private func addShadow() {
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.darkGrayColor().CGColor
    }
    
    private func removeShadow() {
        layer.shadowOpacity = 0
    }
    
    private func setShadowOffset(isSelected: Bool) {
        let shadowOffsetX = isSelected ? CGFloat(1) : CGFloat(5)
        let shadowOffsetY = isSelected ? CGFloat(0) : CGFloat(3)
        layer.shadowOffset = CGSize(width: bounds.origin.x + shadowOffsetX, height: bounds.origin.y + shadowOffsetY)
    }
    
    private func adjustAppearanceForStateSelected(selected: Bool) {
        setShadowOffset(selected)
        setOverlayColorForState(selected)
    }
    
    private func setOverlayColorForState(selected: Bool) {
        overlayView.backgroundColor = selected ? UIColor.blackColor().colorWithAlphaComponent(0.2) : UIColor.clearColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        adjustAppearanceForStateSelected(true)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        adjustAppearanceForStateSelected(false)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        delegate?.didSelectButton(self)
        adjustAppearanceForStateSelected(false)
    }
}