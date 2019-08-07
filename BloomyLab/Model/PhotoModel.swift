//
//  PhotoModel.swift
//  BloomyLab
//
//  Created by md760 on 8/6/19.
//  Copyright © 2019 md760. All rights reserved.
//

import Foundation

struct SearchedPhoto: Decodable {
    let photos: [ImageModel]?
    
    enum CodingKeys: String, CodingKey {
        case photos
    }
    
    static func getImageBy(name: String, completion: @escaping ((_ model: SearchedPhoto?) -> Void)) {
        
        let randomNumber = Int.random(in: 1...1000) //get random page in search result
        let link = "https://api.pexels.com/v1/search?query=\(name)+query&per_page=1&page=\(randomNumber)"
        guard let url = URL(string: link) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.setValue("563492ad6f91700001000001e013e517360f420d9691132d2985189e", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil,
                let data = data else { completion(nil)
                    return
            }
            let decoder = JSONDecoder()
            let model = try? decoder.decode(SearchedPhoto.self, from: data)
            completion(model)
        })
        task.resume()
    }
}

struct ImageModel: Decodable {
    let imageSize: ImageSize?
    
    enum CodingKeys: String, CodingKey {
        case imageSize = "src"
    }
}

struct ImageSize: Decodable {
    let landscape: String?
}
