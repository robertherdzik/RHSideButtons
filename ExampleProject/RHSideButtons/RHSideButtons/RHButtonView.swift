//
//  RHButtonView.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 22/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

protocol RHButtonViewDelegate: class {
    func didSelectButton(_ buttonView: RHButtonView)
}

class RHButtonView: UIView, RHButtonViewConfigProtocol {
    
    typealias BuildCellBlock = (RHButtonViewConfigProtocol) -> Void
    
    weak var delegate: RHButtonViewDelegate?
    
    var bgColor: UIColor = UIColor.white {
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
    
    fileprivate let overlayView = UIView()
    
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
    
    fileprivate func setup() {
        setupOverlayLayer()
    }
    
    fileprivate func setupOverlayLayer() {
        overlayView.backgroundColor = UIColor.clear
        overlayView.isUserInteractionEnabled = false
        addSubview(overlayView)
    }
    
    fileprivate func setupImageViewIfNeeded() {
        if imgView != nil { return }
        
        imgView = UIImageView(image: image)
        insertSubview(imgView!, belowSubview: overlayView)
    }
    
    fileprivate func updateImageView() {
        imgView?.image = image
        imgView?.contentMode = .scaleAspectFit
        imgView?.clipsToBounds = true
    }
    
    fileprivate func addShadow() {
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    fileprivate func removeShadow() {
        layer.shadowOpacity = 0
    }
    
    fileprivate func setShadowOffset(_ isSelected: Bool) {
        let shadowOffsetX = isSelected ? CGFloat(1) : CGFloat(5)
        let shadowOffsetY = isSelected ? CGFloat(0) : CGFloat(3)
        layer.shadowOffset = CGSize(width: bounds.origin.x + shadowOffsetX, height: bounds.origin.y + shadowOffsetY)
    }
    
    fileprivate func adjustAppearanceForStateSelected(_ selected: Bool) {
        setShadowOffset(selected)
        setOverlayColorForState(selected)
    }
    
    fileprivate func setOverlayColorForState(_ selected: Bool) {
        overlayView.backgroundColor = selected ? UIColor.black.withAlphaComponent(0.2) : UIColor.clear
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        adjustAppearanceForStateSelected(true)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        adjustAppearanceForStateSelected(false)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didSelectButton(self)
        adjustAppearanceForStateSelected(false)
    }
}
