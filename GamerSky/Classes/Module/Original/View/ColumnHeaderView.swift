//
//  ColumnHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/3.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

/// cell 之间间距
private let kItemMargin: CGFloat = 15
/// 左右间距
private let kEdge: CGFloat = 5
/// 每行最大列数
private let kMaxCol: CGFloat = 4
/// cell 宽度
private let kColumnListCellW = (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kItemMargin)) / kMaxCol
/// cell 高度
private let kItemH: CGFloat = 100

class ColumnHeaderView: UIView, NibLoadable {
    
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var colletcionView: UICollectionView!
    
    private lazy var columnLists = [ColumnList]()
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpCollectionView()
        loadColumnList()
    }
    
    // MARK: - setUpCollectionView
    private func setUpCollectionView() {
        
        flowLayout.itemSize = CGSize(width: kColumnListCellW, height: kItemH)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = kItemMargin
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        colletcionView.register(cellType: ColumnListCell.self)
    }
    
    // MARK: - 加载栏目数据
    private func loadColumnList() {
        
        ApiProvider.request(.columnNodeList, objectModel: BaseModel<[ColumnList]>.self, success: {
            
            self.columnLists = $0.result
            self.colletcionView.reloadData()
        }, failure: {
            print($0)
        })
    }
}

// MARK: - UICollectionViewDataSource
extension ColumnHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columnLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = colletcionView.dequeueReusableCell(for: indexPath, cellType: ColumnListCell.self)
        cell.column = columnLists[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension ColumnHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
