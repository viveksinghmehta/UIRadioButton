//
//  RadioButton.swift
//  RadioButton
//
//  Created by Vindeshwar Rai on 07/05/19.
//  Copyright © 2019 Vivek Singh Mehta. All rights reserved.
//

import UIKit

@IBDesignable
class UIRadioButton: UIButton {

    private var outerCircle: CAShapeLayer!
    private var innerCircle: CAShapeLayer!
    
    
    @IBInspectable public var outerCircleColor: UIColor = UIColor(red: 119/255, green: 117/255, blue: 246/255, alpha: 1.0) {
        didSet {
            removeOuterCircle()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable public var outerFillColor: UIColor = .white {
        didSet {
            removeOuterCircle()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable public var innerFillColor: UIColor = UIColor(red: 119/255, green: 117/255, blue: 246/255, alpha: 1.0) {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable public var outerWidth: CGFloat = 3.0 {
        didSet {
            removeOuterCircle()
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable public var isRadioEnabled: Bool = false {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createOuterCircle()
        if isRadioEnabled {
            createinnerCircle()
        } else {
            removeInnerCircle()
        }
    }
    
    private func removeOuterCircle() {
        if outerCircle != nil {
            outerCircle.removeFromSuperlayer()
            outerCircle = nil
        }
    }
    
    private func removeInnerCircle() {
        if innerCircle != nil {
            innerCircle.removeFromSuperlayer()
            innerCircle = nil
        }
    }
    
    private func createOuterCircle() {
        if outerCircle == nil {
            outerCircle = CAShapeLayer()
            outerCircle.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.bounds.height / 2).cgPath
            outerCircle.fillColor = outerFillColor.cgColor
            outerCircle.strokeColor = outerCircleColor.cgColor
            outerCircle.lineWidth = outerWidth
            layer.insertSublayer(outerCircle, at: 0)
        }
    }
    
    private func createinnerCircle() {
        if innerCircle == nil {
            innerCircle = CAShapeLayer()
            let centerPoint = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
            let radius = (self.bounds.height / 2) - (outerWidth + 2)
            innerCircle.path = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat.zero, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
            innerCircle.fillColor = innerFillColor.cgColor
            layer.insertSublayer(innerCircle, at: 1)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            isRadioEnabled = !isRadioEnabled
        }
        super.touchesBegan(touches, with: event)
    }

}
