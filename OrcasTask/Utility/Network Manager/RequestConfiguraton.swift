//
//  RequestConfiguraton.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//


import UIKit
import Alamofire
import MBProgressHUD

//MARK: - enumuration

enum RequestSource {
    case production
    case test
}


//MARK: - Custom data types

struct File {
    var url: URL, data: Data, image: UIImage, imageName: String, fileName: String
}

class RequestConfiguraton: NSObject {
    
    //MARK: - Properties
    
    var successClouser: NetworkSuccessClosure?
    var failureClouser: NetworkFailureClosure?
    
    var requestMethod: HTTPMethod
    #if DEBUG
    var source: RequestSource = .test
    #else
    var source: RequestSource = .production
    #endif
    var endpoint: String
    var encoding: ParameterEncoding = URLEncoding.httpBody
    var parameters: [String : Any]?
    var headers: [String : String]?
    var urlParameters: [String : String]?
    var model: BaseModel?
    var connectionMandatory: Bool
    var headerMandatory: Bool
    var files: [File]?
    var progressLoader: MBProgressHUD?
    var uiViewControll: UIViewController?
    
    var completeURL : String {
        var fullURL = ""
        switch source {
        case .production:
            fullURL = Constant.mainDomain
        case .test:
            fullURL = Constant.mainDomain
        }
        fullURL += endpoint
        
        return fullURL
        
    }
    
    //MARK: - Initiazlizers
    
    init(withRequest request: RequestConfiguraton) {
        self.requestMethod = request.requestMethod
        self.parameters = request.parameters
        self.encoding = request.encoding
        
        if request.headers?.isEmpty ?? true {
            self.headers = Constant.getHeader()
        }else {
            self.headers = request.headers
        }
        
        //        if UserdefualtsManager.GetUserObject().api_token != "" {
        //            self.headers?["Authorization"] = "Bearer \(UserdefualtsManager.GetUserObject().api_token)"
        //        }
        self.headers?["Accept"] = "application/json"
        
        self.endpoint =  request.endpoint
        self.model = request.model
        self.urlParameters = request.urlParameters
        self.source = request.source
        self.connectionMandatory = request.connectionMandatory
        self.headerMandatory = request.headerMandatory
    }
    
    init(withRequestMethod requestMethod: HTTPMethod,
         endpoint: String,
         encoding: ParameterEncoding,
         model: BaseModel,
         bodyParameters parameters: [String: Any]? = nil,
         headers: [String: String]? = nil,
         urlParameters: [String: String]? = nil,
         connectionMandatory: Bool = false,
         headerMandatory: Bool = false){
        
        self.requestMethod = requestMethod
        self.parameters = parameters
        self.encoding = encoding
        
        if headers == nil {
            let userDefaults = UserDefaults.standard
            if let AccessToken = userDefaults.object(forKey: "access_token") as? String  {
                self.headers = Constant.getHeader(accessToken: AccessToken)
            }else{
                self.headers = Constant.getHeader(accessToken: "")
            }
        }else {
            let userDefaults = UserDefaults.standard
            if let AccessToken = userDefaults.object(forKey: "access_token") as? String  {
                self.headers = Constant.getHeader(accessToken: AccessToken)
            }else{
                self.headers = Constant.getHeader(accessToken: "")
            }
        }
        
        //        if UserdefualtsManager.GetUserObject().api_token != "" {
        //            self.headers?["Authorization"] = "Bearer \(UserdefualtsManager.GetUserObject().api_token)"
        //        }
        
        self.headers?["Accept"] = "application/json"
        
        self.endpoint =  endpoint
        self.model = model
        self.urlParameters = urlParameters
        self.connectionMandatory = connectionMandatory
        self.headerMandatory = headerMandatory
    }
    
    
    //MARK: - helpingMethods
    
    class func createRequest(method: HTTPMethod,
                             endpoint: String,
                             encoding: ParameterEncoding,
                             model: BaseModel,
                             parameters: [String: Any]? = nil,
                             headers: [String: String]? = nil,
                             urlParameters: [String : String]? = nil) -> RequestConfiguraton {
        
        let request = RequestConfiguraton(withRequestMethod: method, endpoint: endpoint, encoding: encoding, model: model, bodyParameters: parameters, headers: headers, urlParameters: urlParameters)
        return request
    }
    
    class func uploadRequest(withConfiguration request: RequestConfiguraton, andFiles files: [File], progressLoader: MBProgressHUD, viewController: UIViewController) -> RequestConfiguraton {
        let request = RequestConfiguraton(withRequest: request)
        request.files = files
        request.progressLoader = progressLoader
        request.uiViewControll = viewController
        return request
    }
    
}


