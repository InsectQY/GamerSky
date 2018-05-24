//
//  ColumnHeaderView.swift
//  GamerSky
//
//  Created by Insect on 2018/4/3.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import URLNavigator

class ColumnHeaderView: UIView, NibLoadable {
    
    static let headerHeight: CGFloat = 150
    
    // MARK: - IBOutlet
    @IBOutlet private weak var flowLayout: ColumnHeaderFlowLayout!
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
        
        ColumnApi.columnNodeList
        .cache
        .request(objectModel: BaseModel<[ColumnList]>.self)
        .subscribe(onNext: { [weak self] in
            
            guard let `self` = self else {return}
            self.columnLists = $0.result
            self.colletcionView.reloadData()
        }, onError: {
            print($0)
        })
        .disposed(by: rx.disposeBag)
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
        navigator
        .push(NavigationURL.get(.origin(columnLists[indexPath.item])))
    }
}
