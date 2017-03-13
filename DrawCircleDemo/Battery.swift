//
//  Battely.swift
//  DrawCircleDemo
//
//  Created by ReasonAmu on 3/13/17.
//  Copyright © 2017 ReasonAmu. All rights reserved.
//

import UIKit

class Battery: UIView {
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        
    }
    
    
    let batteryLayer : CAShapeLayer = CAShapeLayer()
    let halfCircleLayer  : CAShapeLayer = CAShapeLayer()
    
    
    func setupUI() {
        let batteryPath = UIBezierPath()
        let point1 = CGPoint(x: 3, y: 3)
        let point2 = CGPoint(x: 40, y: 3)
        let point3 = CGPoint(x: 41, y: 4)
        let point4 = CGPoint(x: 41, y: 14)
        let point5 = CGPoint(x: 40, y: 15)
        let point6 = CGPoint(x: 3, y: 15)
        let point7 = CGPoint(x: 2, y: 14)
        let point8 = CGPoint(x: 2, y: 4)
        batteryPath.move(to: point1)
        batteryPath.addLine(to: point2)
        batteryPath.addLine(to: point3)
        batteryPath.addLine(to: point4)
        batteryPath.addLine(to: point5)
        batteryPath.addLine(to: point6)
        batteryPath.addLine(to: point7)
        batteryPath.addLine(to: point8)
        batteryPath.close()
        batteryLayer.path = batteryPath.cgPath
        batteryLayer.lineWidth = 1
        batteryLayer.strokeColor = UIColor.white.cgColor
        batteryLayer.fillColor  = UIColor.green.cgColor
        self.layer.addSublayer(batteryLayer)
        
        
        //-- draw Circle
        let subPath = UIBezierPath()
        let centerCircle = CGPoint(x: 42, y: 9)
        subPath.addArc(withCenter: centerCircle, radius: 2.5, startAngle: CGFloat(M_PI) * 1.5 , endAngle: CGFloat(M_PI_2), clockwise: true)
        subPath.close()
        halfCircleLayer.path = subPath.cgPath
        halfCircleLayer.lineWidth = 0.5
        halfCircleLayer.strokeColor = nil
        halfCircleLayer.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(halfCircleLayer)
    }
    
}
