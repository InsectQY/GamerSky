//
//  ColumnDetailViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class ColumnDetailViewController: BaseViewController {
    
    public var isHasSubList: Bool = false
    public var nodeID: Int = 0
    /// 分页的页码
    private var page: Int = 0
    /// 列表(根据列表分出每一组)
    public lazy var specialSubList = [GameSpecialSubList]()
    /// 详情
    public lazy var specialDetail = [GameSpecialDetail]()
    /// 分组的详情
    public lazy var sectionSpecialDetail = [[GameSpecialDetail]]()
    
    // MARK: - LazyLoad
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        tableView.register(cellType: GameColumnDetailCell.self)
        tableView.register(headerFooterViewType: GameColumnDetailSectionHeader.self)
        tableView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpUI()
        setUpRefresh()
    }
}

// MARK: - 设置 UI 界面
extension ColumnDetailViewController {
    
    private func setUpUI() {
        
        view.addSubview(tableView)
    }
    
    private func setUpNavi() {
        
        title = "特色专题"
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setUpRefresh() {
        
        tableView.mj_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            let group = DispatchGroup()
            
            if strongSelf.isHasSubList {
                
                group.enter()
                ApiProvider.request(.gameSpecialSubList(strongSelf.nodeID), objectModel: BaseModel<[GameSpecialSubList]>.self, success: {

                    strongSelf.specialSubList = $0.result
                    group.leave()
                }, failure: { _ in
                    strongSelf.tableView.mj_header.endRefreshing()
                })
            }else {
                strongSelf.tableView.mj_footer.endRefreshing()
            }
            
            group.enter()
            strongSelf.page = 1
            ApiProvider.request(.gameSpecialDetail(strongSelf.page, strongSelf.nodeID), objectModel: BaseModel<[GameSpecialDetail]>.self, success: {
                
                strongSelf.specialDetail = $0.result
                group.leave()
            }, failure: { _ in
                strongSelf.tableView.mj_header.endRefreshing()
            })
            
            group.notify(queue: DispatchQueue.main, execute: {
                
                // 开始分组
                if strongSelf.isHasSubList {
                    
                    // 清空之前分好的组
                    strongSelf.sectionSpecialDetail.removeAll()
                    // 遍历并按sublist的title分组
                    strongSelf.specialSubList.forEach({ subList in
                        
                        let result = strongSelf.specialDetail.filter {subList.title == ($0.subgroup ?? "")}
                        strongSelf.sectionSpecialDetail.append(result)
                    })
                }
                strongSelf.tableView.reloadData()
                strongSelf.tableView.mj_header.endRefreshing()
            })
        })
        
        if !isHasSubList {
            
            tableView.mj_header.endRefreshing()
            tableView.mj_footer = QYRefreshFooter(refreshingBlock: { [weak self] in
                
                guard let strongSelf = self else {return}
                
                strongSelf.page += 1
                ApiProvider.request(.gameSpecialDetail(strongSelf.page, strongSelf.nodeID), objectModel: BaseModel<[GameSpecialDetail]>.self, success: {
                    
                    strongSelf.specialDetail += $0.result
                    strongSelf.tableView.mj_footer.endRefreshing()
                    strongSelf.tableView.reloadData()
                }, failure: { _ in
                    strongSelf.tableView.mj_footer.endRefreshing()
                })
            })
        }
        
        tableView.mj_header.beginRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension ColumnDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isHasSubList ? sectionSpecialDetail.count : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isHasSubList ? sectionSpecialDetail[section].count : specialDetail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: GameColumnDetailCell.self)
        
        let specitial = isHasSubList ? sectionSpecialDetail[indexPath.section][indexPath.row] : specialDetail[indexPath.row]
        cell.tag = indexPath.row
        cell.isHasSubList = isHasSubList
        cell.specitial = specitial
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ColumnDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard isHasSubList else {return nil}
        
        let header = tableView.dequeueReusableHeaderFooterView(GameColumnDetailSectionHeader.self)
        header.title = specialSubList[section].title
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isHasSubList ? GameColumnDetailSectionHeader.sectionHeight : CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return isHasSubList ? 15 : CGFloat.leastNormalMagnitude
    }
}
