//
//  ModelCreatorHelper.swift
//  MeLi MarketTests
//
//  Created by Ludin Jozabeth on 14-03-22.
//

import Foundation

class ModelCreatorHelper {
    static func createMockGetItemsResponse() -> [Result] {
        let src = Bundle.main.url(forResource: "mockMeLi", withExtension: "json")!
        let data = try! Data(contentsOf: src)
        let resp = Utils().parse(jsonData: data)
        return resp!
    }
}
