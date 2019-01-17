//
//  Service.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/17/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionLinio = (DataResponse<Any>) -> Void

enum Services {
    case favoritos
    
    var url: String {
        switch self {
        case .favoritos:
            return "https://gist.githubusercontent.com/egteja/98ad43f47d40b0868d8a954385b5f83a/raw/5c00958f81f81d6ba0bb1b1469c905270e8cdfed/wishlist.json"
        }
    }
    
    func load(completion: @escaping CompletionLinio) {
        Alamofire.request(self.url).responseJSON(completionHandler: completion)
    }
}
