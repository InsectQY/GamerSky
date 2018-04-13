//
//  NewsDetailViewController.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import WebKit

class ContentDetailViewController: BaseViewController {

    public var contentID = 0
    
    private lazy var webView: WKWebView = {
        
        let webView = WKWebView(frame: UIScreen.main.bounds)
        webView.scrollView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        webView.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        setUpNavi()
        setUpRefresh()
    }
    
    // MARK: - convenience
    convenience init(ID: Int) {
        
        self.init()
        webView.backgroundColor = .clear
        contentID = ID
    }
}

extension ContentDetailViewController {
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        if #available(iOS 11.0, *) {
            webView.scrollView.contentInsetAdjustmentBehavior = .never
        }
        automaticallyAdjustsScrollViewInsets = false
        //        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }

    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        let nightMode = QYUserDefaults.getUserPreference()?.currentTheme == .night ? 1 : 0
        webView.scrollView.mj_header = QYRefreshHeader { [weak self] in

            guard let strongSelf = self else {return}
            guard let URL = URL(string: "\(AppHostIP)/v1/ContentDetail/\(strongSelf.contentID)/1?fontSize=0&nullImageMode=1&tag=news&deviceid=\(deviceID)&platform=ios&nightMode=\(nightMode)&v=") else {return}
            strongSelf.webView.load(URLRequest(url: URL))
        }
        webView.scrollView.mj_header.beginRefreshing()
    }
}

// MARK: - WKUIDelegate
extension ContentDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.scrollView.mj_header.endRefreshing()
    }
}
