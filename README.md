# PPFSelectViewDemo

## 引用

```
pod pod 'PPFSelectView', '~> 0.0.1'
```

## 怎么用

```
let l = PPFSelectView(color: UIColor.red, itemWidthRate: 0.2,itemHeight: 2)
l.center = view.center
l.frame.size = CGSize(width: 200, height: 40)
l.dataSource = self
l.delegate = self
view.addSubview(l)
l.reloadDataSource()
```

#### PPFSelectView_dataSource
```
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
```

#### PPFSelectView_delegate
```
extension ViewController:PPFSelectView_delegate {
    func ppfSelectView(_ sView: PPFSelectView, didSelectAtIndex index: Int) {
        print("已选中:\(index)")
    }
}
```
