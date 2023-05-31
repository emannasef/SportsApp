//
//  APIFetchProtocol.swift
//  Sports
//
//  Created by Mac on 19/05/2023.
//

import Foundation

protocol APIFetchProtocol {
    
    func fetchData<T:Codable>(url:String,complition : @escaping (T?,Error?) -> () )
    
}
