//
//  AddedCurrencyTableViewCellModel.swift
//  RevoluteTestProject
//

import Foundation
import UIKit

class AddedCurrencyTableViewCellModel {
    private var restrictedTo: NSIndexPath?
    private let currency: AddedCurrencyContry

    init(currency: AddedCurrencyContry) {
        self.currency = currency
    }
    var didUpdate: ((AddedCurrencyTableViewCellModel) -> Void)?
    var didSelectCurrency: ((AddedCurrencyContry) -> Void)?
    

    var countryShortName: String { return (self.currency.countryFullName!)  }
    var countryFullName: String { return (self.currency.countryShortName!) }
    var countryShortNameTitle: String { return (self.currency.countryShortNameTitle!)  }
    var countryShortNameDescription: String { return (self.currency.countryShortNameDescription!) }
    
    
}
extension AddedCurrencyTableViewCellModel: CellRepresentable {
    static func registerCell(tableView: UITableView) {
        let nib = UINib.init(nibName:"AddedCurrencyTableViewCell" ,bundle: nil )
        tableView.register(nib, forCellReuseIdentifier: "AddedCurrencyTableViewCell")
    }
    
    func dequeueCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddedCurrencyTableViewCell", for: indexPath as IndexPath) as! /*AddedCurrencyTableViewCell*/AddedCurrencyTableViewCell
        cell.uniqueId = indexPath
        self.restrictedTo = indexPath
        cell.setup(viewModel: self)
        return cell
    }
    func cellSelected() {
//        self.didSelectCurrency?(self.currency)
    }
    
    //MARK: - Actions
    func allowedAccess(object: CellIdentifiable) -> Bool {
        guard
            let restrictedTo = self.restrictedTo,
            let uniqueId = object.uniqueId
            else { return true }
        
        return uniqueId == restrictedTo
    }

}
