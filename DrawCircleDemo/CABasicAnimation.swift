

//
//  CABasicAnimation.swift
//  DrawCircleDemo
//
//  Created by ReasonAmu on 3/12/17.
//  Copyright © 2017 ReasonAmu. All rights reserved.
//

import UIKit

class BasicAnimation: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let leftFoot = UIImageView(image: #imageLiteral(resourceName: "Left_Foot"))
    let rightFoot = UIImageView(image:#imageLiteral(resourceName: "Right_Foot"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        animation(duration: 2)
    }
    
    
    
    func setupUI() {
        
        self.addSubview(leftFoot)
         leftFoot.translatesAutoresizingMaskIntoConstraints =  false
        leftFoot.contentMode = .scaleAspectFit
        leftFoot.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftFoot.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        leftFoot.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        leftFoot.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func animation(duration : TimeInterval ) {
        let ani = CABasicAnimation(keyPath: "position.y")
            ani.duration = duration
            ani.fromValue = self.bounds.origin.y
            ani.toValue = self.bounds.maxY
            ani.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            ani.repeatCount = HUGE
        
        self.layer.contents =  #imageLiteral(resourceName: "Left_Foot").cgImage
        self.layer.contentsGravity = kCAGravityResizeAspect
        layer.isGeometryFlipped = true
        
        self.layer.add(ani, forKey: "")
    }
}

extension BasicAnimation {
    
  
    
}
