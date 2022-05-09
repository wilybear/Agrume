//
//  MultipleUrlsExampleViewController.swift
//  Agrume Example
//
//  Created by kakao on 2022/04/28.
//  Copyright © 2022 wily.kim. All rights reserved.
//

import Agrume
import UIKit
import SDWebImage

final class MultipleUrlsExampleViewController: UIViewController {

  //TODO: SDWebImage 데이터 가져올시에 .sync async 옵션 물어보기
  //TODO: 확대후 사진 바깥으로 드래그시 이벤트 발생하도록 (예시: 확대하고 왼쪽으로 쭉 당기면 넘어가고 위로 당기면 사라지고) -> 옵션으로 해결
  //TODO: Webp가 animated 인지 아닌지??
  //TODO: SDAnimatedImage를 UIImage처럼 사용해도 되나..?
  //TODO: 왼쪽에서 오른쪽으로 드래그씨 순간이동 수정하기
  //TODO: 로그에 나오는거 수정하기
  
  
  /// 일반 이미지 urls
  private let urls = [
    URL(string: "https://picsum.photos/800/900"),
    URL(string: "https://picsum.photos/800/800"),
    URL(string: "https://picsum.photos/800/700"),
    URL(string: "https://picsum.photos/800/600"),
    URL(string: "https://picsum.photos/800/500"),
    URL(string: "https://picsum.photos/800/400"),
    URL(string: "https://picsum.photos/900/900"),
    URL(string: "https://picsum.photos/700/900"),
    URL(string: "https://picsum.photos/600/900"),
    URL(string: "https://picsum.photos/500/900"),
    URL(string: "https://picsum.photos/400/900"),
    URL(string: "https://picsum.photos/300/900"),
    URL(string: "https://picsum.photos/200/200"),
    URL(string: "https://picsum.photos/100/100")
  ]
  
  /// gif 이미지 urls
  private let gifUrls = [
    URL(string: "https://media.giphy.com/media/duzpaTbCUy9Vu/giphy.gif"),
    URL(string: "https://media.giphy.com/media/3ohfFrjeqcGR9XYX4I/giphy.gif"),
    URL(string: "https://media.giphy.com/media/l1IY3kHHFKEI1IlDa/giphy.gif"),
    URL(string: "https://media.giphy.com/media/j5P0DQIOf4PonLi55G/giphy.gif"),
    URL(string: "https://media.giphy.com/media/DJNLhVBrJKjEkxTzPk/giphy.gif"),
    URL(string: "https://media.giphy.com/media/8H80IVPjAdKY8/giphy.gif"),
    URL(string: "https://media.giphy.com/media/l41JWw65TcBGjPpRK/giphy.gif"),
    URL(string: "https://media.giphy.com/media/mxjzBpyu8DDLIcEKVC/giphy.gif"),
    URL(string: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/giphy.gif"),
    URL(string: "https://media.giphy.com/media/J336VCs1JC42zGRhjH/giphy.gif")
  ]
  
  /// webp 이미지 urls, 첫번쨰 webp는 움직이는 이미지
  private let webpUrls = [
    URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FAbHhH%2FbtqvWquhKAd%2FIcKEAzO56PfEtaydRQWYG0%2Fimg.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/1.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/2.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/3.sm.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/5.webp")
  ]
  private var testUrls: [URL] = []
  
  private var agrume: Agrume?
  
  private lazy var overlayView: DaumCafeOverlayView = {
    let overlay = DaumCafeOverlayView()
    overlay.delegate = self
    overlay.footerCollectionView.delegate = self
    overlay.footerCollectionView.dataSource = self
    return overlay
  }()
  
  @IBAction private func openImage(_ sender: Any?) {
    testUrls = urls.compactMap {$0}
    showArgrumeWith(urls: testUrls)
  }
  
  @IBAction func openGif(_ sender: Any) {
    testUrls = gifUrls.compactMap {$0}
    showArgrumeWith(urls: testUrls)
  }
  
  @IBAction func openWebp(_ sender: Any) {
    testUrls = webpUrls.compactMap {$0}
    showArgrumeWith(urls: testUrls)
  }
  
  private func showArgrumeWith(urls: [URL]) {
    agrume = Agrume(urls: urls, startIndex: 0, background: .colored(.black), overlayView: overlayView)
    self.overlayView.navigationBar.topItem?.title = "1 / \(urls.count)"
    agrume?.tapBehavior = .toggleOverlayVisibility
    agrume?.allowSwipeWhileZoomed = true
    agrume?.willScroll = { [weak self] index in
      guard let `self` = self else { return }
      self.willScroll(index: index)
    }
    overlayView.footerCollectionView.reloadData()
    overlayView.footerCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    agrume?.show(from: self)
  }
  
  private func willScroll(index: Int) {
    overlayView.footerCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    overlayView.navigationBar.topItem?.title = "\(index + 1) / \(self.testUrls.count)"
  }
  
  @IBAction func clearCache(_ sender: Any) {
    SDImageCache.shared.clearDisk()
    SDImageCache.shared.clearMemory()
  }
    
}

extension MultipleUrlsExampleViewController: DaumCafeOverlayViewDelegate {
  func closeView(_ overlayView: AgrumeOverlayView) {
    agrume?.dismiss()
  }
  
  func downloadImage(_ overlayView: AgrumeOverlayView) {
    guard let index = agrume?.currentIndex else { return }
    agrume?.image(forIndex: index) { [weak self]  image in
      guard let image = image else { return }
      UIImageWriteToSavedPhotosAlbum(image, self, #selector(self?.saveCompleted), nil)
    }
  }
  
  @objc private func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    print("Save finished!")
  }
}

extension MultipleUrlsExampleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: DaumCafeFooterImageCell.identifier, for: indexPath)
    if let cell = cell as? DaumCafeFooterImageCell {
      // 썸네일용 url 사용해야함
      cell.update(url: testUrls[indexPath.item], isSelected: indexPath.row == agrume?.currentIndex)
    }
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    testUrls.count
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    agrume?.showImage(atIndex: indexPath.item, animated: false)
    self.overlayView.navigationBar.topItem?.title = "\(indexPath.item + 1) / \(self.testUrls.count)"
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
          let cellSpacing = layout.minimumLineSpacing
          let cellWidth = layout.itemSize.width
          let cellCount = CGFloat(collectionView.numberOfItems(inSection: section))
          let totalWidth = cellCount * cellWidth
          let totalSpacing = (cellCount - 1) * cellSpacing
          var inset = (collectionView.bounds.size.width - totalWidth - totalSpacing) * 0.5
          inset = max(inset, 10)
          return UIEdgeInsets.init(top: 10, left: inset, bottom: 10, right: 10)
      }
      return UIEdgeInsets.init(top: 10, left: 10, bottom:  10, right: 10)
  }
  
}

