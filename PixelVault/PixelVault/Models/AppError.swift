//
//  AppError.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-17.
//

import Foundation

enum AppError: Error {
    case noResponse
    case badStatusCode(String)
}
