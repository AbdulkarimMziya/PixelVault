//
//  ViewController.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import UIKit

class ViewController: UIViewController {
    
    var imageCache = [Int: UIImage]()
    
    var posts = [Post]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    private let searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for images"
        searchBar.keyboardType = .default
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .systemCyan
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func performSearch(searchQuery: String) {
        self.imageCache.removeAll()
        
        Task {
            do {
                let result = try await PixelApiService.fetchAllPosts(with: searchQuery)
        
                self.posts = result.hits
                
                print("Total Posts: \(self.posts.count)")
            } catch {
                print(error)
            }
        }
    }

}

