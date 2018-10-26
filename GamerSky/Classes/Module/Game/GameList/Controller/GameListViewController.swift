//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/23.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameListViewController: BaseViewController {
    
    /// 页码
    private var page = 1
    
    // MARK: - LazyLoad
    private lazy var collectionView: BaseCollectionView = {
        
        let collectionView = BaseCollectionView(frame: UIScreen.main.bounds, collectionViewLayout: GameListFlowLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets.init(top: kTopH + FilterView.height, left: 0, bottom: 0, right: 0)
        collectionView.register(cellType: GameListCell.self)
        collectionView.register(supplementaryViewType: GameListHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        return collectionView
    }()
    
    private lazy var filterView: FilterView = {
        
        let filterView = FilterView(frame: CGRect(x: 0, y: -FilterView.height, width: ScreenWidth, height: FilterView.height))
        return filterView
    }()
    
    private lazy var gameLists = [GameChildElement]()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
        setUpUI()
        setUpRefresh()
    }
}

// MARK: - 设置 UI 界面
extension GameListViewController {
    
    private func setUpNavi() {
        
        title = "找游戏"
        automaticallyAdjustsScrollViewInsets = false
    }

    private func setUpUI() {
        
        view.addSubview(collectionView)
        collectionView.addSubview(filterView)
    }
}

extension GameListViewController {
    
    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        collectionView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            self.page = 1
            self.collectionView.qy_footer.endRefreshing()
            
            GameApi.gameList(self.page)
            .cache
            .request()
            .mapObject(BaseModel<GameList>.self)
            .subscribe(onNext: {
            
                self.gameLists = $0.result.childelements
                self.collectionView.reloadData()
                self.collectionView.qy_header.endRefreshing()
            }, onError: { _ in
                self.collectionView.qy_header.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        collectionView.qy_footer = QYRefreshFooter(refreshingBlock: { [weak self] in
            
            guard let `self` = self else {return}
            self.page += 1
            self.collectionView.qy_header.endRefreshing()
            
            GameApi.gameList(self.page)
            .cache
            .request()
            .mapObject(BaseModel<GameList>.self)
            .subscribe(onNext: {
                
                self.gameLists += $0.result.childelements
                self.collectionView.reloadData()
                self.collectionView.qy_footer.endRefreshing()
            }, onError: { _ in
                self.collectionView.qy_footer.endRefreshing()
            })
            .disposed(by: self.rx.disposeBag)
        })
        
        collectionView.qy_header.beginRefreshing()
    }
}

// MARK: - UICollectionViewDataSource
extension GameListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: GameListCell.self)
        cell.info = gameLists[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension GameListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: GameListHeaderView.self)
        return header
    }
}
