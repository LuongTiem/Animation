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
        UIDevice.current.isBatteryMonitoringEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: NSNotification.Name.UIDeviceBatteryLevelDidChange, object: nil)
        fillBattery()
        setupUI()
    }
    
    let batteryLayer : CAShapeLayer = CAShapeLayer()
    let halfCircleLayer  : CAShapeLayer = CAShapeLayer()
    var batteryFillPath : UIBezierPath!
    var fillLayer : CAShapeLayer!
    let klineWidth : CGFloat = 1.5
    var distance : CGFloat = 0.0
    
    func setupUI() {
        let boundCircle : CGFloat = self.bounds.width/10
        let roundShape : CGFloat = self.bounds.height/20
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
        distance = distance(point1: point1, point2: point4)
    }
    
    func fillBattery() {
        fillLayer =  CAShapeLayer()
        batteryFillPath = UIBezierPath()
        let roundShape : CGFloat = self.bounds.height/20
        let boundCircle : CGFloat = self.bounds.width/10
        let point1 = CGPoint(x: self.bounds.minX + 2, y: self.bounds.minY + 3 + roundShape)
        let point2 = CGPoint(x: self.bounds.minX + 3 + roundShape , y: self.bounds.minY + 3)
        var point3 = CGPoint(x:  point1.x  + distance/100 * 10, y: point2.y)
        let point4 = CGPoint(x: self.bounds.maxX - boundCircle, y: self.bounds.minY + 3 + roundShape)
        let point5 = CGPoint(x: self.bounds.maxX - boundCircle, y: self.bounds.maxY - klineWidth - roundShape - 2 )
        var point6 = CGPoint(x: point3.x, y: self.bounds.maxY - klineWidth - 2 )
        let point7 = CGPoint(x: self.bounds.minX + 3 + roundShape, y: self.bounds.maxY - klineWidth - 2)
        let point8 = CGPoint(x: self.bounds.minX + 2, y: point7.y - roundShape)
        
        /// add point static
        batteryFillPath.move(to: point1)
        batteryFillPath.addLine(to: point2)
        
        //-- check battery
        let batteryLevel : Float =   abs(UIDevice.current.batteryLevel)  * 100.0
        if CGFloat(batteryLevel) <= 10 {
            point3 = CGPoint(x: point1.x  + distance/100 * 10 , y: point2.y)
            point6 = CGPoint(x: point3.x, y: self.bounds.maxY - klineWidth - 2)
            batteryFillPath.addLine(to: point3)
            batteryFillPath.addLine(to: point6)
            batteryFillPath.addLine(to: point7)
            batteryFillPath.addLine(to: point8)
            
        }
        else if CGFloat (batteryLevel) >= 90 {
            point3 = CGPoint(x: self.bounds.maxX - boundCircle - roundShape, y: self.bounds.minY + 3)
            point6 = CGPoint(x: self.bounds.maxX - boundCircle - roundShape, y: self.bounds.maxY - klineWidth - 2)
            batteryFillPath.addLine(to: point3)
            batteryFillPath.addLine(to: point4)
            batteryFillPath.addLine(to: point5)
            batteryFillPath.addLine(to: point6)
            batteryFillPath.addLine(to: point7)
            batteryFillPath.addLine(to: point8)
        }
        else {
            point3 = CGPoint(x: point1.x  + distance/100 * CGFloat(batteryLevel) , y: point2.y)
            point6 = CGPoint(x: point3.x, y: self.bounds.maxY - klineWidth - 2)
            batteryFillPath.addLine(to: point3)
            batteryFillPath.addLine(to: point6)
            batteryFillPath.addLine(to: point7)
            batteryFillPath.addLine(to: point8)
        }
        
        batteryFillPath.close()
        fillLayer.path = batteryFillPath.cgPath
        fillLayer.lineWidth = klineWidth
        fillLayer.strokeColor = nil
        fillLayer.fillColor  = UIColor.white.cgColor
        self.layer.addSublayer(fillLayer)
        self.updateFocusIfNeeded()
    }
    
    /// distance
    func distance (point1: CGPoint , point2 : CGPoint) -> CGFloat {
        return CGFloat(hypotf(Float(point1.x) - Float(point2.x), Float(point1.y) - Float(point2.y)))
    }
    
}

extension Battery {
    
    func batteryLevelDidChange() {
        batteryFillPath.removeAllPoints()
        fillLayer.removeFromSuperlayer()
        fillBattery()
    }
}

/*
 struct getBattery {
 private static var device : UIDevice {
 get {
 let dev = UIDevice.current
 dev.isBatteryMonitoringEnabled = true
 return dev
 }
 }
 
 /// The current level of the battery
 public static var level: Float? {
 
 let batteryCharge = device.batteryLevel
 if batteryCharge > 0 {
 return batteryCharge * 100
 } else {
 return nil
 }
 }
 }
 */
