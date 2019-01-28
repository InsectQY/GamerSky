//
//  GameColumnViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameColumnViewController: ViewController {
    
    // MARK: - LazyLoad
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: GameColumnFlowLayout())
        collectionView.register(cellType: GameHomeColumnCell.self)
        collectionView.backgroundColor = .clear
        collectionView.qy_header = QYRefreshHeader()
        return collectionView
    }()
    
    private lazy var viewModel = GameColumnViewModel()
    private lazy var vmInput = GameColumnViewModel.Input(headerRefresh: collectionView.qy_header.rx.refreshing.asDriver())
    private lazy var vmOutput = viewModel.transform(input: vmInput)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavi()
    }
    
    override func makeUI() {
        
        super.makeUI()
        view.backgroundColor = RGB(240, g: 240, b: 240)
        view.addSubview(collectionView)
        collectionView.qy_header.beginRefreshing()
    }
    
    override func bindViewModel() {
        
        vmOutput.vmDatas.drive(collectionView.rx.items) { (collectionView, row, item) in
            
            let cell = collectionView.dequeueReusableCell(for: IndexPath(item: row, section: 0), cellType: GameHomeColumnCell.self)
            cell.isLoadBigImage = true
            cell.column = item
            return cell
        }.disposed(by: rx.disposeBag)
        
        // 刷新状态
        vmOutput.endHeaderRefresh
        .drive(collectionView.qy_header.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
        
        collectionView.rx.modelSelected(GameSpecialList.self)
        .subscribe(onNext: {
                
            let hasSubList = $0.hasSubList
            let nodeID = $0.nodeId
            navigator.push(NavigationURL.columnDetail(hasSubList, nodeID).path)
        }).disposed(by: rx.disposeBag)
    }
}

// MARK: - 设置 UI 界面
extension GameColumnViewController {
    
    private func setUpNavi() {
        title = "特色专题"
    }
}
