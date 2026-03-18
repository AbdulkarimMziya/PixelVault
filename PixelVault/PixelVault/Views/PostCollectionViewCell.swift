//
//  PostCollectionViewCell.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-18.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PostCollectionViewCell"
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray5
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let overlayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        label.layer.cornerRadius = 4
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(overlayLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                    
            overlayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            overlayLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            overlayLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
            overlayLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post, image: UIImage?) {
        overlayLabel.text = "\(post.author)"
        imageView.image = image
    }
}
