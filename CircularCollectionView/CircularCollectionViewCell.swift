//
//  CircularCollectionViewCell.swift
//  CircularCollectionView
//
//  Created by Liang Hu on 18/03/18.
//  Copyright (c) 2018 Liang Hu. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

@IBDesignable
class CircularCollectionViewCell: UICollectionViewCell {

  var imageName = "" {
    didSet {
      imageView!.image = UIImage(named: imageName)
    }
  }
  
  
    @IBOutlet weak var imageView: UIImageView!
    override init(frame: CGRect) {
    super.init(frame: frame)
    self.loadNib()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadNib()
    contentView.clipsToBounds = true
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    imageView!.contentMode = .scaleAspectFill
  }
  internal func loadNib() {
    if let view = Bundle.main.loadNibNamed("CircularCollectionViewCell", owner: self, options: nil)?.first as? UICollectionViewCell {
      view.frame = self.bounds
      self.addSubview(view)
    }
  }

  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    super.apply(layoutAttributes)
    let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
    self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
    self.center.x += (circularlayoutAttributes.anchorPoint.x - 0.5)*self.bounds.width
    imageView!.layer.cornerRadius = self.bounds.width / 2
    imageView!.clipsToBounds = true
    imageView!.layer.borderColor = UIColor.darkGray.cgColor
    imageView!.layer.borderWidth = 4
  }
  
}
