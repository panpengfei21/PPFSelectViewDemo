//
//  PPFSelectView.swift
//  PPFSelectViewDemo
//
//  Created by 潘鹏飞 on 2019/6/25.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit
import PPFEquableItemsView

@objc public protocol PPFSelectView_dataSource {
    func ppfSelectViewHasNumberOfItems(_ sView:PPFSelectView) -> Int
    func ppfSelectView(_ sView:PPFSelectView,viewAtIndex index:Int) -> UIView
}

@objc public protocol PPFSelectView_delegate {
    func ppfSelectView(_ sView:PPFSelectView,didSelectAtIndex index:Int)
}

/// 多项选择的view,下面有下滑线,选择哪项,滑到哪里
open class PPFSelectView: UIView {

    weak var showViews:PPFEquableItemsView!
    weak var buttomShowViews:PPFEquableItemsView!
    weak var bottomLineV:PPFLineView!
    
    /// 显示的颜色
    let color:UIColor
    /// 下划线显示的宽度的比例,0.0到1.0之间,这个公式:(下划线宽度 / PPFSelectView宽度) * 100%
    let itemWidthRate:CGFloat
    /// 下划线显示的高度
    let itemHeight:CGFloat
    
    public var dataSource:PPFSelectView_dataSource?
    public var delegate:PPFSelectView_delegate?
    
    public init(color:UIColor,itemWidthRate:CGFloat,itemHeight:CGFloat = 1,frame: CGRect = CGRect.zero) {
        self.color = color
        self.itemWidthRate = itemWidthRate
        self.itemHeight = itemHeight
        super.init(frame: frame)
        initializeUIs()
        initializeContraints()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        itemWidthRate = 0.2
        itemHeight = 2
        color = UIColor.red
        super.init(coder: aDecoder)
        initializeUIs()
        initializeContraints()
    }
    
    private func initializeUIs() {
        showViews = {
            let v = PPFEquableItemsView(frame: CGRect.zero, direction: .horizontal, dataSource: self)
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = UIColor.clear
            addSubview(v)
            return v
        }()
        bottomLineV = {
            let v = PPFLineView(color: color)
            v.translatesAutoresizingMaskIntoConstraints = false
            addSubview(v)
            return v
        }()
        buttomShowViews = {
            let v = PPFEquableItemsView(frame: CGRect.zero, direction: .horizontal, dataSource: self)
            v.translatesAutoresizingMaskIntoConstraints = false
            v.backgroundColor = UIColor.clear
            addSubview(v)
            return v
        }()

    }
    private func initializeContraints() {
        showViews.topAnchor.constraint(equalTo: topAnchor).isActive = true
        showViews.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        showViews.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        showViews.bottomAnchor.constraint(equalTo: bottomLineV.topAnchor).isActive  = true

        buttomShowViews.topAnchor.constraint(equalTo: topAnchor).isActive = true
        buttomShowViews.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        buttomShowViews.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        buttomShowViews.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  = true
        
        bottomLineV.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bottomLineV.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        bottomLineV.bottomAnchor.constraint(equalTo: bottomAnchor).isActive  = true
        bottomLineV.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
    }
    
    @objc func tapOnButton( _ button:UIButton) {
        if let index = buttomShowViews.subviews.firstIndex(of: button) {
            delegate?.ppfSelectView(self, didSelectAtIndex: index)
            selectItem(at: index)
        }
    }
}

// MARK: - public
extension PPFSelectView {
    public func reloadDataSource(index:Int = 0) {
        showViews.reloadDataSources()
        buttomShowViews.reloadDataSources()
        selectItem(at: index)
    }
    @discardableResult
    public func selectItem(at index:Int) -> Bool{
        guard index >= 0 && index < dataSource?.ppfSelectViewHasNumberOfItems(self) ?? 0 else{
            return false
        }
        
        guard let amounts = dataSource?.ppfSelectViewHasNumberOfItems(self),amounts > 0 else{
            return false
        }
        let halfItem = 1.0 / CGFloat(amounts * 2)
        let center = CGFloat((index * 2) + 1) * halfItem
        
        let start = center - (itemWidthRate / 2)
        let end   = center + (itemWidthRate / 2)
        
        bottomLineV.showInStart(start, end: end)
        return true
    }
}

// MARK: - PPFEquableItemsViewDataSource
extension PPFSelectView:PPFEquableItemsViewDataSource {
    public func equableItemsNumberIn(eView: PPFEquableItemsView) -> Int {
        return dataSource?.ppfSelectViewHasNumberOfItems(self) ?? 0
    }
    
    public func equableItems(eView: PPFEquableItemsView, viewAtIndex index: Int) -> UIView {
        switch eView {
        case showViews:
            return dataSource?.ppfSelectView(self, viewAtIndex: index) ?? UIView()
        case buttomShowViews:
            let b = UIButton(type: .custom)
            b.addTarget(self, action: #selector(PPFSelectView.tapOnButton(_:)), for: .touchUpInside)
            return b
        default:
            fatalError()
        }
    }
}
