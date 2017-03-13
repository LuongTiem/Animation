//
//  ViewController.swift
//  DrawCircleDemo
//
//  Created by ReasonAmu on 2/25/17.
//  Copyright © 2017 ReasonAmu. All rights reserved.
//

import UIKit
import CoreGraphics


class ViewController: UIViewController {
    
    lazy var graphTest : GraphView = {
        let view = GraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        
        return view
    }()
    
    
    lazy var drawCircle : DrawCircle = {
        let view = DrawCircle()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupUI()
//        setupDrawCircle()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension ViewController {
    
    func setupDrawCircle(){
        view.addSubview(drawCircle)
        drawCircle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        drawCircle.centerYAnchor.constraint(equalTo:  view.centerYAnchor).isActive = true
        drawCircle.widthAnchor.constraint(equalToConstant: 300).isActive = true
        drawCircle.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    
    func setupUI(){
        view.addSubview(graphTest)
        graphTest.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        graphTest.centerYAnchor.constraint(equalTo:  view.centerYAnchor).isActive = true
        graphTest.widthAnchor.constraint(equalToConstant: 300).isActive = true
        graphTest.heightAnchor.constraint(equalToConstant: 300).isActive = true
  
    
    }
    

   
    

    

    
}

