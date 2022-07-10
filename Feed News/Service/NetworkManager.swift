//
//  NetworkManager.swift
//  Feed News
//
//  Created by Olexsii Levchenko on 7/10/22.
//

import Foundation

class NetworkManager {
    
    static let shared   = NetworkManager()
    
    private init() { }
    
    func getPosts(completed: @escaping(Posts?, Error?) -> Void) {
        let url = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
        
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let posts = try decoder.decode(Posts.self, from: data)
                completed(posts, nil)
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completed(nil, jsonErr)
            }
        }
        task.resume()
    }
}
