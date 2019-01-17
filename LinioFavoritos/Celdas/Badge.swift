//
//  Badge.swift
//  LinioFavoritos
//
//  Created by Jorge Mendizabal on 1/17/19.
//  Copyright © 2019 Jorge Mendizabal. All rights reserved.
//

import UIKit

enum Badge {
    
    case plusLevel1
    case plusLevel2
    case refurbished
    case nuevo
    case importado
    case freeShipping
    
    var imagen: UIImage {
        switch self {
        case .plusLevel1:
            return UIImage(named: "ndIc30PlusSquare")!
        case .plusLevel2:
            return UIImage(named: "ndIc30Plus48Square")!
        case .refurbished:
            return UIImage(named: "ndIc30RefurbishedSquare")!
        case .nuevo:
            return UIImage(named: "ndIc30NewSquare")!
        case .importado:
            return UIImage(named: "ndIc30InternationalSquare")!
        case .freeShipping:
            return UIImage(named: "ndIc30FreeShippingSquare")!
        }
    }
    
    static func cargarBadges(producto: NSDictionary) -> [Badge] {
        var badges: [Badge] = []
        if let level = producto.value(forKey: "linioPlusLevel") as? Int, level > 0 {
            if level == 1 {
                badges.append(.plusLevel1)
            } else {
                badges.append(.plusLevel2)
            }
        }
        
        if let condicion = producto.value(forKey: "conditionType") as? String {
            if condicion == "new" {
                badges.append(.nuevo)
            } else {
                badges.append(.refurbished)
            }
        }
        
        if let envioGratis = producto.value(forKey: "freeShipping") as? Bool, envioGratis {
            badges.append(.freeShipping)
        }
        
        if let importado = producto.value(forKey: "imported") as? Bool, importado {
            badges.append(.importado)
        }
        
        return badges
    }
    
}
