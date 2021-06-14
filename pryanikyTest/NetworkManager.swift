//
//  NetworkManager.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//

import Foundation

class NetworkManager {
    
    let shared = NetworkManager()
    
    private init() {}
    
    static func fetchData(url: String, completion: @escaping(_ data: [GlobalData]) -> ()) {
        
        
        guard let url = URL(string: url) else { return }
        let urlSession = URLSession.shared
        urlSession.dataTask(with: url) { (data, _, error) in
            guard let data = data else  { return }
          
                do {
                    let json = try JSONDecoder().decode(GlobalJsonData.self, from: data)
                    //self.data = json.data
                    completion(json.data)
                    //
                    
                    
                } catch {
                    print(error)
                }
        }.resume()
    }
}
