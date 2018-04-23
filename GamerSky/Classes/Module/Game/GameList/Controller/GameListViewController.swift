//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/23.
//Copyright © 2018年 engic. All rights reserved.
//

import UIKit

class GameListViewController: BaseViewController {
    
    /// 左右间距
    private let kEdge: CGFloat = 15
    /// cell 上下间距
    private let kLineSpacing: CGFloat = 15
    /// cell 左右间距
    private let kInteritemSpacing: CGFloat = 30
    /// 每行最大列数
    private let kMaxCol: CGFloat = 3
    /// cell 宽度
    private var kItemW: CGFloat {
        return (ScreenWidth - (2 * kEdge) - ((kMaxCol - 1) * kInteritemSpacing)) / kMaxCol
    }
    private var kItemH: CGFloat {
        return kItemW * 1.8
    }
    
    /// 页码
    private var page = 1
    
    // MARK: - LazyLoad
    private lazy var collectionView: BaseCollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kItemH)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kEdge, 0, kEdge)
        flowLayout.minimumLineSpacing = kLineSpacing
        flowLayout.minimumInteritemSpacing = kInteritemSpacing
        let collectionView = BaseCollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(kTopH, 0, 0, 0)
        collectionView.register(cellType: GameListCell.self)
        return collectionView
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

extension GameListViewController {
    
    // MARK: - 设置刷新
    private func setUpRefresh() {
        
        collectionView.qy_header = QYRefreshHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else {return}
            strongSelf.page = 1
            strongSelf.collectionView.qy_footer.endRefreshing()
            ApiProvider.request(Api.gameList(strongSelf.page), objectModel: BaseModel<GameList>.self, success: {
                
                strongSelf.gameLists = $0.result.childelements
                strongSelf.collectionView.reloadData()
                strongSelf.collectionView.qy_header.endRefreshing()
            }, failure: { _ in
                strongSelf.collectionView.qy_header.endRefreshing()
            })
        })
        
        collectionView.qy_footer = QYRefreshFooter(refreshingBlock: { [weak self] in

            guard let strongSelf = self else {return}
            strongSelf.page += 1
            strongSelf.collectionView.qy_header.endRefreshing()
            ApiProvider.request(Api.gameList(strongSelf.page), objectModel: BaseModel<GameList>.self, success: {
                
                strongSelf.gameLists += $0.result.childelements
                strongSelf.collectionView.reloadData()
                strongSelf.collectionView.qy_footer.endRefreshing()
            }, failure: { _ in
                strongSelf.collectionView.qy_footer.endRefreshing()
            })
        })
        
        collectionView.qy_header.beginRefreshing()
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
}
