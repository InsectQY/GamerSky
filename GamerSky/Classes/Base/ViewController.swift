//
//  BaseViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftTheme
import DZNEmptyDataSet
import JXCategoryView

class ViewController: UIViewController {

    /// 是否正在加载
    let isLoading = BehaviorRelay(value: false)
    /// 数据源 nil 时点击了 Button
    let emptyDataSetButtonTap = PublishSubject<Void>()
    /// 数据源 nil 时显示的标题
    var emptyDataSetTitle: String = ""
    /// 数据源 nil 时显示的描述
    var emptyDataSetDescription: String = ""
    /// 数据源 nil 时显示的图片
    var emptyDataSetImage = UIImage(named: "")
    /// 数据源 nil 时是否可用滚动
    var emptyDataSetShouldAllowScroll: Bool = true

    /// 默认背景颜色
    private var defaultBackgroundColor = "colors.backgroundColor"
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        initTheme()
        registerNotification()
        makeUI()
        bindViewModel()
    }
    
    // MARK: - deinit
    deinit {
        print("\(type(of: self)): Deinited")
    }
    
    // MARK: - didReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(type(of: self)): Received Memory Warning")
    }
    
    func makeUI() {
        view.backgroundColor = .white
    }
    
    func bindViewModel() {
        
    }
    
    /// 重复点击 TabBar
    func repeatClickTabBar() {}
}

// MARK: - BindErrorStateable
extension ViewController: BindErrorStateable {

    func bindErrorToShowToast(_ error: ErrorTracker) {
        error
        .drive(rx.showError)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - BindLoadState
extension ViewController: BindLoadStateable {

    func bindLoading(with loading: ActivityIndicator) {
        loading
        .drive(isLoading)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - JXCategoryListContentViewDelegate
extension ViewController: JXCategoryListContentViewDelegate {

    func listView() -> UIView! {
        return view
    }
}

// MARK: - DZNEmptyDataSetSource
extension ViewController: DZNEmptyDataSetSource {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetTitle)
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString(string: emptyDataSetDescription)
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return emptyDataSetImage
    }

    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }
}

// MARK: - DZNEmptyDataSetDelegate
extension ViewController: DZNEmptyDataSetDelegate {

    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading.value
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        emptyDataSetButtonTap.onNext(())
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return emptyDataSetShouldAllowScroll
    }
}

extension ViewController {
    
    /// 主题背景颜色(传路径)
    @IBInspectable var qy_themeBackgroundColor: String? {
        
        set {
            
            guard let newValue = newValue else {return}
            defaultBackgroundColor = newValue
            initTheme()
        }
        
        get {
            return defaultBackgroundColor
        }
    }
}

extension ViewController {
    
    // MARK: - 主题设置
    private func initTheme() {
        
        view.theme_backgroundColor = ThemeColorPicker(keyPath: defaultBackgroundColor)
    }
}

// MARK: - 通知
extension ViewController {
    
    // MARK: - 注册通知
    private func registerNotification() {
    
    }
    
    // MARK: - tabBar重复点击
    func tabBarRepeatClick() {
        
        guard view.isShowingOnKeyWindow() else {return}
        repeatClickTabBar()
    }
}

// MARK: - Reactive-extension
extension Reactive where Base: ViewController {

    var showError: Binder<Error> {

        return Binder(base) { vc, error in
            
        }
    }
}
