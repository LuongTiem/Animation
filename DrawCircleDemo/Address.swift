//
//  Address.swift
//  DrawCircleDemo
//
//  Created by ReasonAmu on 3/14/17.
//  Copyright © 2017 ReasonAmu. All rights reserved.
//

import UIKit

class Address: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if lineShape != nil {
          self.lineShape.removeFromSuperlayer()
        }
        drawPoint()
    }
    
    
    
    var circleShape :CAShapeLayer!
    var lineShape : CAShapeLayer!
    func  drawPoint () {
        
        circleShape = CAShapeLayer()
        let circlePath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 5, height: 5))
        circlePath.close()
        circleShape.position = CGPoint(x:5, y: 5)
        circleShape.path = circlePath.cgPath
        circleShape.fillColor  = UIColor.white.cgColor
        circleShape.strokeColor = UIColor.green.cgColor
        self.layer.addSublayer(circleShape)
        
        lineShape = CAShapeLayer()
        let linePath = UIBezierPath()
        let point1 = CGPoint(x: 0, y:  0 )
        let point2 = CGPoint(x: point1.x + self.bounds.maxX - 10, y: point1.y)
        let point3 = CGPoint(x: self.bounds.maxX, y: bounds.maxY - 10)
        linePath.move(to: point1)
        linePath.addLine(to: point2)
        linePath.addLine(to: point3)
        linePath.close()
        
        lineShape.path = linePath.cgPath
        lineShape.strokeColor = UIColor.red.cgColor
        lineShape.position = CGPoint(x: 5, y: 5)
        lineShape.anchorPoint = CGPoint(x: 1, y: 1)
        lineShape.frame = self.frame
        lineShape.fillColor = nil
        linePath.lineWidth = 1
        self.layer.addSublayer(lineShape)
        
    }
}
