//
// ErrorManager.swift
// Werddinary
//


import Foundation


enum ErrorManager: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach Web Server"
            
        case .thrownError(let error ):
            print(error.localizedDescription)
            return "That word cannot be found"
            
        case .noData:
            return "The server responded with no data"
            
        case .unableToDecode:
            return " The server responded with bad data.  Blame the back-end team, not the front-end."
        }
    }
}
