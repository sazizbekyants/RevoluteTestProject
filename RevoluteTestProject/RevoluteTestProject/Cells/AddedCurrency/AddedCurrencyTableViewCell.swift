//
//  TableViewCell.swift
//  RevoluteTestProject
//
//  Created by Sergo Azizbekyants on 4/15/19.
//  Copyright © 2019 Sergo Azizbekyants. All rights reserved.
//

import UIKit

class AddedCurrencyTableViewCell: UITableViewCell {

    
    @IBOutlet weak var curencyShortLableTitle: UILabel!
    @IBOutlet weak var currencyShortlableDescription: UILabel!
    @IBOutlet weak var currencyPairLableValue: UILabel!
    @IBOutlet weak var currencyPairLableDescription: UILabel!

    func setup(viewModel: AddedCurrencyTableViewCellModel) {
        guard viewModel.allowedAccess(object: self) else { return }
        
        self.curencyShortLableTitle.text             = viewModel.countryShortName
        self.currencyShortlableDescription.text      = viewModel.countryFullName
        self.currencyPairLableValue.text             = viewModel.countryShortNameTitle
        self.currencyPairLableDescription.text       = viewModel.countryShortNameDescription
        
        viewModel.didUpdate = self.setup
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
