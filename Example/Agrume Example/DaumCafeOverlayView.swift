//
//  DaumCafeOverlayView.swift
//  Agrume Example
//
//  Created by kakao on 2022/04/29.
//  Copyright © 2022 Schnaub. All rights reserved.
//

import Foundation
import Agrume
import UIKit

protocol DaumCafeOverlayViewDelegate: AnyObject {
  func closeView(_ overlayView: AgrumeOverlayView)
  func downloadImage(_ overlayView: AgrumeOverlayView)
}

class DaumCafeOverlayView: AgrumeOverlayView {
  
  lazy var navigationBar: UINavigationBar = {
    let navigationBar = UINavigationBar()
    navigationBar.translatesAutoresizingMaskIntoConstraints = false
    let navigationItem = UINavigationItem(title: "")
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "top_close_w"), style: .plain, target: self, action: #selector(closeView))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "top_img_save"), style: .plain, target: self, action: #selector(downloadImage))
    navigationItem.rightBarButtonItem?.tintColor = .white
    navigationBar.pushItem(navigationItem, animated: false)
    navigationBar.barTintColor = .black
    navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    navigationBar.delegate = self
    return navigationBar
  }()
  
  lazy var footerCollectionView: UICollectionView = {
    let bottomOffset = 0
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    layout.minimumInteritemSpacing = 5
    layout.minimumLineSpacing = 5
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()

  weak var delegate: DaumCafeOverlayViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setUpUI()
  }
  
  func setUpUI() {
    addSubview(navigationBar)
    
    NSLayoutConstraint.activate([
      navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
      navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
    
    addSubview(footerCollectionView)
    
    footerCollectionView.backgroundColor = .black.withAlphaComponent(0.3)
    
    NSLayoutConstraint.activate([
      footerCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
      footerCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
      footerCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
      footerCollectionView.heightAnchor.constraint(equalToConstant: 60)
    ])
    
    footerCollectionView.register(DaumCafeFooterImageCell.self, forCellWithReuseIdentifier: DaumCafeFooterImageCell.identifier)
    
    
  }
  
  @objc func closeView() {
    delegate?.closeView(self)
  }
  
  @objc func downloadImage() {
    delegate?.downloadImage(self)
  }
}

extension DaumCafeOverlayView: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.topAttached
    }
}
