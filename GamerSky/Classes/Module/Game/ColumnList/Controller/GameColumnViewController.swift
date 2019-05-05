//
//  GameColumnViewController.swift
//  GamerSky
//
//  Created by InsectQY on 2018/4/14.
//Copyright © 2018年 QY. All rights reserved.
//

import UIKit

class GameColumnViewController: CollectionViewController {
    
    // MARK: - LazyLoad
    private lazy var viewModel = GameColumnViewModel(input: self)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavi()
    }

    init() {
        super.init(collectionViewLayout: GameColumnFlowLayout())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func makeUI() {
        super.makeUI()

        view.backgroundColor = RGB(240, g: 240, b: 240)

        collectionView.register(cellType: GameHomeColumnCell.self)
        collectionView.refreshHeader = RefreshHeader()
        beginHeaderRefresh()
    }
    
    override func bindViewModel() {
        super.bindViewModel()

        let input = GameColumnViewModel.Input()
        let output = viewModel.transform(input: input)

        output.items.drive(collectionView.rx.items) { (collectionView, row, item) in
            
            let cell = collectionView.dequeueReusableCell(for: IndexPath(item: row, section: 0), cellType: GameHomeColumnCell.self)
            cell.isLoadBigImage = true
            cell.column = item
            return cell
        }
        .disposed(by: rx.disposeBag)
        
        collectionView.rx.modelSelected(GameSpecialList.self)
        .subscribe(onNext: {
                
            let hasSubList = $0.hasSubList
            let nodeID = $0.nodeId
            navigator.push(NavigationURL.columnDetail(hasSubList, nodeID).path)
        })
        .disposed(by: rx.disposeBag)
    }
}

// MARK: - 设置 UI 界面
extension GameColumnViewController {
    
    private func setUpNavi() {
        title = "特色专题"
    }
}
