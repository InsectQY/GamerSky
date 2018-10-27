//
//  NewsPageViewController.swift
//  GamerSky
//
//  Created by Insect on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import JXCategoryView

class NewsPageViewController: BaseViewController {

    private let kContentCellID = "kContentCellID"
    
    private var childVcs: [UIViewController] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: ScreenWidth, height: ScreenHeight)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame:view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private var allChannel = [Channel]() {
        didSet {
            
            categoryView.titles = allChannel.map({$0.nodeName})
            childVcs = allChannel.map({NewsViewController(nodeID: $0.nodeId)})
            categoryView.contentScrollView = collectionView
        }
    }
    
    private lazy var categoryView: JXCategoryTitleView = {
        
        let lineView = JXCategoryIndicatorLineView()
        lineView.indicatorLineWidth = 10
        lineView.lineStyle = .JD
        let categoryView = JXCategoryTitleView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - kNaviBarH, height: kNaviBarH))
        categoryView.indicators = [lineView]
        return categoryView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        setUpNavi()
        loadAllChannel()
    }
}

// MARK: - 加载频道数据
extension NewsPageViewController {
    
    private func loadAllChannel() {
        
        NewsApi.allChannel
        .cache
        .request()
        .mapObject(BaseModel<[Channel]>.self)
        .subscribe(onNext: { [weak self] in

            guard let `self` = self else {return}
            self.allChannel = $0.result
        }, onError: {
             print("失败----\($0)")
        })
        .disposed(by: rx.disposeBag)
    }
}

extension NewsPageViewController {
    
    private func setUpUI() {
        view.addSubview(collectionView)
    }
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        navigationItem.titleView = categoryView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "common_Icon_Search_16x16"), style: .plain, target: self, action: #selector(didClickSearch))
        navigationController?.navigationBar.isTranslucent = false
    }
    
    // MARK: - 点击了搜索
    @objc private func didClickSearch() {
        
    }
}

// MARK:- UICollectionViewDataSource
extension NewsPageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let vc = childVcs[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
}
