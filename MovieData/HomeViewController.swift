//
//  ViewController.swift
//  MovieData
//
//  Created by Anthony Santiago on 06/11/23.
//

import UIKit

class HomeViewController: UIViewController{
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    let vStackView = UIStackView()
    let viewContainer = UIView()
    let backgroundImage = UIImageView()
    let network = HomeNetworkManager()
    let configuration = ConfigurationController()
    let media = MediaNetworkManager()
    var cacheImages: [String: UIImage] = [:]
    
    var headerView: UIView {
        let view = UIView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Top rated movies"
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20.0)
        ])
        return view
    }
    
    var homeModel: HomeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        configureUI()
        fetchTopMovies()
        configureCollectionView()
    }
    func fetchTopMovies() {
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
    func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                    layout.minimumLineSpacing = 0
                    layout.minimumInteritemSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    layout.scrollDirection = .horizontal
                    layout.collectionView?.isPagingEnabled = true
                }
        collectionView.register(CardMovieCell.self, forCellWithReuseIdentifier: "CardMovieCell")
    }
    func configureUI() {
        let headerView = headerView
        headerView.backgroundColor = .clear
        headerView.translatesAutoresizingMaskIntoConstraints = false
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = backgroundImage.bounds
        backgroundImage.addSubview(blurView)
        vStackView.axis = .vertical
        vStackView.alignment = .center
        vStackView.distribution = .fill
        collectionView.backgroundColor = .clear
        viewContainer.addSubview(backgroundImage)
        viewContainer.addSubview(collectionView)
        vStackView.addArrangedSubview(headerView)
        vStackView.addArrangedSubview(viewContainer)

        view.addSubview(vStackView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 120.0),
            viewContainer.trailingAnchor.constraint(equalTo: vStackView.trailingAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: vStackView.leadingAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            blurView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            blurView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -250),
            vStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeModel?.results.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardMovieCell", for: indexPath) as! CardMovieCell
        guard let dataHomeModel = homeModel?.results[indexPath.item],
              let baseUrl = configuration.config?.images.secureBaseURL else { return UICollectionViewCell() }
        if let image = self.cacheImages[dataHomeModel.posterPath] {
            cell.configure(image: image, homeModel: dataHomeModel)
        } else {
            media.getImage(url: baseUrl, imagePath: dataHomeModel.posterPath) { response in
                switch response {
                    case .success(let success):
                        DispatchQueue.main.async {
                            self.backgroundImage.image = success
                            self.cacheImages[dataHomeModel.posterPath] = success
                            cell.configure(image: success, homeModel: dataHomeModel)
                        }
                    case .failure(_): break
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
