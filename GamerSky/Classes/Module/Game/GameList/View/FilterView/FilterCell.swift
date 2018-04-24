//
//  FilterCell.swift
//  BookShopkeeper
//
//  Created by InsectQY on 2018/4/24.
//Copyright © 2018年 dingding. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = 60
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    public var filter = [Filter]() {
        
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
    }
    
    // MARK: - 设置 CollectionView
    private func setUpCollectionView() {
        
        collectionView.register(cellType: FilterKindCell.self)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }
}

// MARK: - UICollectionViewDataSource
extension FilterCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FilterKindCell.self)
        cell.content = filter[indexPath.item].name
        //        cell.filterClick = {[weak self] in
        //
        //            self?.firstSelBtn.isSelected = false
        //            $0.isSelected = true
        //            self?.firstSelBtn = $0
        //            self?.selectIndex?(0, stateParam[indexPath.item])
        //        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FilterCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return filter[indexPath.item].size
    }
}
