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

    var contentID = 0
    
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
}

extension ContentDetailViewController {
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        automaticallyAdjustsScrollViewInsets = false
        //        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }

    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        webView.scrollView.mj_header = QYRefreshHeader(refreshingTarget: self, refreshingAction: #selector(loadContentDetail))
        webView.scrollView.mj_header.beginRefreshing()
    }
    
    // MARK: - 加载新闻详情
    @objc private func loadContentDetail() {
        
        guard let URL = URL(string: "\(HostIP)/v1/ContentDetail/\(contentID)/1?fontSize=0&nullImageMode=1&tag=news&deviceid=\(deviceID)&platform=ios&nightMode=0&v=") else {return}
        
        webView.load(URLRequest(url: URL))
    }
}

// MARK: - WKUIDelegate
extension ContentDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.scrollView.mj_header.endRefreshing()
    }
}
