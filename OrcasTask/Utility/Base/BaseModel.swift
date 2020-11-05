//
//  BaseModel.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//

import UIKit
import ObjectMapper

typealias SuccessClosure = (Any?) -> Void
typealias FailureClosure = (Error?) -> Void

protocol ServiceDelegate: class {
    func didReceiveDataSuccessfully(data: Any?, identifier: String)
    func didFailToReceiveData(error: Error?, identifer: String)
}

class BaseModel: Mappable {

    //MARK: - Properties

    var delegate: ServiceDelegate?

    //MARK: - Initializers
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    convenience init(delegate : ServiceDelegate) {
        self.init()
        self.delegate = delegate
    }
    
    public func mapping(map: Map) {
        
    }
    
    
    //Mark: - Helpers
    
    func startApiRequest(withRequestConfiguration request: RequestConfiguraton , success: SuccessClosure?, failure: FailureClosure?) {
        NetworkManager.startRequest(withRequestConfiguration: request, andMappingObject: request.model, encoding: request.encoding, successClouser: { (model) in
            success?(model)
            self.delegate?.didReceiveDataSuccessfully(data: model, identifier: request.endpoint)
        }) { (error) in
            failure?(error)
            self.delegate?.didFailToReceiveData(error: error, identifer: request.endpoint)
        }
    }

}
