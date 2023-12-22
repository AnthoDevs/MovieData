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
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let titleLabel = UILabel()
    let rating = UILabel()
    let tags = UIStackView()
    let actors = UIStackView()
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
        infostack.addArrangedSubview(tags)
        infostack.addArrangedSubview(actors)
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
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(image: UIImage) {
        posterImage.image = image
    }
    
}
