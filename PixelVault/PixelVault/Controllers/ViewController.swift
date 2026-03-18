//
//  ViewController.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import UIKit

class ViewController: UIViewController {
    
    private let searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for images"
        searchBar.keyboardType = .default
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .systemCyan
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        searchBar.delegate = self
        
        setupUI()
    }
    
    private func setupUI() {
        
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func performSearch(searchQuery: String) {
        Task {
            do {
                let result = try await PixelApiService.fetchAllPosts(with: searchQuery)
                print("Total Posts: \(result.hits.count)")
            } catch {
                print(error)
            }
        }
    }

}

