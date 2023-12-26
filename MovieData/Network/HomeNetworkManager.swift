//
//  NetworkManager.swift
//  MovieData
//
//  Created by Anthony Santiago on 14/11/23.
//

import Foundation

struct HomeNetworkManager {
    let headers = [
      "accept": "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjdlNWFhODgyZTE4YjcxMzdiMWQ3YWExMWRhNDg5YSIsInN1YiI6IjY1NDkzNTNjNDFhNTYxMzM2YTIzOWE3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.2eS57Kv8a3B3dR883ye0qvK8P8nlJngBdrBzdMB4-eM"
    ]

    let request = NSMutableURLRequest(url: NSURL(string: "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                        timeoutInterval: 10.0)
    
    func requestHomeData(completion: @escaping (Result<HomeModel, Error>) -> Void) {
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                completion(.failure(error!))
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(HomeModel.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        })
        dataTask.resume()
    }
}
enum NetworkError: Error {
    case noData
    case decodingError
}
