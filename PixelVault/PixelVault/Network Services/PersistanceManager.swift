//
//  PersistanceManager.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-19.
//

import Foundation

class PersistanceManager {
    
    static let shared = PersistanceManager()
    
    private init () {}
    
    func documentDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func fileFromDocumentDirectory(filename: String) -> URL {
        documentDirectory().appending(path: filename)
    }
}
