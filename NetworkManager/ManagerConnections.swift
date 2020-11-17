//
//  ManagerConnections.swift
//  Films
//
//  Created by Ezequiel Parada Beltran on 10/11/2020.
//

import Foundation
import RxSwift

class ManagerConnections {
    
    
    func getPopularMovies() -> Observable<[Movie]>{
        
        return Observable.create { observer in
            
            
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main+Constants.EndPoints.urlListPopularMobies+"?api_key="+Constants.apiKey)!)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response else {
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    print("Invalid response")
                    return
                }
                
                do{
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode(Movies.self, from: data)
                    
                    observer.onNext(movies.listOfMovies)
                    
                } catch let error {
                    observer.onError(error)
                    print("Error decoding data")
                }
                
                observer.onCompleted()
                
            }.resume()
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
//    func getDetailMovies() -> Observable<[Movie]>{
//        
//    }
}
