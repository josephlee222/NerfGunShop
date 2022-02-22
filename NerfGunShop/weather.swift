//
//  weather.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 22/2/22.
//

import Foundation


struct weather:Codable {
    let weather: [resultsArray]
    struct resultsArray: Codable {
        let main: String?
        let id:Int?
        let description:String?
    }
}
