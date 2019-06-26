//
//  PPFLineView.swift
//  PPFSelectViewDemo
//
//  Created by 潘鹏飞 on 2019/6/25.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit

@objc public protocol PPFLineView_Delegate {
    /// 开头端动画的持续时间
    func ppfLineView(_ lView:PPFLineView,animationDurationForBegin layer:CAShapeLayer) -> CFTimeInterval
    /// 结尾端动画的持续时间
    func ppfLineView(_ lView:PPFLineView,animationDurationForEnd layer:CAShapeLayer) -> CFTimeInterval
}

/// 可滑动的线
@objc public class PPFLineView: UIView {
    /// 动画类型
    @objc public enum AnimationType:Int {
        /// 无动画
        case none
        /// 默认
        case `default`
        /// 要实现代理里的两种回调方法,来获取动画持续时间
        case type0
    }
    
    var lineLayer:CAShapeLayer!
    /// 滑线的颜色
    var color:UIColor
    
    public var animationType:AnimationType = .default
    
    weak var delegate:PPFLineView_Delegate?
    
    @objc public init(color:UIColor) {
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
    
    @objc public func showInStart(_ start:CGFloat,end:CGFloat) {
        
        switch animationType {
        case .none:
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            lineLayer.strokeStart = start
            lineLayer.strokeEnd = end
            CATransaction.commit()
        case .default:
            lineLayer.strokeStart = start
            lineLayer.strokeEnd = end
        case .type0:
            var beginDu:CFTimeInterval = delegate?.ppfLineView(self, animationDurationForBegin: lineLayer) ?? 0.2
            var endDu:CFTimeInterval = delegate?.ppfLineView(self, animationDurationForEnd: lineLayer) ?? 0.3
            if start > lineLayer.strokeStart {
                (beginDu,endDu) = (endDu,beginDu)
            }
            
            let startAn = CABasicAnimation(keyPath: "strokeStart")
            startAn.fromValue = lineLayer.strokeStart
            startAn.toValue = start
            startAn.duration = beginDu
            startAn.isRemovedOnCompletion = false
            startAn.fillMode = .forwards
            
            let endAn = CABasicAnimation(keyPath:"strokeEnd")
            endAn.fromValue = lineLayer.strokeEnd
            endAn.toValue = end
            endAn.duration = endDu
            endAn.isRemovedOnCompletion = false
            endAn.fillMode = .forwards
            
            lineLayer.strokeStart = start
            lineLayer.strokeEnd = end
            
            lineLayer.add(startAn, forKey: nil)
            lineLayer.add(endAn, forKey: nil)
        default:
            fatalError()
        }
    }
}
