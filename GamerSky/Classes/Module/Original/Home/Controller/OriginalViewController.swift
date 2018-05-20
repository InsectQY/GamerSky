//
//  OriginalViewController.swift
//  GamerSky
//
//  Created by engic on 2018/4/2.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit
import SwiftNotificationCenter
import SwiftTheme

class OriginalViewController: BaseViewController {

    /// 其他栏目
    public var columnList: ColumnList?
    
    private var page = 1
    
    /// 其他栏目的数据
    private lazy var columnListAry = [ColumnElement]()
    /// 原创首页的数据
    private lazy var columnAry = [[ColumnElement]]()
    
    // MARK: - Lazyload
    private lazy var titleView: ColumnNavTitleView = {
        
        let titleView = ColumnNavTitleView.loadFromNib()
        titleView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: kNaviBarH)
        return titleView
    }()
    
    private lazy var descHeaderView: ColumnDescHeaderView = {
        
        let descHeaderView = ColumnDescHeaderView.loadFromNib()
        descHeaderView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ColumnDescHeaderView.headerHeight)
        return descHeaderView
    }()
    
    private lazy var headerView: ColumnHeaderView = {
        
        let headerView = ColumnHeaderView.loadFromNib()
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ColumnHeaderView.headerHeight)
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: ColumnElementCell.self)
        tableView.register(headerFooterViewType: ColumnSectionHeader.self)
        tableView.rowHeight = ColumnElementCell.cellHeight
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpUI()
    }
    
    override func repeatClickTabBar() {
        tableView.qy_header.beginRefreshing()
    }
}

extension OriginalViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = RGB(245, g: 245, b: 245)
        qy_themeBackgroundColor = "colors.whiteSmoke"
        view.addSubview(tableView)
        setUpHeaderView()
        setUpRefresh()
    }
    
    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        let columnID = columnList == nil ? 47 : columnList!.Id
        
        tableView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            self.page = 1
            self.tableView.qy_footer.endRefreshing()
            
            ColumnApi.columnContent(self.page, columnID)
            .cache
            .request(objectModel: BaseModel<ColumnContent>.self)
            .subscribe(onNext: {
                
                if self.columnList == nil {
                    self.columnAry = [$0.result.childElements]
                }else {
                    self.columnListAry = $0.result.childElements
                }
                
                self.tableView.reloadData()
                self.tableView.qy_header.endRefreshing()
            }, onError: { _ in
                self.tableView.qy_header.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.qy_footer = QYRefreshFooter(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            self.page += 1
            self.tableView.qy_header.endRefreshing()
            
            ColumnApi.columnContent(self.page, columnID)
            .cache
            .request(objectModel: BaseModel<ColumnContent>.self)
            .subscribe(onNext: {
                
                if self.columnList == nil {
                    self.columnAry += [$0.result.childElements]
                }else {
                    self.columnListAry += $0.result.childElements
                }
                
                self.tableView.reloadData()
                self.tableView.qy_footer.endRefreshing()
            }, onError: { _ in
                self.tableView.qy_footer.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.qy_header.beginRefreshing()
    }
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        automaticallyAdjustsScrollViewInsets = false
        if let columnList = columnList {
            
            navigationItem.titleView = titleView
            titleView.column = columnList
        }else {
           
            let leftItem = BaseLabel(frame: CGRect(x: 10, y: 0, width: 200, height: kNaviBarH))
            leftItem.font = PFM18Font
            leftItem.text = "游民原创"
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftItem)
        }
    }
    
    // MARK: - 设置HeaderView
    private func setUpHeaderView() {
        
        if let columnList = columnList {
            
            tableView.tableHeaderView = descHeaderView
            descHeaderView.desc = columnList.description
        }else {
            tableView.tableHeaderView = headerView
        }
    }
}

// MARK: - UITableViewDataSource
extension OriginalViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return columnList == nil ? columnAry.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return columnList == nil ? columnAry[section].count : columnListAry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let element = columnList == nil ? columnAry[indexPath.section][indexPath.row] : columnListAry[indexPath.row]
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ColumnElementCell.self)
        cell.columnElement = element
        cell.row = indexPath.row
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OriginalViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let id = columnList == nil ? columnAry[indexPath.section][indexPath.row].Id : columnListAry[indexPath.row].Id
        let vc = ContentDetailViewController(ID: id)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(ColumnSectionHeader.self)
        return columnList == nil ? header : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ColumnSectionHeader.sectionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
