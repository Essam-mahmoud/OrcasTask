//
//  NetworkManager.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//


import UIKit
import Alamofire
import ObjectMapper
import MBProgressHUD

typealias NetworkSuccessClosure = (BaseModel?) -> Void
typealias NetworkFailureClosure = (Error?) -> Void

class NetworkManager: NSObject {
    
    class func startRequest<T: BaseModel>(withRequestConfiguration request: RequestConfiguraton, andMappingObject objectClass: T?, encoding: ParameterEncoding = URLEncoding.httpBody, successClouser success: NetworkSuccessClosure?, andFailure failure: NetworkFailureClosure?) {
        
        if !serverReachable(forUrl: request.completeURL) {
            failure?(MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.NoInternet(mandatory: request.connectionMandatory)))
            request.failureClouser = failure
            request.successClouser = success
            
            if !LastRequest.request.lastRequests.contains(request) {
                LastRequest.request.lastRequests.append(request)
                
                reachabilityListener(forUrl: request.completeURL) {
                    restartRequest()
                }
            }
            
            #if DEBUG
            print("☠️", "No internet")
            #endif
    
            return
        }
        
        
        #if DEBUG
        print("🚀", request.requestMethod.rawValue, request.completeURL,request.headers ?? "" , "🔑" , request.parameters?.toString() ?? "")
        #endif
        
        let responseHandler = { (response: DataResponse<Any>) in
            switch response.result {
            case .success(_):
                if let data = response.result.value {
                    print("🎯 \(data)")
                    let model: BaseModel?
                    if let object = objectClass {
                        model = Mapper<T>().map(JSONObject: data, toObject: object)
                    } else {
                        model = Mapper<T>().map(JSONObject: data)
                    }
                    success?(model)
                    
                    // Remove LastRequest
                    if LastRequest.request.lastRequests.count > 0 {
                        if let requestIndex = LastRequest.request.lastRequests.firstIndex(of: request) {
                            LastRequest.request.lastRequests.remove(at: requestIndex)
                        }
                    }
                    
                    // Remove ExpiredRequest
                    if ExpiredRequest.request.expiredRequest.count > 0 {
                        if let requestIndex = ExpiredRequest.request.expiredRequest.firstIndex(of: request) {
                            ExpiredRequest.request.expiredRequest.remove(at: requestIndex)
                        }
                    }

                }
                break
            case .failure(_):

                if response.response?.statusCode == 401 { // invalid access Token Header
                    request.failureClouser = failure
                    request.successClouser = success

                    if !ExpiredRequest.request.expiredRequest.contains(request) {
                        ExpiredRequest.request.expiredRequest.append(request)
                        #if DEBUG
                        print("💣 Expired Session", request.requestMethod.rawValue, request.completeURL)
                        #endif
                    }
                }

                print("❌", response.result.error ?? "")
                failure?(response.result.error)

                break
            }
        }
        
        
        if let files = request.files {
            Alamofire.upload(multipartFormData: { multipartFormData in
                files.forEach {
                    print("files \(files)")
                    multipartFormData.append($0.data, withName: "file", fileName: $0.imageName, mimeType: "image/png")
                }
            }, to: request.completeURL, method: request.requestMethod, headers: request.headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress { progress in
                        request.progressLoader?.progress = Float(progress.fractionCompleted)
                    }
                    upload.validate().responseJSON { response in
                        responseHandler(response)
                    }
                    
                    break
                case .failure(let encodingError):
                    failure?(encodingError)
                    break
                }
            })
        } else {
            
            removeAllCachedResponses()
            Alamofire.request(request.completeURL, method: request.requestMethod, parameters: request.parameters, encoding: encoding, headers: request.headers).responseJSON { (response: DataResponse<Any>) in
                
                responseHandler(response)
            }
        }
        
    }
    
    
    class func restartRequest() {
        
        for request in LastRequest.request.lastRequests {
            #if DEBUG
            print("♻️", request.requestMethod.rawValue, request.completeURL)
            #endif
            self.startRequest(withRequestConfiguration: request, andMappingObject: request.model, successClouser: request.successClouser, andFailure: request.failureClouser!)
        }
    }
    
    class func restartExpiredRequest() {
        
        for request in ExpiredRequest.request.expiredRequest {
            #if DEBUG
            print("♻️", request.requestMethod.rawValue, request.completeURL)
            #endif
            
//            request.headers = Constant.accessTokenHeader
            self.startRequest(withRequestConfiguration: request, andMappingObject: request.model, successClouser: request.successClouser, andFailure: request.failureClouser!)
        }
    }
    
    class func serverReachable(forUrl url: String) -> Bool {
        return NetworkReachabilityManager(host: url)!.isReachable
    }
    
    class func reachabilityListener(forUrl url: String, connectionHandler: @escaping () -> Void) {
        guard let reachabilityManager = NetworkReachabilityManager(host: url) else { return }
        reachabilityManager.listener = { status in
            if NetworkManager.serverReachable(forUrl: url) {
                reachabilityManager.stopListening()
                connectionHandler()
            }
        }
        reachabilityManager.startListening()
    }
    
    class func removeAllCachedResponses() {
        URLCache.shared.removeAllCachedResponses()
    }
}
