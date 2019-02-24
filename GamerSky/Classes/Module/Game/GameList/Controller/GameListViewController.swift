//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/23.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameListViewController: ViewController {

    // MARK: - LazyLoad
    private lazy var collectionView: CollectionView = {
        
        let collectionView = CollectionView(frame: UIScreen.main.bounds, collectionViewLayout: GameListFlowLayout())
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets.init(top: FilterView.height, left: 0, bottom: 0, right: 0)
        collectionView.register(cellType: GameListCell.self)
        collectionView.register(supplementaryViewType: GameListHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.refreshHeader = RefreshHeader()
        collectionView.refreshFooter = RefreshFooter()
        return collectionView
    }()
    
    private lazy var filterView: FilterView = {
        
        let filterView = FilterView(frame: CGRect(x: 0, y: -FilterView.height, width: ScreenWidth, height: FilterView.height))
        return filterView
    }()
    
    private lazy var viewModel = GameListViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
    }
    
    override func makeUI() {
        
        super.makeUI()
        view.addSubview(collectionView)
        collectionView.addSubview(filterView)
    }
    
    override func bindViewModel() {
        
        let input = GameListViewModel.Input(headerRefresh: collectionView.refreshHeader.rx.refreshing.asDriver(), footerRefresh: collectionView.refreshFooter.rx.refreshing.asDriver())
        let output = viewModel.transform(input: input)
        
        output.items.drive(collectionView.rx.items(cellIdentifier: GameListCell.ID, cellType: GameListCell.self)) { (collectionView, item, cell) in
            cell.info = item
        } .disposed(by: self.rx.disposeBag)
        
        // 刷新状态
        output.endHeaderRefresh
        .drive(collectionView.refreshHeader.rx.isRefreshing)
        .disposed(by: rx.disposeBag)
        
        output.endFooterRefresh
        .drive(collectionView.refreshFooter.rx.refreshFooterState)
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - 设置 UI 界面
extension GameListViewController {
    
    private func setUpNavi() {
        
        title = "找游戏"
    }
}

// MARK: - UICollectionViewDelegate
extension GameListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, for: indexPath, viewType: GameListHeaderView.self)
        return header
    }
}
