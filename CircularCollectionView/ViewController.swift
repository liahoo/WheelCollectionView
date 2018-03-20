//
//  ViewController.swift
//  CircularCollectionView
//
//  Created by 胡 亮 on 2018/03/20.
//  Copyright © 2018年 Rounak Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

  @IBOutlet weak var collectionViewLeft: UICollectionView!
  @IBOutlet weak var collectionViewRight: UICollectionView!
  override func viewDidLoad() {
    super.viewDidLoad()
    initLeftList()
    initRightList()
  }
  
  private func initLeftList(){
    self.collectionViewLeft.register(CircularCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionViewLeft.dataSource = self
    collectionViewLeft.delegate = self
    (collectionViewLeft.collectionViewLayout as? CircularCollectionViewLayout)?.quarter = CircularCollectionViewLayout.Quarter.Left
  }
  
  private func initRightList(){
    self.collectionViewRight.register(CircularCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    collectionViewRight.dataSource = self
    collectionViewRight.delegate = self
    (collectionViewRight.collectionViewLayout as? CircularCollectionViewLayout)?.quarter = CircularCollectionViewLayout.Quarter.Right
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  let images: [String] = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Images")
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CircularCollectionViewCell
    cell.imageName = images[indexPath.row]
    return cell
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
