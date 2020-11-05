//
//  ErrorHandler.swift
//  glamera
//
//  Created by Kerolos Fahem on 13/02/19.
//  Copyright © 2018 Kerolos Fahem. All rights reserved.
//


import UIKit

enum ErrorType {
    case ErrorTypeBlocking
    case ErrorTypePopup
    case ErrorTypeNotHandled
    case ErrorTypeServer
    case ExpiredSession
    case UnderMaintenance
    case phoneNotVerified

}

enum MCError: Error {
    
    case NetworkFaild(reason: NetworkFaildReasons)
    case BackendFaild(reason: String)
    case Outdated
    case underMaintenance
    case phoneNotVerified

    public enum NetworkFaildReasons {
        case NotSuccess(code: Int)
        case Unknown
        case NoInternet(mandatory: Bool)
        case DefaultError
        case TimeOutError
        case ServerError
        case ExpiredSession(mandatory: Bool)
    }
    
    var type : ErrorType {
        switch self {
        case .NetworkFaild(let reason):
            switch reason {
            case .Unknown:
                return ErrorType.ErrorTypeBlocking
            case .ServerError:
                return ErrorType.ErrorTypeServer
            default:
                return ErrorType.ErrorTypeBlocking
            }
        case .BackendFaild(_):
            return ErrorType.ErrorTypeServer
        case .Outdated:
            return ErrorType.ErrorTypeBlocking
        case .underMaintenance:
            return ErrorType.UnderMaintenance
            
        case .phoneNotVerified:
            return ErrorType.phoneNotVerified

            
        }
    }
}

extension MCError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .BackendFaild(let reason):
            return reason
        case .NetworkFaild(let reason):
            return reason.localizedDescription
        case .Outdated:
            return MCError.Outdated.localizedDescription
        case .underMaintenance:
            return MCError.underMaintenance.localizedDescription
            
        case .phoneNotVerified:
            return MCError.phoneNotVerified.localizedDescription

        }
    }
}

extension MCError {
    var localizedDescription: String {
        switch self {
        case .BackendFaild(let reason):
            return reason
        case .NetworkFaild(let reason):
            return reason.localizedDescription
        case .Outdated:
            return "Old Version. You must update inorder to continue useing Googar"
        case .underMaintenance:
            return "Server under maintenance"
        case .phoneNotVerified:
            return "Phone not verified"

        }
    }
}

extension MCError.NetworkFaildReasons {
    var localizedDescription: String {
        switch self {
        case .NotSuccess(code: let code):
            return HTTPURLResponse.localizedString(forStatusCode: code)
        case .Unknown:
            return "Unknown error occurred"
        case .NoInternet(let mandatory):
            return "No Internet access\(mandatory ? ", this is mandatory" : "")"
        case .TimeOutError:
            return "slow internet connection"
        case .DefaultError:
            return "error default"
        case .ServerError:
            return "Error connecting to server, please try again or page not found"
        case .ExpiredSession(let mandatory):
            return "Unauthorized,\(mandatory ? ", Session Expired, You have to try again" : "")"
        }
    }
}
