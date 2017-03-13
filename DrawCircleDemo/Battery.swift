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
        fillBattery()
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
         print(print(self.bounds.minX))
         print(print(self.bounds.maxX))
    }
    
    
    let batteryLayer : CAShapeLayer = CAShapeLayer()
    let halfCircleLayer  : CAShapeLayer = CAShapeLayer()
    let klineWidth : CGFloat = 1.5
    
    func setupUI() {
        let boundCircle : CGFloat = self.bounds.width/10
        let roundShape : CGFloat = self.bounds.height/16
        let batteryPath = UIBezierPath()
        let point1 = CGPoint(x: self.bounds.minX + 2, y: self.bounds.minY + 3 + roundShape)
        let point2 = CGPoint(x: self.bounds.minX + 3 + roundShape , y: self.bounds.minY + 3)
        let point3 = CGPoint(x: self.bounds.maxX - boundCircle - roundShape, y: self.bounds.minY + 3)
        let point4 = CGPoint(x: self.bounds.maxX - boundCircle, y: self.bounds.minY + 3 + roundShape)
        let point5 = CGPoint(x: self.bounds.maxX - boundCircle, y: self.bounds.maxY - klineWidth - roundShape - 2 )
        let point6 = CGPoint(x: self.bounds.maxX - boundCircle - roundShape, y: self.bounds.maxY - klineWidth - 2)
        let point7 = CGPoint(x: self.bounds.minX + 3 + roundShape, y: self.bounds.maxY - klineWidth - 2)
        let point8 = CGPoint(x: self.bounds.minX + 2, y: point7.y - roundShape)
        
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
        batteryLayer.lineWidth = klineWidth
        batteryLayer.strokeColor = UIColor.white.cgColor
        batteryLayer.fillColor  = nil
        self.layer.addSublayer(batteryLayer)
        
        //-- draw Circle
        let subPath = UIBezierPath()
        let centerCircle = CGPoint(x: self.bounds.maxX - boundCircle + 1, y: self.bounds.midY)
        subPath.addArc(withCenter: centerCircle, radius: self.bounds.maxY/5, startAngle: CGFloat(M_PI) * 1.5 , endAngle: CGFloat(M_PI_2), clockwise: true)
        subPath.close()
        halfCircleLayer.path = subPath.cgPath
        halfCircleLayer.lineWidth = 0.5
        halfCircleLayer.strokeColor = nil
        halfCircleLayer.fillColor = UIColor.white.cgColor
        self.layer.addSublayer(halfCircleLayer)
    }
    
    func fillBattery() {
        let fillLayer : CAShapeLayer = CAShapeLayer()
        let roundShape : CGFloat = self.bounds.height/16
        let batteryFillPath = UIBezierPath()
        let point1 = CGPoint(x: self.bounds.minX + 2, y: self.bounds.minY + 3 + roundShape)
        let point2 = CGPoint(x: self.bounds.minX + 3 + roundShape , y: self.bounds.minY + 3)
        let point3 = CGPoint(x: point2.x  + 20, y: point2.y)
        let point4 = CGPoint(x: point3.x, y: self.bounds.maxY - klineWidth - 2 )
        let point5 = CGPoint(x: self.bounds.minX + 3 + roundShape, y: point4.y)
        let point6 = CGPoint(x: self.bounds.minX + 2, y: point5.y - roundShape)
        batteryFillPath.move(to: point1)
        batteryFillPath.addLine(to: point2)
        batteryFillPath.addLine(to: point3)
        batteryFillPath.addLine(to: point4)
        batteryFillPath.addLine(to: point5)
        batteryFillPath.addLine(to: point6)
        batteryFillPath.close()
        
        fillLayer.path = batteryFillPath.cgPath
        fillLayer.lineWidth = klineWidth
        fillLayer.strokeColor = nil
        fillLayer.fillColor  = UIColor.white.cgColor
        self.layer.addSublayer(fillLayer)
    }
    
}
