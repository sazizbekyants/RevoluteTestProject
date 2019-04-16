//
//  CurrencyCellViewModel.swift
//  RevoluteTestProject
//

import Foundation
import UIKit

class CurrencyCellViewModel {

    private let currency: CurrencyContry
    private var isDisabled:Bool

    private var restrictedTo: NSIndexPath?
    
    init(currency: CurrencyContry ,isDisabled:Bool) {
        self.currency   = currency
        self.isDisabled = isDisabled
    }
    deinit {}

    var countryShortName: String { return (self.currency.countryShortName!)  }
    var countryFullName: String { return (self.currency.countryFullName!) }
    
    //MARK: - Actions
    func allowedAccess(object: CellIdentifiable) -> Bool {
        guard
            let restrictedTo = self.restrictedTo,
            let uniqueId = object.uniqueId
            else { return true }
        
        return uniqueId == restrictedTo
    }

    var didUpdate: ((CurrencyCellViewModel) -> Void)?
    var didSelectCurrency: ((CurrencyContry) -> Void)?
}



extension CurrencyCellViewModel: CellRepresentable {
    static func registerCell(tableView: UITableView) {
        let nib = UINib.init(nibName:"CurrencyTableViewCell" ,bundle: nil )
        tableView.register(nib, forCellReuseIdentifier: "CurrencyTableViewCell")
    }
    
    func dequeueCell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell"/*String(CurrencyTableViewCell)*/, for: indexPath as IndexPath) as! CurrencyTableViewCell
        cell.uniqueId = indexPath
        self.restrictedTo = indexPath
        cell.setup(viewModel: self)
        if(isDisabled) {
            cell.isUserInteractionEnabled = false
            cell.contentView.alpha=0.2;
        }
        return cell
    }
    func cellSelected() {
        self.didSelectCurrency?(self.currency)
    }
}
