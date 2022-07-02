//
//  HttpMethod.swift
//  ConsultaCEP
//
//  Created by Renato F. dos Santos Jr on 24/05/22.
//

import Foundation

enum HTTPMethod: String {
    
    /// Defines the suported types of HTTP methods
    case post
    case put
    case get
    case delete
    case patch
    
    public var name: String {
        return rawValue.uppercased()
    }
    
}
