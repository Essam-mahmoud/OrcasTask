//
//  HttpController.swift
//  AshakAlena
//
//  Created by Mohammad Farhan on 22/12/177/25/17.
//  Copyright © 2017 Mohammad Farhan. All rights reserved.
//

import Foundation
import Alamofire
protocol HttpHelperDelegate {
    func receivedResponse(dictResponse:Any,Tag:Int)
    func receivedErrorWithStatusCode(message:String)
}

class HttpHelper {
    
    var delegate: HttpHelperDelegate?
    
    public func requestWith(endUrl: String, imageData: [UIImage], parameters: [String : Any], tag: Int){
        
        let headers:
            HTTPHeaders = [
                "Content-type": "multipart/form-data"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
            }
            
            for image in imageData{
                if  let imageData = image.jpegData(compressionQuality: 0.5){
                    multipartFormData.append(imageData, withName: "images", fileName:"image.png", mimeType: "image/png")
                }
            }
            
        }, usingThreshold: UInt64.init(), to: endUrl, method: .post, headers: headers) { (result) in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let JSON = response.result.value {
                        self.delegate?.receivedResponse(dictResponse: JSON,Tag: tag)
                    }
                    print("Succesfully uploaded")
                    
                }
            case .failure(let error):
                self.delegate?.receivedErrorWithStatusCode(message: error.localizedDescription)
                print("Error in upload: \(error.localizedDescription)")
            }
        }
    }
}

