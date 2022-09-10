//
//  NetworkService.swift
//  REST API App
//
//  Created by Apple Macbook Pro 13 on 6.09.22.
//

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage

final class NetworkService {
    
    static func getData(url: URLConvertible, callback: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil).response { response in
            var dataValue: Data?
            var err: Error?
            
            switch response.result {
                case .success(let data):
                    dataValue = data
                case .failure(let error):
                    err = error
            }
            callback(dataValue, err)
        }
    }
    static func postData(url: URLConvertible, parameters: Parameters, callback: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: nil).response { response in
            var dataValue: Data?
            var err: Error?
            
            switch response.result {
                case .success(let data):
                    dataValue = data
                case .failure(let error):
                    err = error
            }
            callback(dataValue, err)
        }
    }

    static func removeData(url: URLConvertible, callback: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        AF.request(url,
                   method: .delete,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil).response { response in
            var dataValue: Data?
            var err: Error?

            switch response.result {
                case .success(let data):
                    dataValue = data
                case .failure(let error):
                    err = error
            }
            callback(dataValue, err)
        }
    }

    static func getImageData(url: URLConvertible, callback: @escaping (_ result: AFDataResponse<Image>) -> Void) {
        AF.request(url).responseImage { response in
            callback(response)
        }
    }
}
