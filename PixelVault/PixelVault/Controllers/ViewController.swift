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
    
    lazy var segmentedControl: UISegmentedControl = {
        let items = ["Search", "Favourites"]
        let control = UISegmentedControl(items: items)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action:#selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // This catches every return trip (Back button, swipe, or pop)
        segmentedControl.selectedSegmentIndex = 0
    }

    
    private func setupUI() {
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            segmentedControl.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 12),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8),
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
    
    @objc
    func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let selectedTitle = sender.titleForSegment(at: sender.selectedSegmentIndex)
        
        if selectedTitle == "Favourites" {
            // Only push if the current top view is NOT already Favorites
            if !(navigationController?.topViewController is FavoritePostsViewController) {
                let favoriteVC = FavoritePostsViewController()
                navigationController?.pushViewController(favoriteVC, animated: true)
            }
        } else {
            // If they tap "Search", pop back to the main view
            navigationController?.popToRootViewController(animated: true)
        }
    }

}

