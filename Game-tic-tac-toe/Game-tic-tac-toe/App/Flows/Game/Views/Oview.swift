//
//  Oview.swift
//  Game-tic-tac-toe
//
//  Created by Alexander Grigoryev on 16.01.2022.
//

import Foundation
import UIKit

public class Oview: MarkView {
    
    internal override func updateShapeLayer() {
        super.updateShapeLayer()
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius = 0.3 * min(bounds.width, bounds.height)
        shapeLayer.path = UIBezierPath(arcCenter: center,
                                       radius: radius,
                                       startAngle: 330 * CGFloat.pi / 180,
                                       endAngle: -30 * CGFloat.pi / 180,
                                       clockwise: false).cgPath
    }
}
