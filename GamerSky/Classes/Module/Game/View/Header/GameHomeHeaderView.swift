//
//  GameHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

/// cell 之间间距
private let kItemMargin: CGFloat = 25
/// 左右间距
private let kEdge: CGFloat = 10
/// 每行最大列数
private let kMaxCol: CGFloat = 5
/// cell 宽度
private let kItemW = (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol

class GameHomeHeaderView: BaseView {

    static let headerHeight: CGFloat = ScreenHeight * 0.16
    
    // MARK: - Lazyload
    private lazy var headerData = [GameHomeHeader]()
    
    private lazy var collectionView: BaseCollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: height)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        flowLayout.minimumLineSpacing = kItemMargin
        flowLayout.minimumInteritemSpacing = kItemMargin
        let collectionView = BaseCollectionView(frame: bounds, collectionViewLayout: flowLayout)
        collectionView.register(cellType: GameHomeHeaderCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        loadHeaderData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 加载本地数据
extension GameHomeHeaderView {
    
    private func loadHeaderData() {
        
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameHomeHeaderData.plist", withExtension: nil)!)
        headerData = try! PropertyListDecoder().decode([GameHomeHeader].self, from: data)
    }
}

// MARK: - UICollectionViewDataSource
extension GameHomeHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeHeaderCell.self)
        cell.header = headerData[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameHomeHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
