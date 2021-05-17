//
//  AFImageDownloader.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire

struct AFImageDownloader: IImageDownloader {
    func retriveImage(url: String, completion: @escaping (Result<Data?, UserError>) -> Void) {
        downloadImage(url: url) { result in
            completion(result)
        }
    }
    
    func downloadImage(url: String, completion: @escaping (Result<Data?, UserError>) -> Void) {
        AF.request(url, method: .get).responseImage { response in
            if let data = response.data {
                completion(.success(data))
            } else if let error = response.error {
                completion(.failure(UserError(description: error.errorDescription ?? "Unknown error")))
            } else {
                completion(.success(nil))
            }
        }
    }
}
