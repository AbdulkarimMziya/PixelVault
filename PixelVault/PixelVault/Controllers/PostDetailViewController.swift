//
//  PostDetailViewController.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-19.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    private let post: Post
    
    // MARK: - UI Elements
    
    private let authorImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.backgroundColor = .systemGray4
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // Info labels with icons
    private let viewsLabel = UILabel()
    private let downloadsLabel = UILabel()
    private let likesLabel = UILabel()
    
    private lazy var infoStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [viewsLabel, downloadsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Init
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .pageSheet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        configure()
        loadMediumImage()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.addSubview(authorImageView)
        view.addSubview(authorLabel)
        view.addSubview(imageView)
        view.addSubview(infoStack)
        
        NSLayoutConstraint.activate([
            // Author avatar
            authorImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            authorImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authorImageView.widthAnchor.constraint(equalToConstant: 40),
            authorImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // Author name
            authorLabel.centerYAnchor.constraint(equalTo: authorImageView.centerYAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: authorImageView.trailingAnchor, constant: 12),
            authorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // Main image
            imageView.topAnchor.constraint(equalTo: authorImageView.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            // Info stack
            infoStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            infoStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoStack.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            infoStack.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configure() {
        authorLabel.text = post.author
        authorImageView.image = UIImage(systemName: "person.circle.fill")
        
        // Views, Downloads, Likes
        viewsLabel.attributedText = iconText(systemName: "eye.fill", value: formatNumber(post.views))
        downloadsLabel.attributedText = iconText(systemName: "arrow.down.circle.fill", value: formatNumber(post.downloads))
        likesLabel.attributedText = iconText(systemName: "heart.fill", value: formatNumber(post.likes))
        
        // Adjust font/colors for all labels
        [viewsLabel, downloadsLabel, likesLabel].forEach {
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.textColor = .label
        }
    }
    
    private func loadMediumImage() {
        Task {
            if let mediumImage = try? await PixelApiService.fetchImage(from: post.mediumSizeImageURL) {
                DispatchQueue.main.async {
                    self.imageView.image = mediumImage
                }
            }
        }
    }
    
    // Helper function to combine icon + text
    private func iconText(systemName: String, value: String) -> NSAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: systemName)?.withTintColor(.label)
        attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
        
        let attributedString = NSMutableAttributedString(attachment: attachment)
        attributedString.append(NSAttributedString(string: " \(value)"))
        return attributedString
    }
    
    private func formatNumber(_ value: Int) -> String {
        if value >= 1_000_000 {
            let millions = Double(value) / 1_000_000
            return String(format: "%.1fM", millions).replacingOccurrences(of: ".0", with: "")
        } else if value >= 1_000 {
            let thousands = Double(value) / 1_000
            return String(format: "%.1fk", thousands).replacingOccurrences(of: ".0", with: "")
        } else {
            return "\(value)"
        }
    }

}
