//
//  NewsTableHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import FSPagerView
import SwiftTheme

class NewsTableHeaderView: BaseView, NibReusable {

    private let CycleCellID = "CycleCellID"
    
    // MARK: - IBOutlet
    @IBOutlet private weak var pageContentView: BaseView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - public
    public var channelListAry: [ChannelList]? {
        didSet {
            pagerView.reloadData()
        }
    }
    
    // MARK: - Lazylaod
    private lazy var pagerView: FSPagerView = {
        
        let pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.3 - 40))
        pagerView.automaticSlidingInterval = 8
        pagerView.isInfinite = true
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: CycleCellID)
        return pagerView
    }()

    // MARK: - awakeFromNib
    override func awakeFromNib() {
       theme_backgroundColor = ThemeColorPicker(keyPath: "colors.backgroundColor")
        pageContentView.addSubview(pagerView)
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
        let vc = ContentDetailViewController()
        vc.contentID = id
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        titleLabel.text = channelListAry?[index].title
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
    }
}
