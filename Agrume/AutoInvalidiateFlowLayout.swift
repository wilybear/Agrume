//
//  CustomFlowLayout.swift
//  Agrume
//
//  Created by kakao on 2022/05/10.
//  Copyright © 2022 wily.kim. All rights reserved.
//

import UIKit

class AutoInvalidiateFlowLayout: UICollectionViewFlowLayout {
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
