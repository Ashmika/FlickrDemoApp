//
//  FlickerImageCell.swift
//  FlickerDemoApp
//
//  Created by Ashmika on 11/04/25.
//

import UIKit

class FlickrImageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 12
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.addSubview(imageView)

            // Constraints for full size image
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])

            // Styling
            contentView.layer.cornerRadius = 12
            contentView.layer.masksToBounds = true

            // Drop shadow
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowRadius = 4
            layer.masksToBounds = false
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

        override func prepareForReuse() {
            super.prepareForReuse()
            imageView.image = nil
        }
    
    /// Configure cell with Flickr image
        func configure(with item: FlickrImage) {
            ImageCache.getImage(from: item.media.m) { [weak self] image in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
}
