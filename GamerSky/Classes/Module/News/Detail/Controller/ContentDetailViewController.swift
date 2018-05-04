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
    
    // MARK: - Lazyload
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
        webView.scrollView.qy_header = QYRefreshHeader { [weak self] in

            guard let `self` = self else {return}
            guard let URL = URL(string: "\(AppHostIP)/v1/ContentDetail/\(self.contentID)/1?fontSize=0&nullImageMode=1&tag=news&deviceid=\(deviceID)&platform=ios&nightMode=\(nightMode)&v=") else {return}
            self.webView.load(URLRequest(url: URL))
        }
        webView.scrollView.qy_header.beginRefreshing()
    }
}

// MARK: - WKUIDelegate
extension ContentDetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        webView.evaluateJavaScript("$('#gsTemplateContent_AD1').css('display', 'none');", completionHandler: nil)
        webView.evaluateJavaScript("$('#gsTemplateContent_AD2').css('display', 'none');", completionHandler: nil)
        webView.scrollView.qy_header.endRefreshing()
    }
    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//
//        print("\(navigationAction.request)")
//        decisionHandler(.allow)
//    }
}

// MARK: - 与 JS 交互方法
extension ContentDetailViewController {
    
    // MARK: - 无图模式
    private func setNullImageMode(_ isNull: Bool) {
        
        let jsString = isNull ? "gsSetNullImageMode(0);" : "gsSetNullImageMode(1);"
        webView.evaluateJavaScript(jsString, completionHandler: nil)
    }
    
    // MARK: - 设置字体大小
    private func setFontSize(_ size: FontSizeType) {
        webView.evaluateJavaScript("gsSetFontSize(\(size.rawValue));", completionHandler: nil)
    }
    
    // MARK: - 获取网页中所有图片
    private func getImages(info: ((_ images: [WebViewImage]) -> ())?) {
        
        webView.evaluateJavaScript("imageInfos;") { (result, error) in
            
            if let result = result {
                
                do {
                    
                    let images = try JSONDecoder().decode([WebViewImage].self, from: try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted))
                    info?(images)
                } catch {
                    print(error)
                }
            }
        }
    }
}
