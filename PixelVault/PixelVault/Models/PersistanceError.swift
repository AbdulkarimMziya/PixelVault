//
//  PersistanceError.swift
//  PixelVault
//
//  Created by Abdulkarim Mziya on 2026-03-19.
//

import Foundation

enum PersistanceError: Error {
    case savingError(Error)
    case loadingDataError(Error)
    case deletionError(Error)
}
