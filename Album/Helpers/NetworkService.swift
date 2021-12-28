//
//  NetworkService.swift
//  Album
//
//  Created by Shereen on 24/11/20.
//

import Foundation
import Alamofire


public class NetworkService {

    static func makeApicall(handler: @escaping (_ userDetails: [User], _ error: Error?) -> Void) {
        let url = "https://reqres.in/api/users?"
        
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
        
        request.responseDecodable(completionHandler: { (response: DataResponse<UserDetails, AFError>) in

            switch response.result {
            case .success(let userDetails):
                handler(userDetails.data,nil)
            case .failure(let error):
                print("Error:: \(error)")
                handler([],error)
            }
        })
       
    }
}
