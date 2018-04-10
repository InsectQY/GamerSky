//
//  TimeLineFlowLayout.swift
//  GamerSky
//
//  Created by engic on 2018/4/10.
//  Copyright © 2018年 engic. All rights reserved.
//

import UIKit

private let decorationLineViewKind = "LineView"

class TimeLineFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
//        register(LineView.self, forDecorationViewOfKind: decorationLineViewKind)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//        return UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath)
//    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttrs = super.layoutAttributesForElements(in: rect)
        
//        if let decorationViewLayoutAttr = layoutAttributesForDecorationView(ofKind: decorationLineViewKind, at: IndexPath(item: 0, section: 0)) {
//
//            let sectionCount = collectionView!.dataSource!.numberOfSections!(in: collectionView!)
//            let firstNodeCellAttr = layoutAttributesForItem(at: IndexPath(item: 1, section: 0))
//            let lastNodeCellAttr = layoutAttributesForItem(at: IndexPath(item: 1, section: sectionCount - 1))
//            let timelineStartX = firstNodeCellAttr!.center.x
//            let timelineEndX = lastNodeCellAttr!.center.x
//            decorationViewLayoutAttr.frame = CGRect(x: timelineStartX, y: 0, width: timelineEndX - timelineStartX, height: 3)
//            layoutAttrs?.append(decorationViewLayoutAttr)
//        }
        
        let headerLayoutAttrs = layoutAttrs?.filter({ $0.representedElementKind == UICollectionElementKindSectionHeader })
        
        if headerLayoutAttrs?.count == 1 {
            
            let headerLayoutAttr = headerLayoutAttrs!.first!
            
            if layoutAttributesForItem(at: IndexPath(item: 1, section: headerLayoutAttr.indexPath.section)) != nil {
                
                let origin = headerLayoutAttr.frame.origin
                headerLayoutAttr.frame = CGRect(x: origin.x, y: 0, width: ScreenWidth - 40, height: 3)
            }
        }
        
        return layoutAttrs
    }
}
