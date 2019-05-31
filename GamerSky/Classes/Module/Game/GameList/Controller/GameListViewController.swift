//
//  GameListViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/23.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameListViewController: CollectionViewController<GameListViewModel> {

    // MARK: - LazyLoad
    private lazy var filterView = FilterView(frame: CGRect(x: 0, y: -FilterView.height, width: Configs.Dimensions.screenWidth, height: FilterView.height))
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavi()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filterView.frame = CGRect(x: 0, y: -FilterView.height, width: Configs.Dimensions.screenWidth, height: FilterView.height)
    }

    init() {
        super.init(collectionViewLayout: GameListFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()

        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets.init(top: FilterView.height, left: 0, bottom: 0, right: 0)
        collectionView.register(cellType: GameListCell.self)
        collectionView.register(supplementaryViewType: GameListHeaderView.self, ofKind: UICollectionView.elementKindSectionHeader)
        collectionView.refreshHeader = RefreshHeader()
        collectionView.refreshFooter = RefreshFooter()
        collectionView.addSubview(filterView)
        beginHeaderRefresh()
    }
    
    override func bindViewModel() {
        super.bindViewModel()

        let input = GameListViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.items.drive(collectionView.rx.items(cellIdentifier: GameListCell.ID, cellType: GameListCell.self)) { (collectionView, item, cell) in
            cell.info = item
        }
        .disposed(by: self.rx.disposeBag)
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
