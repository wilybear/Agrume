//
//  Copyright © 2016 Schnaub. All rights reserved.
//

import ImageIO
import MobileCoreServices
import UIKit
import SDWebImage

final class ImageDownloader {
  
  static func downloadImage(_ url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
    SDWebImageManager.shared.loadImage(with: url, options: [.retryFailed, .progressiveLoad, .queryMemoryData, .queryMemoryDataSync, .queryDiskDataSync], progress: nil) { image, data, error , cacheType, bool, url in
      if let error = error {
        print("Failed to downloadImage \(error.localizedDescription)")
      }
      
      var finalImage: UIImage?
      
      if let data = data, isAnimatedImage(data) {
        finalImage = SDAnimatedImage(data: data)
      } else {
        finalImage = image
      }
      DispatchQueue.main.async {
        completion(finalImage)
      }
    }
  }
  
  private static func isAnimatedImage(_ data: Data) -> Bool {
    let imageFormat = NSData.sd_imageFormat(forImageData: data)
    return imageFormat == .GIF || imageFormat == .webP
  }

}
