//
//  DrawCircle.swift
//  DrawCircleDemo
//
//  Created by ReasonAmu on 3/2/17.
//  Copyright © 2017 ReasonAmu. All rights reserved.
//

import UIKit

let k2Pi = 2 * M_PI

class DrawCircle: UIView {
    var isAnimation :Bool = true
    var layerShape: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //-- call hàm khởi tạo frame trước  ->>> call draw
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        //        setupUI()
        //        setupUI2()
        //        testDraw()
        test()
        
    }
    
    func setupUI(){
        let path = UIBezierPath() // khoi tao duong path
        layerShape = CAShapeLayer() // khoi tao layer
        let radius = self.frame.size.width/2 - 15
        // bat dau ve
        let point = CGPoint(x: self.frame.size.width/2 , y:  self.frame.size.height/2 ) //điểm chính giữa là giao điểm của width vs height
        /* góc radian trong khoảng 0 -> 2pi
         khi vẽ lineWidth càng to sẽ bị chớm ra ngoài frame ->> radius = width - (1 khoang = linewidth)
         */
        path.addArc(withCenter: point, radius: radius, startAngle: CGFloat(M_PI/6), endAngle: CGFloat(k2Pi) , clockwise: true) //add điểm
        path.stroke()// đổ nét chữ
        layerShape.strokeColor = UIColor.red.cgColor // màu nét vẽ
        layerShape.lineWidth = 15
        layerShape.path = path.cgPath
        layerShape.fillColor = UIColor.clear.cgColor //đổ màu nền bên trong vùng nét vẽ
        path.close()
        layerShape.strokeEnd = 0.0 // không vẽ ngay lúc nào
        self.layer.addSublayer(layerShape)
        self.addAnimation(duration: 3,layerShape : layerShape)
        
    }
    
    
    func setupUI2(){
        let radius = self.frame.size.width/2 - 15
        let point = CGPoint(x: self.frame.size.width/2 , y:  self.frame.size.height/2 ) //điểm chính giữa là giao điểm của width vs height
        layerShape = CAShapeLayer()
        self.animate(duration: 3, point:point , radius: radius)
    }
    
    
    
    
    func test (){
        let max : Int = 10
        var gap : CGFloat = 0.1
        var step: CGFloat = 0.0
//        var current : CGFloat = 11
//        gap = (gap * step) / CGFloat(max)
//        var gapAngle = gap * CGFloat(k2Pi)
//        var incr = (step - (step * gap)) / CGFloat(max)
//        var stepAngle  = incr * CGFloat(k2Pi)
//        startAngle = startAngle + CGFloat(gapAngle * 0.5)
        
        let path = UIBezierPath() // khoi tao duong path
        let lineWidth: CGFloat = 3
        layerShape = CAShapeLayer() // khoi tao layer
        let radius =  min(self.bounds.width, self.bounds.height)/2 - (lineWidth*2)
        let point = CGPoint(x: self.frame.size.width/2 , y:  self.frame.size.height/2 )
        let oneAngel : CGFloat = CGFloat(k2Pi)/CGFloat(10)
        let gocden : CGFloat = oneAngel - 0.1
        for _ in 0..<max {
//            destAngle = startAngle +
//            drawNow( point: point, radius: radius, startAngle: startAngle, endAngle: destAngle)
            
        }
        
        
    }
    
    var startAngle : CGFloat = 0.0
    let endPoint : CGPoint = CGPoint()
    var destAngle : CGFloat = 0.0
    
    func drawNow(point : CGPoint, radius : CGFloat , startAngle : CGFloat , endAngle : CGFloat){
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        path.addArc(withCenter: point, radius: radius, startAngle: startAngle, endAngle: endAngle , clockwise: true)
        path.addArc(withCenter: point, radius: radius/2, startAngle: endAngle, endAngle: startAngle , clockwise: false)
        path.close()
        print(destAngle)
        layer.strokeColor = UIColor.red.cgColor // màu nét vẽ
        layer.lineWidth = 3
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor //đổ màu nền bên trong vùng nét vẽ
        path.usesEvenOddFillRule = false
        self.layer.addSublayer(layer)
        self.addAnimation(duration: 10, layerShape: layer)
        destAngle = startAngle - 0.1
        
    }
    
    
}







extension DrawCircle {
    //MARK: Custom Animation
    func addAnimation(duration : TimeInterval, layerShape : CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd") //get thuộc tính
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        layerShape.add(animation, forKey: "animateCircle")
        layerShape.strokeEnd = 1.0
    }
}
extension DrawCircle {
    //MARK: Animation hava completion handler
    func animate(duration : TimeInterval , point : CGPoint, radius : CGFloat){
        self.isAnimation =  true
        self.animateCircleFull(duration : duration, point: point , radius : radius)
    }
    
    func endAnimate(){
        self.isAnimation = false
    }
    
    func animateCircleFull(duration : TimeInterval, point : CGPoint, radius : CGFloat) {
        if self.isAnimation {
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = duration
            animation.fromValue = 0
            animation.toValue = 1
            animation.timingFunction  = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            layerShape.strokeEnd = 1
            CATransaction.setCompletionBlock({
                self.setCircleCounterClockwise(point: point, radius: radius)
                self.cleanAnimateCircle(duration: duration, point:  point , radius: radius ) //-- block call function cleanAnimateCircle
            })
            layerShape.add(animation, forKey: "animationCircle")
            CATransaction.commit()
        }
    }
    
    func cleanAnimateCircle(duration : TimeInterval, point : CGPoint, radius : CGFloat ) {
        if self.isAnimation {
            CATransaction.begin()
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.duration = duration
            animation.fromValue = 1
            animation.toValue = 0
            animation.timingFunction  = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            layerShape.strokeEnd = 0
            CATransaction.setCompletionBlock({
                self.setCircleClockwise(point: point, radius: radius)
                self.animateCircleFull(duration: duration, point:  point , radius: radius) //-- block call lại function animateCircleFull
            })
            layerShape.add(animation, forKey: "animationCircle")
            CATransaction.commit()
        }
    }
    func fomatCircle(circlePath : UIBezierPath, lineWidth : CGFloat) -> CAShapeLayer{
        let layerShape = CAShapeLayer()
        layerShape.path = circlePath.cgPath //-- path
        layerShape.fillColor = UIColor.clear.cgColor
        layerShape.strokeColor  = UIColor.red.cgColor
        layerShape.lineWidth = lineWidth
        layerShape.strokeEnd = 0.0
        return layerShape
    }
    
    func setCircleClockwise(point : CGPoint, radius : CGFloat){
        let circlePath = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: true)
        self.layerShape.removeFromSuperlayer()
        self.layerShape = fomatCircle(circlePath: circlePath, lineWidth: 5)
        self.layer.addSublayer(self.layerShape)
    }
    
    func setCircleCounterClockwise(point : CGPoint, radius : CGFloat){
        let circlePath = UIBezierPath(arcCenter: point, radius: radius, startAngle: 0.0, endAngle: CGFloat(M_PI * 2.0), clockwise: false)
        self.layerShape.removeFromSuperlayer()
        self.layerShape = fomatCircle(circlePath: circlePath, lineWidth: 5)
        self.layer.addSublayer(self.layerShape)
    }
    
}
extension DrawCircle {
    
    func testDraw(){
        let path = UIBezierPath() // khoi tao duong path
        let lineWidth: CGFloat = 3
        layerShape = CAShapeLayer() // khoi tao layer
        let radius =  min(self.bounds.width, self.bounds.height)/2 - (lineWidth*2)
        // bat dau ve
        let point = CGPoint(x: self.frame.size.width/2 , y:  self.frame.size.height/2 ) //điểm chính giữa là giao điểm của width vs height
        path.addArc(withCenter: point, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI) , clockwise: true) //add điểm
        path.addArc(withCenter: point, radius: radius/2 , startAngle: CGFloat(M_PI), endAngle: 0 , clockwise: false) //add điểm
        path.stroke()// đổ nét chữ
        path.close()
        layerShape.strokeColor = UIColor.red.cgColor // màu nét vẽ
        layerShape.lineWidth = lineWidth
        layerShape.path = path.cgPath
        layerShape.fillColor = UIColor.clear.cgColor //đổ màu nền bên trong vùng nét vẽ
        path.usesEvenOddFillRule = true
        layerShape.strokeEnd = 0.0 // không vẽ ngay lúc này
        self.layer.addSublayer(layerShape)
        self.addAnimation(duration: 3,layerShape : layerShape)
        
        let calulator : Float = Float(0.1/11)
        print(calulator)
        NSLog("%.20f",calulator);
    }
}
