//
//  NewsTableHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import FSPagerView

private let CycleCellID = "CycleCellID"

class NewsTableHeaderView: UIView, NibReusable {

    @IBOutlet private weak var pageContentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var channelListAry: [ChannelList]? {
        didSet {
            pagerView.reloadData()
        }
    }
    
    private lazy var pagerView: FSPagerView = {
        
        let pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight * 0.3 - 40))
        pagerView.automaticSlidingInterval = 8
        pagerView.isInfinite = true
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: CycleCellID)
        return pagerView
    }()

    override func awakeFromNib() {
       
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
        cell.imageView?.setImage(channelListAry?[index].thumbnailURLs?.first)
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
}
