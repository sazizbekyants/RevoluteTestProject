//
//  Mocks.swift
//  RevoluteTestProject
//
//  Created by Sergo Azizbekyants on 4/17/19.
//  Copyright © 2019 Sergo Azizbekyants. All rights reserved.
//

import Foundation
@testable import RevoluteTestProject

//The mocks here are not required for the test so we only need them to satisfy the compiler
class MockNetwork: Client {
    func makeRequest()  {
        var currencyClientList :JSONArray<Currency>? = nil
        let currencyClient = Client.CurrencyAPIClient()
        currencyClient.baseUrl = URL(string: "")!
        currencyClient.CurrencyWithName (param: "USDGBP") {  resulte in
            currencyClientList = resulte.res!
            for user in (currencyClientList?.array)! {
//                print(user.key)
//                print(user.value)
            }
            if(!(resulte.error != nil)) {
//                XCTAssertEqual(currencyClient.baseUrl,"https://europe-west1-revolut-230009.cloudfunctions.net")
            }
        }
    }
}
