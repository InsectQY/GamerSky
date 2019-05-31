//
//  FilterView.swift
//  BookShopkeeper
//
//  Created by QY on 2018/1/17.
//  Copyright © 2018年 dingding. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    static let height: CGFloat = FilterCell.cellHeight * 6
    var selectIndex: ((Int,String) -> ())?
    
    // MARK: - lazyLoad
    private lazy var filter = [[Filter]]()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: bounds)
        tableView.register(cellType: FilterCell.self)
        tableView.dataSource = self
        tableView.rowHeight = FilterCell.cellHeight
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        loadFilterData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterView {
    
    // MARK: - 加载本地数据
    private func loadFilterData() {

        let data = try! Data(contentsOf: R.file.filterDataPlist()!)
        filter = try! PropertyListDecoder().decode([[Filter]].self, from: data)
        tableView.reloadData()
    }
    
//    // MARK: - 设置 CollectionView
//    private func setUpCollectionView() {
//
//        /// 默认选中第一个
//        collectionView.performBatchUpdates(nil) { [weak self] _ in
//
//            let cell = self?.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as! FilterKindCell
//            cell.filterBtnDidClick()
//        }
//    }
}

// MARK: - UITableViewDataSource
extension FilterView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterCell.self)
        cell.filter = filter[indexPath.row]
        return cell
    }
}
