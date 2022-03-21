//
//  BaseResponse.swift
//  MeLi Market
//
//  Created by Ludin Jozabeth on 14-03-22.
//

import UIKit
import Foundation

/// Clase base para parsear respuestas de servicio
class BaseResponse: AnyObject {
    var siteId: String?
    var countryDefaultTimeZone: String?
    var query: AnyObject?
    var result: AnyObject?

    init() { }

    init(_ decoder: JSONDecoder, result: AnyObject) {
        
    }

    required init(_ decoder: JSONDecoder) {
        
    }

}
