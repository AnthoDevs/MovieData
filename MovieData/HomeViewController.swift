//
//  ViewController.swift
//  MovieData
//
//  Created by Anthony Santiago on 06/11/23.
//

import UIKit

class HomeViewController: UIViewController{
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let network = NetworkManager()
    var homeModel: HomeModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        configureUI()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        network.requestHomeData(){ [self] result in
            switch result {
            case .success(let data):
                homeModel = data
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case  .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func configureUI() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeModel?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        let titleLabel = UILabel(frame: cell.contentView.bounds)
        titleLabel.textAlignment = .center
        titleLabel.text = homeModel?.results[indexPath.item].name
        cell.contentView.addSubview(titleLabel)
        cell.backgroundColor = .gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.0
        let height: CGFloat = 100.0
        return CGSize(width: width, height: height)
    }
    
    
}
