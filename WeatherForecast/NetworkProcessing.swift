//
//  NetworkProcessing.swift
//  WeatherForecast
//
//  Created by Muhammad Noor on 05/10/2017.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import Foundation

public let DANetworkingErrorDomain = "\(Bundle.main.bundleIdentifier!).NetworkingError"
public let MissingHTTPResponseError: Int = 10
public let UnexpectedResponseError: Int = 20

class NetworkProcessing {
    var request: URLRequest
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    init(request: URLRequest) {
        self.request = request
    }
    
    typealias JSON = [String: Any]
    typealias JSONHandler = (JSON?, HTTPURLResponse?, Error?) -> Void
    typealias JSONDictionaryHandler = ([String: Any]?) -> Void
    typealias DataHandler = (Data?, HTTPURLResponse?, Error?) -> Void
    
    func downloadJSON(completion: @escaping JSONDictionaryHandler) {
        self.request.httpMethod = "GET"
        let dataTask = session.dataTask(with: self.request) { (data, response, error) in
            // OFF THE MAIN THREAD
            // ERROR: missing http response
            guard let httpResponse = response as? HTTPURLResponse else {
                let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
                let error = NSError(domain: DANetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
//                completion(nil, nil, error)
                return
            }
            
//            if data == nil {
//                if let error = error {
//                    completion(nil, httpResponse, error)
//                }
//            } else {
//                switch httpResponse.statusCode {
//                case 200:
//                    do {
//                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
//                        completion(json, httpResponse, nil)
//                    } catch let error as NSError {
//                        completion(nil, httpResponse, error)
//                    }
//                default:
//                    print("Received HTTP response code \(httpResponse.statusCode) - was not handled in NetworkProcessing.swift")
//                }
//            }
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        
                        if let d = data {
                            do{
                                let jsonDictionary = try JSONSerialization.jsonObject(with: d, options: .mutableContainers)
                                
                                completion(jsonDictionary as? [String : Any])
//                                completion(jsonDictionary as! NetworkProcessing.JSON, httpResponse, nil)
                                
                            } catch let error as NSError {
                                print("JSON Error: \(error.localizedDescription)")
//                                completion(nil, httpResponse, error)
                            }
                        }
                        
                    default :
                        print("StatusCode: \(httpResponse.statusCode)")
                    }
                    
                }
            } else {
                print("Error: \(String(describing: error?.localizedDescription))")
            }

        }
        dataTask.resume()
    }
}
