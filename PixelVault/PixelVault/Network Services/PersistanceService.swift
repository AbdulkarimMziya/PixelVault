//
//  PersistanceService.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-19.
//

import UIKit

class PersistanceService {
    
    static var posts = [Post]()
    private static let filename = "favorites.plist"
    
   
    static func save(_ posts:[Post]) throws {
        let url = PersistanceManager.shared.fileFromDocumentDirectory(filename: filename)
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(posts)
            
            try data.write(to: url, options: .atomic)
        } catch {
            throw PersistanceError.savingError(error)
        }
    }
    
    static func load() throws {
        let url = PersistanceManager.shared.fileFromDocumentDirectory(filename: filename)
        
        let fileExists = FileManager.default.fileExists(atPath: url.path)
        
        if !fileExists {
            posts = []
            
            print("File D.N.E: \(url.path)")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let decoder = PropertyListDecoder()
            
            let loadPosts = try decoder.decode([Post].self, from: data)
            
            posts = loadPosts
            
        } catch {
            throw PersistanceError.loadingDataError(error)
        }
    }
    
    static func delete(id: Int) throws {
        
        posts.removeAll(where: {$0.id == id})
        
        do {
            try save(posts)
            
        } catch {
            throw PersistanceError.deletionError(error)
        }
    }
    
}
