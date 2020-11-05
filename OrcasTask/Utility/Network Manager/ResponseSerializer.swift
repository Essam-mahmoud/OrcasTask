//
//  ResponseSerializer.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//



import Foundation
import Alamofire


enum BackendError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
}

extension DataRequest {
    
    @discardableResult
    public func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (DataResponse<Any>) -> Void)
        -> Self {
            
            let responseSerializer = DataResponseSerializer<Any> { request, response, data, error in
                
                if error != nil {
                    return .failure(error!)
                }
                
                let jsonResponseSerializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
                
                let result = jsonResponseSerializer.serializeResponse(request, response, data, error)
                
                #if DEBUG
                print("🎯 Headers Response", response?.statusCode ?? "no status code found", ",EndPoint", response?.url?.lastPathComponent ?? "no EndPoint found", result.value ?? "no response body found")
                #endif
                
                if response?.statusCode == 401 {
                    return .failure(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ExpiredSession(mandatory: true)))
                }else if response?.statusCode == 404 {
                    return .failure(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ServerError))
                }else if response?.statusCode == 422 {
                    return .failure(MCError.BackendFaild(reason: "invalid data or can not proceed cause user input error".localizedString))
                }else if response?.statusCode == 500 {
                    return .failure(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ServerError))
                }
                
                //                else if response?.statusCode == 402 {
                //                    return .failure(MCError.BackendFaild(reason: "There is a problem with your request. Please try again‎".localizedString))
                //
                //                }else if response?.statusCode == 403 {
                //                    return .failure(MCError.BackendFaild(reason: "Request timed out".localizedString))
                //
                //                }else if response?.statusCode == 404 {
                //                    return .failure(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ServerError))
                //
                //                }else if response?.statusCode == 405 {
                //                    return .failure(MCError.BackendFaild(reason: "This account is not registered to us You can register".localizedString))
                //
                //                }else if response?.statusCode == 406 {
                //                    return .failure(MCError.BackendFaild(reason: "Password incorrect Please try again".localizedString))
                //
                //                }else if response?.statusCode == 407 {
                //                    return .failure(MCError.BackendFaild(reason: "This account is currently suspended Please contact the store management".localizedString))
                //
                //                }else if response?.statusCode == 409 {
                //                    return .failure(MCError.BackendFaild(reason: "The entered data already exists".localizedString))
                //                }
                
                if result.isSuccess {
                    if let responseObject = result.value as? [String: Any] { // responseObject
                        var messagesErr = ""
                        
                        let messageError = responseObject["Message"] as? [String]
                        let messageString = responseObject["Message"] as? String
                        
                        if messageError?.isEmpty ?? false || messageError?.isEmpty == nil {
                            messagesErr.append(messageString ?? "")
                            
                        }else {
                            messageError?.forEach({ (err) in
                                messagesErr.append(err + ", ")
                            })
                        }
                        
                        if (200..<300).contains(response?.statusCode ?? -1) {
                            return .success(responseObject)
                            //                        }
                            //
                            //                        if let dataObject = responseObject["data"] as? [String: Any] { // dataObject
                            //
                            //                            if (200..<300).contains(response?.statusCode ?? -1) {
                            //                                return .success(dataObject)
                            //                            }
                            //
                            //                            return .failure(MCError.BackendFaild(reason: messagesErr))
                            //
                            //                        } else if let dataArray = responseObject["data"] as? [[String: Any]] { // dataArray
                            //
                            //                            if (200..<300).contains(response?.statusCode ?? -1) {
                            //                                return .success(dataArray)
                            //                            }
                            //
                            //                            return .failure(MCError.BackendFaild(reason: messagesErr))
                            //
                        } else {
                            return .failure(MCError.BackendFaild(reason: messagesErr))
                        }
                        
                    } else if let responseArray = result.value as? [[String: Any]] { // responseArray
                        if (200..<300).contains(response?.statusCode ?? -1) {
                            return .success(responseArray)
                        }
                        
                        return .failure(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ServerError))
                    } else {
                        return .failure(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ServerError))
                    }
                }
                
                if let responseObject = result.value as? [String: Any] {
                    let messageError = responseObject["Message"] as? String
                    
                    return .failure(MCError.BackendFaild(reason: messageError ?? ""))
                }
                
                return .failure(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ServerError))
            }
            
            return response(
                queue: queue,
                responseSerializer: responseSerializer,
                completionHandler: completionHandler
            )
    }
    
}
