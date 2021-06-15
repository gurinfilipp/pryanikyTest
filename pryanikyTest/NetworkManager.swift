//
//  NetworkManager.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//

import Foundation
import UIKit
import Alamofire

class NetworkManager {
    
    let shared = NetworkManager()
    
    private init() {}
    
    static func fetchData(url: String, completion: @escaping(_ data: GlobalJsonData) -> ()) {
        let request = AF.request(url)
        request.responseDecodable(of: GlobalJsonData.self) { (response) in
            guard let data = response.value else { return }
            completion(data)
        }
    }
    
    static func fetchImage(url: String, completion: @escaping(UIImage)->()) {
        guard let imageURL = URL(string: url) else {return}
        guard let imageData = try? Data(contentsOf: imageURL) else {return}
        guard let image = UIImage(data: imageData) else { return }
        
        completion(image)
    }
    
}
