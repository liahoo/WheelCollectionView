//
//  Songs.swift
//  CustomViewStudy
//
//  Created by 胡 亮 on 2018/03/19.
//  Copyright © 2018年 胡 亮. All rights reserved.
//

import UIKit
class Songs: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
  let images: [String] = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Images")
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("collectionView numberOfItemsInSection: \(section) return \(images.count)")
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CircularCollectionViewCell
    cell.imageName = images[indexPath.row]
    print("collectionView cellForItemAt: \(indexPath.row) return \(cell.imageName)")
    return cell
  }
}
