//
//  GameHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/9.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameHomeHeaderView: BaseView {

    static let height: CGFloat = ScreenHeight * 0.16
    
    // MARK: - Lazyload
    private lazy var headerData = [GameHomeHeader]()
    
    private lazy var collectionView: BaseCollectionView = {
        
        let collectionView = BaseCollectionView(frame: bounds, collectionViewLayout: GameHomeHeaderFlowLayout())
        collectionView.register(cellType: GameHomeHeaderCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
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
        
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "GameHomeHeaderData", withExtension: "plist")!)
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
        
        let vcs = [GameColumnViewController(),GameRankingPageViewController(),GameSellListPageViewController(),GameCommentPageViewController(),GameListViewController()]
        let vc = vcs[indexPath.item]
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
}
