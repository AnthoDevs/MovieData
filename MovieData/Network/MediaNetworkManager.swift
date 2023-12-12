//
//  MediaNetworkManager.swift
//  MovieData
//
//  Created by Anthony Santiago on 07/12/23.
//


///Questions:
///1.- ¿No afecta hacer en cada network una instancia de URLSession.shared?
///

import Foundation
import UIKit

class MediaNetworkManager {
    let urlSession = URLSession.shared

    func getImage(url: String, imagePath: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let imageUrl = URL(string: url.appending("original\(imagePath)")) else { return }
        let task = urlSession.dataTask(with: imageUrl) { (data, response, error) in
            if let error {
                completion(.failure(error))
            }
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            completion(.success(UIImage(data: data) ?? UIImage() ))
        }
        task.resume()
    }
}
