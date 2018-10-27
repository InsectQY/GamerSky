//
//  QYContentView.swift
//  QYPageView
//
//  Created by Insect on 2017/4/28.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class QYContentView: UIView {
    
    private let kContentCellID = "kContentCellID"
    
    /// 切换界面
    public var selIndex: Int = 0 {
        
        didSet {
            
            let indexPath = IndexPath(item: selIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    private let childVcs: [UIViewController]
        
    public lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    
    // MARK: 构造函数
    init(frame: CGRect, childVcs: [UIViewController]) {
        
        self.childVcs = childVcs
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("不能从xib中加载")
    }
}

// MARK:- 设置UI界面
extension QYContentView {
    
    private func setupUI() {
        
        // 1.将childVc添加到父控制器中
//        for vc in childVcs {
//            parentVc.addChildViewController(vc)
//        }
        
        // 2.初始化用于显示子控制器View的View（UIScrollView/UICollectionView）
        addSubview(collectionView)
    }
}

// MARK:- UICollectionViewDataSource
extension QYContentView: UICollectionViewDataSource {
    
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
