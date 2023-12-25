//
//  ApiClient.swift
//  MovieApp
//
//  Created by ömer atmaca on 17.09.2023.
//

import Foundation
import Alamofire

class APIClient {
    private static func handle<T: Codable>(response: AFDataResponse<Data>, completion: @escaping (AFResult<T>) -> Void) {
        if let data = response.data {
            Log.info("➡️➡️➡️➡️------------ RESPONSE -----------")
            let str = data.prettyPrintedJSONString
            Log.error(((str ?? "UNDEFINED") as String))
        }
        switch response.result {
        case .success(let data):
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(model))
            } catch {
                Log.error("🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️------------ ERROR -----------")
                Log.error("\(error)")
                completion(Result.failure(RequestError.decode.asAFError(orFailWith: "")))
            }

        case .failure(let error):
            if let data = response.data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
                    //TODO iOS dev arkadaşlarım, lütfen buradaki deserializationu doğru pratikler ile düzeltin uygun bir zamanda, ben düz usül vakit kaybetmemek adına json parse ettim
                    let message = ((json?["meta"] as? [String:AnyObject])?["error"] as? [String:AnyObject])!["message"] as! String
                    let newError = NSError(domain:"", code: 400, userInfo:[ NSLocalizedDescriptionKey: message])
                    completion(Result.failure(newError.asAFError(orFailWith: "")))
                } catch {
                    Log.error("🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️------------ ERROR -----------")
                    Log.error("\(error)")
                    completion(Result.failure(error.asAFError(orFailWith: "")))
                }
                completion(Result.failure(error))
            } else {
                let networkError = RequestError.noResponse
                completion(Result.failure(networkError.asAFError(orFailWith: "")))
            }
        }
    }
    
    
    static func request<T: Codable>(route: APIRouter,
                                    completion: @escaping (AFResult<T>) -> Void) {
        AF.request(route).validate().responseData { response in
            handle(response: response, completion: completion)
        }
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
