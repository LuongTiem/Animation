//
//  GraphView.swift
//  DrawCircleDemo
//
//  Created by ReasonAmu on 2/28/17.
//  Copyright © 2017 ReasonAmu. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreLocation
import MapKit
let EARTH_RADIUS:CGFloat = 6371
class GraphView: UIView {
    
    let locationManager = CLLocationManager()
    var SIZEVIEW : CGSize!
    var SCALE : CGFloat!
    var OFFSET : CGFloat!
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        SIZEVIEW  = self.frame.size
        SCALE   =   min(SIZEVIEW.width, SIZEVIEW.height) / (EARTH_RADIUS * 2)
        OFFSET = min(SIZEVIEW.width, SIZEVIEW.height)/2
        drawTest()
//        drawPoint()
        /*
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.startUpdatingLocation()
        }
        */
        
    }
    
    
    
    
    
    var listPoint : [CGPoint] =  [
        CGPoint(x: 20.990449, y:105.791139),
        CGPoint(x: 22.990438, y:105.791144),
        CGPoint(x: 24.990426, y:105.791148),
        CGPoint(x: 25.990415, y:105.791151),
        CGPoint(x: 40.990405, y:105.791155),
        CGPoint(x: 50.990393, y:105.791158),
        CGPoint(x: 20.990380, y: 90.791161),
        CGPoint(x: 55.990367, y:105.791166),
        CGPoint(x: 59.990354, y:105.791171),
        CGPoint(x: 60.990341, y:105.791175),
        CGPoint(x: 70.990328, y:105.791177),
        CGPoint(x: 0.990316, y:105.791163),
        CGPoint(x: 40.990311, y: 80.791146),
        CGPoint(x: 70.990306, y: 105.791126),
        CGPoint(x: 80.990302, y: 105.791107),
        CGPoint(x: 40.990311, y : 105.791082)
    ]
    
    
    func convert(logicPoint: CGPoint) -> CGPoint {
        var returnPoint: CGPoint = CGPoint(x: 0.0, y: 0.0)
        returnPoint.x = abs((logicPoint.x) * (self.frame.size.width/90))
        returnPoint.y = abs(self.frame.size.height - ( logicPoint.y * self.frame.size.height/180))
        return returnPoint
    }
    

    
    var arrayX : [CGFloat] =  []
    var arrayY : [CGFloat] =  []
    var pathBezier : UIBezierPath = UIBezierPath()
    
    func drawPoint() {
        let layer = CAShapeLayer()
        _ = listPoint.flatMap {
            arrayX.append($0.x)
            arrayY.append($0.y)
        }
        
        var listX : [CGFloat] = []
        var listY : [CGFloat] = []

        
        
        for index in 0...arrayX.count {
            if index < arrayX.count-1 {
                 listX.append(arrayX[index+1] - arrayX[index])
            }
           
           
        }
        
        
        for index in 0...arrayY.count {
            if index < arrayY.count-1 {
                 listY.append(arrayY[index+1] - arrayY[index])
            }
           
        }
        
        
        var newPoints : [CGPoint] = []
        for index in 0..<listX.count {
            let newPoint =  self.gpsToPoint(abs(listX[index]), abs(listY[index]))
            newPoints.append(newPoint)
             print(newPoints)
        }
        
        
        for (i, element) in newPoints.enumerated() {
            if i == 0 {
                pathBezier.move(to:  self.convert(logicPoint: element))
                drawCircle(convertPoint: self.convert(logicPoint: element) , radius: 3)
            }
            let point = self.convert(logicPoint: element)
            pathBezier.addLine(to: point)
            
        }
        
        
        pathBezier.lineWidth = 10
        pathBezier.miterLimit  = 3
        pathBezier.stroke()
        pathBezier.lineJoinStyle = .round
        layer.path = pathBezier.cgPath
        layer.strokeColor = UIColor.yellow.cgColor
        pathBezier.usesEvenOddFillRule = true
        pathBezier.close()
        self.layer.addSublayer(layer)
        
    }
    
    func gpsToPoint(_ lat : CGFloat , _ long : CGFloat) -> CGPoint {
        let newX = lat * 1000000
        let newY = long * 1000000
        let point = CGPoint(x: newX, y: newY)
        print(point)
        
        return point
    }
    
    
    
    func drawCircle(convertPoint : CGPoint, radius : CGFloat){
        let rect = CGRect(x: convertPoint.x, y: convertPoint.y, width: radius, height: radius)
        let dotPath = UIBezierPath(ovalIn: rect)
        let layer = CAShapeLayer()
        layer.path = dotPath.cgPath
        layer.strokeColor = UIColor.blue.cgColor
        self.layer.addSublayer(layer)
    }
    
    var testGPS : [CGPoint] = []
    var listConvert : [CGPoint] = []
    
}

extension GraphView  : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let X = location?.coordinate.latitude
        let Y = location?.coordinate.longitude
        testGPS.append(CGPoint(x: X!, y: Y!))
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.layer.sublayers = nil
            self.pathBezier.removeAllPoints()
            self.setNeedsDisplay()
            //            self.listPoint.removeAll()
            //            self.listPoint = self.testGPS
            self.drawPoint()
            
        }
    }
    
    func convertLatLongCoord(latlong : CGPoint) ->  CGPoint {
        let x : CGFloat = EARTH_RADIUS * cos(latlong.x) * cos(latlong.y) * SCALE  + OFFSET
        let y : CGFloat = EARTH_RADIUS * cos(latlong.x) * sin(latlong.y ) * SCALE + OFFSET
        return CGPoint(x: x, y: y)
    }
    
   
    
    func drawTest(){
         let layer = CAShapeLayer()
        for i  in listPoint.enumerated() {
            let convert : CGPoint = convertLatLongCoord(latlong: i.element)
            if i.offset == 0 {
                pathBezier.move(to: convert)
            }else {
              listConvert.append(convert)
              pathBezier.addLine(to: convert)
            }
        }
        
           print(listConvert)
        
        pathBezier.lineWidth = 10
        pathBezier.miterLimit  = 3
        pathBezier.stroke()
        pathBezier.lineJoinStyle = .round
        layer.path = pathBezier.cgPath
        layer.strokeColor = UIColor.yellow.cgColor
        pathBezier.usesEvenOddFillRule = true
        pathBezier.close()
        self.layer.addSublayer(layer)
    }
    
}

