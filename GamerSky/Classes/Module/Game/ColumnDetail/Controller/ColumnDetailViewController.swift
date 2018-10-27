//
//  ColumnDetailViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

enum ColumnDetailContainer {
    case gameSpecialSubList(BaseModel<[GameSpecialSubList]>)
    case gameSpecialDetail(BaseModel<[GameSpecialDetail]>)
}

class ColumnDetailViewController: BaseViewController {
    
    private var isHasSubList: Bool = false
    private var nodeID: Int = 0
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
        tableView.scrollIndicatorInsets = UIEdgeInsets.init(top: kTopH, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: - convenience
    convenience init(isHasSubList: Bool, nodeID: Int) {
        
        self.init()
        self.isHasSubList = isHasSubList
        self.nodeID = nodeID
    }
    
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
    }
    
    private func setUpRefresh() {
        
        tableView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            
            self.page = 1
            let symbol1 = GameApi.gameSpecialDetail(self.page, self.nodeID)
            .cache
            .request().mapObject(BaseModel<[GameSpecialDetail]>.self)
            .map({ColumnDetailContainer.gameSpecialDetail($0)})
            
            if self.isHasSubList {
                
                let symbol2 = GameApi.gameSpecialSubList(self.nodeID)
                .cache
                .request().mapObject(BaseModel<[GameSpecialSubList]>.self)
                .map({ColumnDetailContainer.gameSpecialSubList($0)})
                
                Observable.of(symbol1, symbol2)
                .concat()
                .subscribe(onNext: { response in

                    switch response {
                    case let .gameSpecialDetail(data):
                        
                        self.specialDetail = data.result
                        break
                    case let .gameSpecialSubList(data):
                        
                        self.specialSubList = data.result
                        // 清空之前分好的组
                        self.sectionSpecialDetail.removeAll()
                        // 遍历并按sublist的title分组
                        self.specialSubList.forEach({ subList in
                            
                            let result = self.specialDetail
                                .filter {subList.title == ($0.subgroup ?? "")}
                            self.sectionSpecialDetail.append(result)
                        })
                        self.tableView.reloadData()
                        self.tableView.qy_header.endRefreshing()
                        break
                    }
                }, onError: { _ in
                    self.tableView.qy_header.endRefreshing()
                })
                .disposed(by: self.rx.disposeBag)
            }else {
                
                symbol1.subscribe(onNext: { response in
                    
                    switch response {
                    case let .gameSpecialDetail(data):
                        
                        self.specialDetail = data.result
                        self.tableView.reloadData()
                        self.tableView.qy_header.endRefreshing()
                        break
                    case .gameSpecialSubList:
                        break
                    }
                }, onError: { _ in
                    self.tableView.qy_header.endRefreshing()
                })
                .disposed(by: self.rx.disposeBag)
                
                self.tableView.qy_footer.endRefreshingWithNoMoreData()
            }
        })
        
        tableView.qy_header.beginRefreshing()
        
        guard !isHasSubList else {return}

        tableView.qy_footer = QYRefreshFooter(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            
            self.page += 1
            self.tableView.qy_header.endRefreshing()
            
            GameApi.gameSpecialDetail(self.page, self.nodeID)
            .cache
            .request().mapObject(BaseModel<[GameSpecialDetail]>.self)
            .subscribe(onNext: {
                
                self.specialDetail += $0.result
                self.tableView.qy_footer.endRefreshing()
                self.tableView.reloadData()
            }, onError: { _ in
                self.tableView.qy_footer.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
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
