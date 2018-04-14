//
//  GameColumnViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameColumnViewController: BaseViewController {
    
    /// cell 之间间距
    private let kItemMargin: CGFloat = 15
    /// 左右间距
    private let kEdge: CGFloat = 15
    /// 每行最大列数
    private let kMaxCol: CGFloat = 1
    /// cell 宽度
    private var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
    }
    /// cell 高度
    private let kItemH: CGFloat = ScreenHeight * 0.22
    
    // MARK: - LazyLoad
    /// 特色专题
    private lazy var gameColumn = [GameSpecialList]()
    
    private lazy var collectionView: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = kEdge
        flowLayout.minimumLineSpacing = kItemMargin
        flowLayout.sectionInset = UIEdgeInsetsMake(kItemMargin, 0, 0, 0)
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView.contentInset = UIEdgeInsetsMake(kTopH, 0, kItemMargin, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: GameHomeColumnCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpUI()
        setUpRefresh()
    }
}

// MARK: - 设置 UI 界面
extension GameColumnViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = RGB(240, g: 240, b: 240)
        view.addSubview(collectionView)
    }
    
    private func setUpNavi() {
        
        title = "特色专题"
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setUpRefresh() {
        
        collectionView.mj_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            
            // 特色专题
            ApiProvider.request(.gameSpecialList(1), objectModel: BaseModel<[GameSpecialList]>.self, success: {
                
                strongSelf.gameColumn = $0.result
                strongSelf.collectionView.reloadData()
                strongSelf.collectionView.mj_header.endRefreshing()
            }) { _ in
                strongSelf.collectionView.mj_header.endRefreshing()
            }
        })
        
        collectionView.mj_header.beginRefreshing()
    }
}

// MARK: - UICollectionViewDataSource
extension GameColumnViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameColumn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnCell.self)
        cell.isLoadBigImage = true
        cell.column = gameColumn[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameColumnViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
