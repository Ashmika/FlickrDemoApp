//
//  ViewController.swift
//  FlickerDemoApp
//
//  Created by Ashmika on 11/04/25.
//

import UIKit

class FlickrImageViewController: UIViewController {

    @IBOutlet weak var collectionViewFlickr: UICollectionView!
    private let viewModel = FlickrImageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure collectionView
        collectionViewFlickr.delegate = self
        collectionViewFlickr.dataSource = self
        collectionViewFlickr.register(FlickrImageCell.self, forCellWithReuseIdentifier: "cell")
        collectionViewFlickr.backgroundColor = .clear
        
        // Load images
        viewModel.loadImages { [weak self] in
            self?.collectionViewFlickr.reloadData()
        }

    }


}


extension FlickrImageViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FlickrImageCell
        let item = viewModel.items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    // MARK: - Collection View Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat = 16  // total space between cells (left + right + spacing)
            let itemsPerRow: CGFloat = 3

            let totalSpacing = padding + (itemsPerRow - 1) * 8 // 8 is inter-item spacing
            let width = (collectionView.frame.width - totalSpacing) / itemsPerRow
            return CGSize(width: width, height: width) // Square cells
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
}
