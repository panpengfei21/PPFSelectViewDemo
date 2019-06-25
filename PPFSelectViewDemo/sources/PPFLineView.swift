//
//  PPFLineView.swift
//  PPFSelectViewDemo
//
//  Created by 潘鹏飞 on 2019/6/25.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit

public class PPFLineView: UIView {
    var lineLayer:CAShapeLayer!
    
    var color:UIColor
    
    public init(color:UIColor) {
        self.color = color
        super.init(frame: CGRect.zero)
        backgroundColor = UIColor.clear
        lineLayer = {
            let l = CAShapeLayer()
            l.lineCap = .round
            layer.addSublayer(l)
            return l
        }()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        let path:UIBezierPath = {
            let p = UIBezierPath()
            p.move(to: CGPoint(x: 0, y: rect.height / 2))
            p.addLine(to: CGPoint(x: rect.width, y: rect.height / 2))
            return p
        }()
        lineLayer.path = path.cgPath
        lineLayer.lineWidth = rect.height
        lineLayer.strokeColor = color.cgColor
    }
    
    public func showInStart(_ start:CGFloat,end:CGFloat) {
        lineLayer.strokeStart = start
        lineLayer.strokeEnd = end
    }
}
