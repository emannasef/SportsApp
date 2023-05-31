//
//  APIFetchHandler.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation
import Alamofire

class APIFetch : APIFetchProtocol{
    
    func fetchData<T:Codable>(url:String,complition : @escaping (T?,Error?) -> () ){
        
      //  print("CallingURL",url)
        
                AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).response { response in
                    switch response.result{
                    case .success(let data):
                      do{
                          let jsonData = try JSONDecoder().decode(T.self, from: data!)
                          complition(jsonData,nil)
                       //   debugPrint(jsonData)
                     } catch {
                        print(error.localizedDescription)
                     }
                   case .failure(let error):
                     print(error.localizedDescription)
                      complition(nil,error)
                    }
                }
        
    }

    
}
