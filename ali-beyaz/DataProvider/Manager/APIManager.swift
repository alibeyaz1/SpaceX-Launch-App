//
//  APIManager.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 28.11.2023.
//

import UIKit
import Alamofire

class APIManager {
    
    static let shared = APIManager()

    private init() {}

    private let baseURL = "https://api.spacexdata.com/v5"

    func fetchUpcomingLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        let url = "\(baseURL)/launches/upcoming"
        fetchData(from: url, completion: completion)
    }

    func fetchPastLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        let url = "\(baseURL)/launches/past"
        fetchData(from: url, completion: completion)
    }

    private func fetchData<T: Decodable>(from endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(endpoint).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}
