//
//  ColumnHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/3.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnHeaderView: UIView, NibLoadable {
    
    static let headerHeight: CGFloat = 125
    
    // MARK: - IBOutlet
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var colletcionView: UICollectionView! {
        didSet {
            colletcionView.register(cellType: ColumnListCell.self)
        }
    }
    
    // MARK: - Lazyload
    private lazy var columnLists = [ColumnList]()
    
    // MARK: - awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()

        loadColumnList()
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
        
        let vc = OriginalViewController()
        vc.columnList = columnLists[indexPath.item]
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
}