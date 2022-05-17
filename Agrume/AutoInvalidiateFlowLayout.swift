//
//  CustomFlowLayout.swift
//  Agrume
//
//  Created by wily.kim on 2022/05/10.
//  Copyright © 2022 kakao All rights reserved.
//

import UIKit

class AutoInvalidiateFlowLayout: UICollectionViewFlowLayout {
  
  private var previousOffset: CGFloat = 0
  private var currentPage: Int = 0

  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
     guard let collectionView = collectionView else {
         return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
     }

     let itemsCount = collectionView.numberOfItems(inSection: 0)

     // Imitating paging behaviour
     // Check previous offset and scroll direction
     if previousOffset > collectionView.contentOffset.x && velocity.x < 0 {
         currentPage = max(currentPage - 1, 0)
     } else if previousOffset < collectionView.contentOffset.x && velocity.x > 0 {
         currentPage = min(currentPage + 1, itemsCount - 1)
     }

     // Update offset by using item size + spacing
     let updatedOffset = (itemSize.width + minimumInteritemSpacing) * CGFloat(currentPage)
     previousOffset = updatedOffset

     return CGPoint(x: updatedOffset, y: proposedContentOffset.y)
  }
  
  func cellSize(bounds: CGRect) -> CGSize {
    guard let collectionView = collectionView else {
      return .zero
    }
    
    let insets = collectionView.contentInset
    let width = bounds.width - insets.left - insets.right
    let height = bounds.height - insets.top - insets.bottom
  
    if width < 0 || height < 0 { return .zero}
    else { return CGSize(width: width, height: height)}
  }
  
  func updateEstimatedSize(bounds: CGRect) {
    estimatedItemSize = cellSize(bounds: bounds)
  }
  
  // collectionview가 처음 assign 될때 초기화
  override func prepare() {
    super.prepare()
    
    let bounds = collectionView?.bounds ?? .zero
    updateEstimatedSize(bounds: bounds)
  }
  
  // 만약 최근의 bounds.size가 새로운 bounds.size와 맞지 않을 경우
  // estimatedSize를 업데이트하고 layout을 invalidate 시킴
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    guard let collectionview = collectionView else { return false}
    let oldSize = collectionview.bounds.size
    guard oldSize != newBounds.size else { return false }
    
    updateEstimatedSize(bounds: newBounds)
    return true
  }
  
}
