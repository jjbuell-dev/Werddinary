//
// NetworkManager.swift
// Werddinary
//


import UIKit

class NetworkManager {
    
    // MARK: - Properties
    
//    static let sharedInstance = NetworkManager()
    
    static let baseURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions")
    
    // MARK: - Fetch Functions
    
    static func fetchRandomWord(completion: @escaping (Result<Word, ErrorManager>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        let headers = [
            "x-rapidapi-key": Constants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                return completion(.failure(.thrownError(error)))
//            }
//            if let response = response as? HTTPURLResponse {
//                print("STATUS CODE: \(response.statusCode)")
//            }
            guard let data = data, error == nil else {
                return completion(.failure(ErrorManager.noData))
            }
            
            do {
                let randomWord = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(randomWord))
                
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchWordWithDetails(_ word: String, completion: @escaping(Result<Word, ErrorManager>) -> Void) {
        guard let fetchWordDetailURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(word)") else { return completion(.failure(.invalidURL)) }
        
        let headers = [
            "x-rapidapi-key": Constants.apiKey,
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: fetchWordDetailURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                return completion(.failure(.thrownError(error)))
//            }
//            if let response = response as? HTTPURLResponse {
//                print("STATUS CODE: \(response.statusCode)")
//            }
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            do {
                let randomWord = try JSONDecoder().decode(Word.self, from: data)
                completion(.success(randomWord))
                
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
}
