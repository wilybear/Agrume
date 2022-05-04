//
//  MultipleUrlsExampleViewController.swift
//  Agrume Example
//
//  Created by kakao on 2022/04/28.
//  Copyright © 2022 Schnaub. All rights reserved.
//

import Agrume
import UIKit
import SDWebImage

final class MultipleUrlsExampleViewController: UIViewController {

  //TODO: SDWebImage 데이터 가져올시에 .sync async 옵션 물어보기
  //TODO: SDWebImage는 주소가 같은 URL의 경우 같은 이미지로 인식... 맞나?
  //TODO: 확대후 사진 바깥으로 드래그시 이벤트 발생하도록 (예시: 확대하고 왼쪽으로 쭉 당기면 넘어가고 위로 당기면 사라지고)
  //TODO: CollectionView에서 이미지 prefetching 가능한가??? 옆으로 넘길때 미리 로딩 되어 있도록
  //TODO: OverlayView에 대해서 좀더 알아볼것
  //TODO: Webp가 animated 인지 아닌지??
  //TODO: SDAnimatedImage를 UIImage처럼 사용해도 되나..?
  
  
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
  
  private let webpUrls = [
    URL(string: "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FAbHhH%2FbtqvWquhKAd%2FIcKEAzO56PfEtaydRQWYG0%2Fimg.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/1.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/2.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/3.sm.webp"),
    URL(string: "https://www.gstatic.com/webp/gallery/5.webp")
  ]
  
  
  
  @IBAction private func openImage(_ sender: Any?) {
    let agrume = Agrume(urls: urls.compactMap {$0}, startIndex: 3, background: .colored(.black))
  //  let agrume = Agrume(urls: gifUrls.compactMap {$0}, startIndex: 0, background: .colored(.black))
  //  let agrume = Agrume(urls: webpUrls.compactMap {$0}, startIndex: 0, background: .colored(.black))
    agrume.show(from: self)
  }
    @IBAction func clearCache(_ sender: Any) {
        SDImageCache.shared.clearDisk()
        SDImageCache.shared.clearMemory()
    }
    
}
