//
//  RHButtonViewConfigProtocol.swift
//  RHSideButtons
//
//  Created by Robert Herdzik on 22/05/16.
//  Copyright © 2016 Robert Herdzik. All rights reserved.
//

import UIKit

public protocol RHButtonViewConfigProtocol: class {
    var bgColor: UIColor { get set }
    var image: UIImage? { get set }
    var hasShadow: Bool { get set }
}
