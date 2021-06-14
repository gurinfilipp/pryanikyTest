//
//  NetworkManager.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//

import Foundation
import UIKit

class NetworkManager {
    
    let shared = NetworkManager()
    
    private init() {}
    
    static func fetchData(url: String, completion: @escaping(_ data: GlobalJsonData) -> ()) {
        guard let url = URL(string: url) else { return }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { (data, _, error) in
            guard let data = data else  { return }
          
                do {
                    let json = try JSONDecoder().decode(GlobalJsonData.self, from: data)
                    
                    completion(json)
                    
                    
                } catch {
                    print(error)
                }
        }.resume()
    }
    
    
    static func fetchImage(url: String, completion: @escaping(UIImage)->()) {
        guard let imageURL = URL(string: url) else {return}
        guard let imageData = try? Data(contentsOf: imageURL) else {return}
        guard let image = UIImage(data: imageData) else { return }
        
        completion(image)
     }
    
}
