//
//  IImageDownloader.swift
//  ServiceFramework
//
//  Created by Marcin Makurat on 17/05/2021.
//

import Alamofire
import AlamofireImage

protocol IImageDownloader {
    func retriveImage(url: String, completion: @escaping (Result<Data?, UserError>) -> Void)
}
