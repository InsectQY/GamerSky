//
//  NewsTableHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import FSPagerView
import SwiftTheme
import URLNavigator

class NewsTableHeaderView: View, NibReusable {

    private let CycleCellID = "CycleCellID"
    
    static let height: CGFloat = Configs.Dimensions.screenHeight * 0.31
    
    // MARK: - IBOutlet
    @IBOutlet private weak var pagerView: FSPagerView! {
        didSet {
            pagerView.isInfinite = true
            pagerView.dataSource = self
            pagerView.delegate = self
            pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: CycleCellID)
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - public
    fileprivate var channelListAry: [ChannelList]? {
        didSet {
            pagerView.reloadData()
        }
    }

    // MARK: - awakeFromNib
    override func awakeFromNib() {
       theme_backgroundColor = ThemeColorPicker(keyPath: "colors.backgroundColor")
    }    
}

// MARK: - FSPagerViewDataSource
extension NewsTableHeaderView: FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return channelListAry?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: CycleCellID, at: index)
        cell.imageView?.qy_setImage(channelListAry?[index].thumbnailURLs?.first)
        return cell
    }
}

// MARK: - FSPagerViewDelegate
extension NewsTableHeaderView: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int) {
        
        let id = channelListAry?[index].contentId ?? 0
        navigator.push("\(NavigationURL.contentDetail)/\(id)")
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        titleLabel.text = channelListAry?[index].title
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
}

extension Reactive where Base: NewsTableHeaderView {
    
    var bannerData: Binder<[ChannelList]?> {
        
        return Binder(base) { headerView, result in
            headerView.channelListAry = result
        }
    }
}
