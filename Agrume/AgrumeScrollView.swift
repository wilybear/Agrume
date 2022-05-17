//
//  AgurmeScrollView.swift
//  Agrume
//
//  Created by wily.kim on 2022/05/16.
//  Copyright © 2022 kakao All rights reserved.
//

import UIKit

class AgrumeScrollView: UIScrollView, UIGestureRecognizerDelegate {
  
  var panGestureResistance: CGFloat = 5
  
  /// 스크롤뷰 컨텐츠가 왼쪽 오른쪽 끝에 도달하였을때 panGesture를 무시하도록
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    if (gestureRecognizer is UIPanGestureRecognizer) && (otherGestureRecognizer is UIPanGestureRecognizer) , contentOffset.x - panGestureResistance > contentSize.width - frame.size.width || contentOffset.x + panGestureResistance < 0 {
      return true
    }
    return false
  }

}
