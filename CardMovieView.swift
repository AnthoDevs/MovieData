//
//  CardMovieView.swift
//  MovieData
//
//  Created by Anthony Santiago on 17/12/23.
//

import UIKit

class CardMovieCell: UICollectionViewCell {
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let cardStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually
        return stack
    }()
    let emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let posterContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    var posterView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
    let posterImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    let infostack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    let rating: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    let relaseDate: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view
    }()
    let relaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    let releaseIcon: UIImageView = {
        let releaseIcon = UIImageView()
        releaseIcon.translatesAutoresizingMaskIntoConstraints = false
        releaseIcon.image = UIImage(systemName: "calendar")
        return releaseIcon
    }()
    
    let overViewLabel = UILabel()
    var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    override init(frame: CGRect ) {
        super.init(frame: frame)
        posterContainer.addSubview(posterView)
        posterView.addSubview(posterImage)
        cardStack.addArrangedSubview(emptyView)
        cardStack.addArrangedSubview(posterContainer)
        cardStack.addArrangedSubview(infoView)
        cardView.addSubview(cardStack)
        contentView.addSubview(cardView)
        infoView.addSubview(infostack)
        infostack.addArrangedSubview(titleLabel)
        infostack.addArrangedSubview(rating)
        infostack.addArrangedSubview(relaseDate)
        infostack.addArrangedSubview(overViewLabel)
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardStack.topAnchor.constraint(equalTo: cardView.topAnchor),
            cardStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cardStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor),
            cardStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            emptyView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8),
            emptyView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            posterView.heightAnchor.constraint(equalTo: cardStack.heightAnchor, multiplier: 0.6),
            posterView.trailingAnchor.constraint(equalTo: posterContainer.trailingAnchor, constant: -25),
            posterView.bottomAnchor.constraint(equalTo: posterContainer.bottomAnchor),
            posterView.leadingAnchor.constraint(equalTo: posterContainer.leadingAnchor, constant: 25),
            posterImage.topAnchor.constraint(equalTo: posterView.topAnchor),
            posterImage.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            posterImage.bottomAnchor.constraint(equalTo: posterView.bottomAnchor),
            posterImage.leadingAnchor.constraint(equalTo: posterView.leadingAnchor),
            infostack.topAnchor.constraint(equalTo: infoView.topAnchor),
            infostack.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -40),
            infostack.bottomAnchor.constraint(equalTo: infoView.bottomAnchor),
            infostack.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 40),
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(image: UIImage, homeModel: RequestResult) {
        rating.arrangedSubviews.forEach { $0.removeFromSuperview() }
        posterImage.image = image
        titleLabel.text = homeModel.title
        relaseLabel.text = homeModel.releaseDate
        overViewLabel.text = homeModel.overview
        relaseDate.addSubview(relaseLabel)
        relaseDate.addSubview(releaseIcon)
        relaseLabel.trailingAnchor.constraint(equalTo: relaseDate.trailingAnchor).isActive = true
        releaseIcon.trailingAnchor.constraint(equalTo: relaseLabel.leadingAnchor).isActive = true
        
        for _ in 1...Int(homeModel.voteAverage) {
            let starView = UIImageView(image: UIImage(systemName: "star.fill"))
            starView.translatesAutoresizingMaskIntoConstraints = false
            starView.heightAnchor.constraint(equalToConstant: 25).isActive = true
            starView.tintColor = UIColor(red: CGFloat(0.96), green: CGFloat(0.89), blue: CGFloat(0.00), alpha: CGFloat(1.0))
            rating.addArrangedSubview(starView)
        }
    }
    
}
