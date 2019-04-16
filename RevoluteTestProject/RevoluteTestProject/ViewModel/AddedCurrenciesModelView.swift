//
//  AddedCurrenciesModelView.swift
//  RevoluteTestProject
//

import Foundation


class AddedCurrenciesModelView {
    
    var didSelectCurrency: ((AddedCurrencyContry) -> Void)?
    var didUpdate: ((AddedCurrenciesModelView) -> Void)?

    var addedcurrencyList:NSDictionary = [:]


    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }

    private(set) var addedCurrenciesModelView = [CellRepresentable]()
    let addedCurrenciesModelViewTypes: [CellRepresentable.Type] = [AddedCurrencyTableViewCellModel.self]

    func reloadData() {
        self.isUpdating = true
        let currencyAddedList = initAddedCurrencyValues()

        currencyAddedList.forEach() {
            self.addedCurrenciesModelView.append(self.viewModelFor(currency: $0))
        }
        self.isUpdating = false
    }
    
    func initAddedCurrencyValues() -> [AddedCurrencyContry] {
        
        var lisOfCurrencyContry = [AddedCurrencyContry]()
        
        
        let countryShortNames = ["AUD","BGN","BRL","CAD","CHF","CNY","CZK","DKK","EUR","GBP","HKD","HRK","HUF","IDR","ILS","INR","ISK","JPY","KRW","MXN","MYR","NOK","NZD","PHP","PLN","RON","RUB","SEK","SGD","THB","USD","ZAR"]

        let countryfullNames = ["Australian Dollar","Bulgarian Lev","Brazilian Real","Canadian Dollar","Swiss Franc","Chinese Yuan","Czech Republic ","Danish Krone","Euro","British Pound","Hong Kong","Croatian Kuna","Hungarian Forint","Indonesian Rupiah","Israeli New Sheqel","Indian Rupee","Icelandic Króna","Japanese Yen","South Korean Won","Mexican Peso","Malaysian Ringgit","Norwegian Krone","Swedish Krona","Philippine Peso","Polish Zloty","Romanian Leu","Russian Ruble","Swedish Krona","Singapore Dollar","Thai Baht","US Dollar","South African Rand"]

        let keys = addedcurrencyList.allKeys
        let splitString = keys[0] as! String
        
        let fullNameArr                     = splitString.components(separatedBy: "/")
        let indexOffFirstPair              = countryShortNames.index(of: fullNameArr[1])
        let indexOffSecondPair              = countryShortNames.index(of: fullNameArr[0])

        let secondPairDescription           = countryfullNames [indexOffSecondPair!]
        
        
        let  pairTileTextValueDescription   = countryfullNames[indexOffFirstPair!]
        let  pairTileTextValue              = "1 " + fullNameArr[1]
        let  values                         = Array(addedcurrencyList.allValues)
        let  secondPairTitle                = values.first as! NSNumber
        let  secondPairTitleDescription     = secondPairDescription + "."  + fullNameArr[0]

        
        
        let addedCurrency = AddedCurrencyContry(countryShortName:pairTileTextValueDescription,
                                                countryFullName :pairTileTextValue,
                                                countryShortNameTitle:(secondPairTitle.stringValue) ,
                                                countryShortNameDescription:secondPairTitleDescription)
        lisOfCurrencyContry.append(addedCurrency)

        return lisOfCurrencyContry
    }



    private func viewModelFor(currency: AddedCurrencyContry) -> CellRepresentable {
        let viewModel = AddedCurrencyTableViewCellModel(currency: currency)
        viewModel.didSelectCurrency = { [weak self] currency in
            self?.didSelectCurrency!(currency)
        }
        return viewModel
    }


}
