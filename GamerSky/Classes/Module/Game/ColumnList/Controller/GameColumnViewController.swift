//
//  GameColumnViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit
import NSObject_Rx

class GameColumnViewController: BaseViewController {
    
    // MARK: - LazyLoad
    /// 特色专题
    private lazy var gameColumn = [GameSpecialList]()
    
    private lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: GameColumnFlowLayout())
        collectionView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: GameHomeColumnCell.self)
        collectionView.backgroundColor = .clear
        return collectionView
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
extension GameColumnViewController {
    
    private func setUpUI() {
        
        view.backgroundColor = RGB(240, g: 240, b: 240)
        view.addSubview(collectionView)
    }
    
    private func setUpNavi() {
        
        title = "特色专题"
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func setUpRefresh() {
        
        collectionView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            
            // 特色专题
            GameApi.gameSpecialList(1)
            .cache
            .request(objectModel: BaseModel<[GameSpecialList]>.self)
            .subscribe(onNext: {
                self.gameColumn = $0.result
                self.collectionView.reloadData()
                self.collectionView.qy_header.endRefreshing()
            }, onError: { _ in
                self.collectionView.qy_header.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        collectionView.qy_header.beginRefreshing()
    }
}

// MARK: - UICollectionViewDataSource
extension GameColumnViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameColumn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameHomeColumnCell.self)
        cell.isLoadBigImage = true
        cell.column = gameColumn[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameColumnViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = ColumnDetailViewController()
        vc.isHasSubList = gameColumn[indexPath.item].hasSubList
        vc.nodeID = gameColumn[indexPath.item].nodeId
        navigationController?.pushViewController(vc, animated: true)
    }
}
