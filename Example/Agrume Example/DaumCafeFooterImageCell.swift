//
//  DaumCafeImageCell.swift
//  Agrume Example
//
//  Created by kakao on 2022/04/29.
//  Copyright © 2022 Schnaub. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DaumCafeFooterImageCell: UICollectionViewCell {
  let highlightedView: UIView = UIView()
  let imageView: SDAnimatedImageView = SDAnimatedImageView()
  
  static let identifier = "FooterCell"
  
  override var isHighlighted: Bool {
      didSet {
          highlightCell(isHighlighted: isHighlighted)
      }
  }
  
  override var isSelected: Bool {
      didSet {
          if imageView.image == nil, let imageURL = imageView.sd_imageURL {
              updateImage(url: imageURL)
          }
          selectCell(isSelected: isSelected)
      }
  }
  
  func highlightCell(isHighlighted: Bool) {
    highlightedView.backgroundColor = isHighlighted ? .black.withAlphaComponent(0.1) : UIColor.clear
  }
  
  func selectCell(isSelected: Bool) {
    layer.borderWidth = isSelected ? 2 : 0
    let color = isSelected ? .systemRed : UIColor.clear
    layer.borderColor = color.cgColor
    highlightedView.backgroundColor = isSelected ? .black.withAlphaComponent(0.1) : UIColor.clear
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
      
    contentView.addSubview(imageView)
    contentView.addSubview(highlightedView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    highlightedView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.leftAnchor.constraint(equalTo: leftAnchor),
      imageView.rightAnchor.constraint(equalTo: rightAnchor),
      imageView.topAnchor.constraint(equalTo: topAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
      highlightedView.leftAnchor.constraint(equalTo: leftAnchor),
      highlightedView.rightAnchor.constraint(equalTo: rightAnchor),
      highlightedView.topAnchor.constraint(equalTo: topAnchor),
      highlightedView.bottomAnchor.constraint(equalTo: bottomAnchor)
      
      ])
      
      backgroundColor = UIColor.clear
      selectCell(isSelected: true)
    highlightCell(isHighlighted: true)
  }
  
  override func prepareForReuse() {
      imageView.sd_cancelCurrentImageLoad()
      
      selectCell(isSelected: false)
      highlightCell(isHighlighted: false)
  }
  
  func update(url: URL?, isSelected: Bool) {
      updateImage( url: url)
      selectCell(isSelected: isSelected)
  }
  
  func updateImage(url: URL?) {
      imageView.sd_setImage(with: url, placeholderImage: nil, options: [.retryFailed, .lowPriority])
  }
  
  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
