//
//  CurrencyTableViewCell.swift
//  RevoluteTestProject
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryShortName: UILabel!
    @IBOutlet weak var countryFullName: UILabel!
    
    
    
    //MARK: - Public
    func setup(viewModel: CurrencyCellViewModel) {
        guard viewModel.allowedAccess(object: self) else { return }
        
        self.countryShortName.text = viewModel.countryShortName
        self.countryFullName.text  = viewModel.countryFullName
        viewModel.didUpdate = self.setup
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
