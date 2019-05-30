//
//  OriginalViewController.swift
//  GamerSky
//
//  Created by QY on 2018/4/2.
//  Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import SwiftTheme
import URLNavigator

class OriginalViewController: ViewController<ViewModel> {

    /// 其他栏目
    private var columnList: ColumnList?
    
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
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - convenience
    convenience init(columnList: ColumnList) {
        self.init()
        self.columnList = columnList
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavi()
    }
    
    override func repeatClickTabBar() {
        tableView.refreshHeader?.beginRefreshing()
    }
    
    override func makeUI() {
        
        super.makeUI()
        view.backgroundColor = RGB(245, g: 245, b: 245)
        qy_themeBackgroundColor = "colors.whiteSmoke"
        view.addSubview(tableView)
        setUpHeaderView()
        setUpRefresh()
    }
}

extension OriginalViewController {
    
    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        let columnID = columnList == nil ? 47 : columnList!.Id

        tableView.refreshHeader = RefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            self.page = 1
            self.tableView.refreshFooter?.endRefreshing()
            
            ColumnApi.columnContent(self.page, columnID)
            .request()
            .mapObject(ColumnContent.self)
            .subscribe(onSuccess: {
                
                if self.columnList == nil {
                    self.columnAry = [$0.childElements]
                }else {
                    self.columnListAry = $0.childElements
                }
                
                self.tableView.reloadData()
                self.tableView.refreshHeader?.endRefreshing()
            }, onError: { _ in
                self.tableView.refreshHeader?.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.refreshFooter = RefreshFooter(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            self.page += 1
            self.tableView.refreshHeader?.endRefreshing()
            
            ColumnApi.columnContent(self.page, columnID)
            .request()
            .mapObject(ColumnContent.self)
            .subscribe(onSuccess: {
                
                if self.columnList == nil {
                    self.columnAry += [$0.childElements]
                }else {
                    self.columnListAry += $0.childElements
                }
                
                self.tableView.reloadData()
                self.tableView.refreshFooter?.endRefreshing()
            }, onError: { _ in
                self.tableView.refreshFooter?.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        tableView.refreshHeader?.beginRefreshing()
    }
    
    // MARK: - 设置导航栏
    private func setUpNavi() {
        
        if let columnList = columnList {
            
            navigationItem.titleView = titleView
            titleView.column = columnList
        }else {
           
            let leftItem = Label(frame: CGRect(x: 10, y: 0, width: 200, height: kNaviBarH))
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
        navigator.push(NavigationURL.contentDetail(id).path)
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
