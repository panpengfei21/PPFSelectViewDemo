//
//  ViewController.swift
//  PPFSelectViewDemo
//
//  Created by 潘鹏飞 on 2019/6/25.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    weak var lView:PPFLineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = {
            let l = PPFSelectView(color: UIColor.red, itemWidthRate: 0.2,itemHeight: 2)
            l.frame.size = CGSize(width: 200, height: 40)
            l.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
            l.dataSource = self
            l.delegate = self
            l.setAnimationType(.type0)
            view.addSubview(l)
            l.reloadDataSource()
            return
        }()
    }
}

// MARK: - PPFSelectView_dataSource
extension ViewController:PPFSelectView_dataSource {
    func ppfSelectViewHasNumberOfItems(_ sView: PPFSelectView) -> Int {
        return 3
    }
    
    func ppfSelectView(_ sView: PPFSelectView, viewAtIndex index: Int) -> UIView {
        let l = UILabel()
        l.textAlignment = .center
        l.backgroundColor = UIColor(white: CGFloat(arc4random_uniform(50)) / 100.0 + 0.3, alpha: 1.0)
        l.text = "\(index)"
        l.textColor = UIColor.black
        return l
    }
}
extension ViewController:PPFSelectView_delegate {
    func ppfSelectView(_ sView: PPFSelectView, didSelectAtIndex index: Int) {
        print("已选中:\(index)")
    }
    func ppfSelectView(_ sView: PPFSelectView, animationDurationForBegin layer: CAShapeLayer) -> CFTimeInterval {
        return 0.3
    }
    func ppfSelectView(_ sView: PPFSelectView, animationDurationForEnd layer: CAShapeLayer) -> CFTimeInterval {
        return 0.2
    }
}

