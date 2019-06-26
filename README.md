# PPFSelectViewDemo

## 效果
![PPFSelectView](https://upload-images.jianshu.io/upload_images/2261768-9010009d197c6f8f.gif?imageMogr2/auto-orient/strip)


## 引用

```
pod pod 'PPFSelectView', '~> 0.0.1'
```

## 怎么用
```
let l = PPFSelectView(color: UIColor.red, itemWidthRate: 0.2,itemHeight: 2)
l.frame.size = CGSize(width: 200, height: 40)
l.dataSource = self
l.delegate = self
view.addSubview(l)
l.reloadDataSource()//刷新!一定要调用一下这个
```

#### PPFSelectView_dataSource
```
// MARK: - PPFSelectView_dataSource
extension ViewController:PPFSelectView_dataSource {
    /// 有几个可选择对象
    func ppfSelectViewHasNumberOfItems(_ sView: PPFSelectView) -> Int {
        return 3
    }
    
    /// 当前索引要显示的View
    func ppfSelectView(_ sView: PPFSelectView, viewAtIndex index: Int) -> UIView {
        let l = UILabel()
        l.textAlignment = .center
        l.text = "\(index)"
        l.textColor = UIColor.black
        return l
    }
}
```

#### PPFSelectView_delegate
```
/// 点击的回调
extension ViewController:PPFSelectView_delegate {
    func ppfSelectView(_ sView: PPFSelectView, didSelectAtIndex index: Int) {
        print("已选中:\(index)")
    }
}
```
