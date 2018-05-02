//
//  FilterCell.swift
//  BookShopkeeper
//
//  Created by InsectQY on 2018/4/24.
//Copyright © 2018年 dingding. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell, NibReusable {

    static let cellHeight: CGFloat = 40
    
    /// 默认的筛选内容
    private var defaultFilter: Filter!
    /// 当前选中的筛选内容
    private var selFilter: Filter!
    
    // MARK: - IBOutlet
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var filterBtn: FilterBtn!
    
    public var filter = [Filter]() {
        
        didSet {
            
            defaultFilter = filter[0]
            filterBtn.setTitle(filter.first?.name, for: .normal)
            filter.removeFirst()
            collectionView.reloadData()
        }
    }
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        filterBtnDidClick(filterBtn)
        setUpCollectionView()
    }
}

extension FilterCell {
    
    // MARK: - 设置 CollectionView
    private func setUpCollectionView() {
        
        collectionView.register(cellType: FilterKindCell.self)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
    }
    
    // MARK: - 默认筛选按钮点击事件
    @IBAction private func filterBtnDidClick(_ sender: UIButton) {
        
        selFilter = defaultFilter
        filterBtn.isSel = true
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension FilterCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FilterKindCell.self)
        cell.filter = filter[indexPath.item]
        // 判断当前是否在选中状态,避免重用
        cell.isSel = filter[indexPath.item].name == selFilter?.name
        
        // 点击事件
        cell.filterClick = {[weak self] in
            
            self?.filterBtn.isSel = false
            self?.selFilter = $0
            self?.collectionView.reloadData()
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FilterCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: filter[indexPath.item].size.width, height: FilterCell.cellHeight)
    }
}
