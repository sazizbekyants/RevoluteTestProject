//
//  CurrenciesListModelView.swift
//  RevoluteTestProject
//

import Foundation

class CurrenciesListModelView {
    
    var didSelectCurrency: ((CurrencyContry) -> Void)?
    var didUpdate: ((CurrenciesListModelView) -> Void)?
    var isDetailViewController:Bool
    var disabledCellsArray:NSDictionary = [:]
    
    init?(isDetailViewController: Bool, disabledCellsArray:NSDictionary) {
        self.isDetailViewController = isDetailViewController
        self.disabledCellsArray     = disabledCellsArray
    }

    private(set) var currencyViewModels = [CellRepresentable]()
    let currencyViewModelsTypes: [CellRepresentable.Type] = [CurrencyCellViewModel.self]

    
    private func checkIfCurrencyInDisableMode(currency:CurrencyContry) -> Bool {
        
        let checkedcurrencyName = currency.countryShortName
        for item  in self.disabledCellsArray {
            let keyString = item.key as! String
            let arrayOfCountryCodes = keyString.split(separator: "/")
            if(checkedcurrencyName  == String(arrayOfCountryCodes[0])) {
                    return true
            }
        }
        return false
    }
    
    //MARK: - Helpers
    private func viewModelFor(currency: CurrencyContry) -> CellRepresentable {
        let viewModel:CurrencyCellViewModel

        if(isDetailViewController && disabledCellsArray.count > 0) {
             viewModel = CurrencyCellViewModel(currency: currency,
                                               isDisabled: checkIfCurrencyInDisableMode(currency: currency))
        } else {
             viewModel = CurrencyCellViewModel(currency: currency, isDisabled: false)
        }
        viewModel.didSelectCurrency = { [weak self] currency in
            print(self!.isDetailViewController)
            self?.didSelectCurrency!(currency)
        }
        return viewModel
    }
    private(set) var isUpdating: Bool = false {
        didSet { self.didUpdate?(self) }
    }

    //MARK: - Actions
    func reloadData() {
        self.isUpdating = true
        let currencyList = initMockValues()
        currencyList.forEach() {
            self.currencyViewModels.append(self.viewModelFor(currency: $0))
        }
        self.isUpdating = false
    }

    func initMockValues() -> [CurrencyContry] {
        var lisOfCurrencyContry = [CurrencyContry]()

        let countryShortNames = ["AUD","BGN","BRL","CAD","CHF","CNY","CZK","DKK","EUR","GBP","HKD","HRK","HUF","IDR","ILS","INR","ISK","JPY","KRW","MXN","MYR","NOK","NZD","PHP","PLN","RON","RUB","SEK","SGD","THB","USD","ZAR"]

        let countryfullNames = ["Australian Dollar","Bulgarian Lev","Brazilian Real","Canadian Dollar","Swiss Franc","Chinese Yuan","Czech Republic ","Danish Krone","Euro","British Pound","Hong Kong","Croatian Kuna","Hungarian Forint","Indonesian Rupiah","Israeli New Sheqel","Indian Rupee","Icelandic Króna","Japanese Yen","South Korean Won","Mexican Peso","Malaysian Ringgit","Norwegian Krone","Swedish Krona","Philippine Peso","Polish Zloty","Romanian Leu","Russian Ruble","Swedish Krona","Singapore Dollar","Thai Baht","US Dollar","South African Rand"]


        for(e1,e2) in zip (countryShortNames,countryfullNames) {
            let currency = CurrencyContry(imageUrl: "", countryShortName: e1, countryFullName: e2)
            lisOfCurrencyContry.append(currency)
        }

        return lisOfCurrencyContry
    }
    
    
}


