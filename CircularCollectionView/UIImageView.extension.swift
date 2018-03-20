//
//  UIImageView.extension.swift
//  CircularCollectionView
//
//  Created by 胡 亮 on 2018/03/18.
//  Copyright © 2018年 Rounak Jain. All rights reserved.
//

import UIKit

extension UIImageView {
  func toCircle() {
    self.layer.cornerRadius = self.frame.size.width / 2
    self.clipsToBounds = true
  }
}
