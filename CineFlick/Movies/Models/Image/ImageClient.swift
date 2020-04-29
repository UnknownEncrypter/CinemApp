//
//  ImageClient.swift
//  CineFlick
//
//  Created by Josiah Agosto on 9/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

class ImageClient: ImageAPIClient {
    let session: URLSession
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .ephemeral)
    }
    
    
    func createImage(from imageConfig: ImageConfiguration, completion: @escaping (Result<MovieImageJson?, APIError>) -> Void) {
        let endpoint = imageConfig
        let result = endpoint.request
        fetchImage(with: result, decode: { (json) -> MovieImageJson? in
            guard let imageModel = json as? MovieImageJson else { return nil }
            return imageModel
        }, completion: completion)
    }
}
