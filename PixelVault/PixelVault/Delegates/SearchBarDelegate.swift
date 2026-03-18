//
//  SearchBarDelegate.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import UIKit

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text, !searchQuery.isEmpty else {
            return
        }
        
        searchBar.resignFirstResponder()
        
        performSearch(searchQuery: searchQuery)
    }
}
