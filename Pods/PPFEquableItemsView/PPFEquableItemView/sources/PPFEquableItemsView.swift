//
//  PPFEquableItemView.swift
//  PPFEquableItemView
//
//  Created by 潘鹏飞 on 2019/6/17.
//  Copyright © 2019 潘鹏飞. All rights reserved.
//

import UIKit

@objc public protocol PPFEquableItemsViewDataSource {
    func equableItemsNumberIn(eView:PPFEquableItemsView) -> Int
    func equableItems(eView:PPFEquableItemsView,viewAtIndex index:Int) -> UIView
}

/// 一个view分成相同的宽或高的等份
public class PPFEquableItemsView: UIView {
    
    @objc public enum Direction:Int {
        case horizontal
        case vertical
    }
    
    /// 子项之间的空隙
    public let itemsSpace:CGFloat
    /// 方向
    public let direction:Direction
    /// 数据源
    unowned public var dataSource:PPFEquableItemsViewDataSource
    
    public init(frame:CGRect,direction:Direction,dataSource:PPFEquableItemsViewDataSource,itemsSpace:CGFloat = 0){
        self.direction = direction
        self.dataSource = dataSource
        self.itemsSpace = itemsSpace
        super.init(frame: frame)
    }
    
    /// 要正常显示数据,必须先调用这个方法
    public func reloadDataSources() {
        initializeUIs()
        initializeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 初始化UIs
    private func initializeUIs() {
        subviews.forEach(){
            $0.removeFromSuperview()
        }
        for i in 0 ..< dataSource.equableItemsNumberIn(eView: self) {
            let v = dataSource.equableItems(eView: self, viewAtIndex: i)
            v.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(v)
        }
    }
    /// 初始始约束
    private func initializeConstraints(){
        subviews.forEach(){
            $0.removeConstraints($0.constraints)
        }
        
        for i in 0 ..< subviews.count {
            let v = subviews[i]
            switch direction {
            case .horizontal:
                if i == 0 {
                    v.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                }else{
                    v.leftAnchor.constraint(equalTo: subviews[i - 1].rightAnchor,constant: itemsSpace).isActive = true
                    v.widthAnchor.constraint(equalTo: subviews[i - 1].widthAnchor).isActive = true
                }
                if i == subviews.count - 1 {
                    v.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                }
                v.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                v.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            case .vertical:
                if i == 0 {
                    v.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                }else{
                    v.topAnchor.constraint(equalTo: subviews[i - 1].bottomAnchor,constant: itemsSpace).isActive = true
                    v.heightAnchor.constraint(equalTo: subviews[i - 1].heightAnchor).isActive = true
                }
                if i == subviews.count - 1 {
                    v.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                }
                v.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                v.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            }
        }
    }
}
