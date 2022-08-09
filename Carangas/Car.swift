//
//  Cars.swift
//  Carangas
//
//  Created by Juliano Costa Silva on 08/08/22.
//

import Foundation

class Car: Codable {
    var _id: String?
    var brand: String = ""
    var name: String = ""
    var price: Int = 0
    var gasType: Int = 0
    
    var fuel: String {
        switch gasType {
        case 0:
            return "Flex"
        case 1:
            return "Alcohol"
        case 2:
            return "Petrol"
        case 3:
            return "Diesel"
        default:
            return "Eletricity"
        }
    }
}
