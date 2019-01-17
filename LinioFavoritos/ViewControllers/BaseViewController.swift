//
//  BaseViewController.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/17/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import UIKit
import Alamofire

class BaseViewController: UIViewController {
    
    func manageResponse(response: DataResponse<Any>) {
        guard let value = response.value as? [NSDictionary] else { return }
        self.manageData(data: value)
    }
    
    func manageData(data: Any) {
        print("override this method")
    }
    
}

