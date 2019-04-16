//
//  RCurrenciesListViewController.swift
//  RevoluteTestProject
//

import UIKit
protocol SwapRootViewControllerDelegate : NSObjectProtocol{
    func doSwapRootViewControllerWithNewOne(data: Dictionary<String,Any>)
}

class RCurrenciesListViewController: UIViewController {

    @IBOutlet weak var currenciesListTableView: UITableView!
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    
    var isDetailed:Bool   = false
    var urlParam:String  = ""
    var prevScreeParam:String  = ""
    var firstScreeParam:String  = ""
    var selectedArray : NSDictionary = [:]

    var viewModel = CurrenciesListModelView(isDetailViewController: false,disabledCellsArray:[:] )
    weak var delegate : SwapRootViewControllerDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadingIndicatorView.transform = CGAffineTransform(scaleX: 3, y: 3)
        self.loadingIndicatorView.hidesWhenStopped = true

        self.viewModel?.currencyViewModelsTypes.forEach { $0.registerCell(tableView: self.currenciesListTableView) }
        self.bindToViewModel()
        self.reloadData()
    }
    //MARK: - ViewModel
    private func bindToViewModel() {
        self.viewModel!.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
        self.viewModel?.didSelectCurrency = { [weak self] currency in
            self?.showDetailCurrency(currency: currency)
        }

    }
    private func viewModelDidUpdate() {
        self.currenciesListTableView.reloadData()
    }
    //MARK: - Actions
    @objc private func reloadData() {
        viewModel?.isDetailViewController = self.isDetailed
        viewModel?.disabledCellsArray = self.selectedArray
        self.viewModel!.reloadData()
    }
    private func setSelectedValue() {
        self.viewModel?.didSelectCurrency = { [weak self] currency in
            self?.showDetailCurrency(currency: currency)
        }
    }
    
    private func showDetailCurrency(currency: CurrencyContry) {
        urlParam = prevScreeParam + currency.countryShortName!
        
        print(urlParam);
        
        if(self.isDetailed == false) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailViewController = storyboard.instantiateViewController(withIdentifier: "CustomViewControllerID") as! RCurrenciesListViewController
            detailViewController.selectedArray = selectedArray
            detailViewController.isDetailed = true
            detailViewController.delegate = self.delegate
            detailViewController.prevScreeParam  = urlParam
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        else{
            self.loadingIndicatorView.startAnimating()
            self.navigationController?.dismiss(animated: true, completion:  {
                var currencyClientList :JSONArray<Currency>? = nil
                let userClient = Client.CurrencyAPIClient()
                
                userClient.CurrencyWithName (param: self.urlParam) {  resulte in
                currencyClientList = resulte.res!
                    for user in (currencyClientList?.array)! {
                        DispatchQueue.main.async {
                            self.loadingIndicatorView.stopAnimating()
                        }
                        var newArray = [String: Any] ()
                        let newValue = currency.countryShortName! + "/" + self.prevScreeParam
                        newArray[newValue] = user.value
                        if let delegate = self.delegate{
                            delegate.doSwapRootViewControllerWithNewOne(data: newArray)
                        }
                        
                    }
                }
            })
            
        }
    }
}
extension RCurrenciesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.currencyViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel!.currencyViewModels[indexPath.row]
            .dequeueCell(tableView: tableView, indexPath: indexPath as NSIndexPath)
    }
}
extension RCurrenciesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.currencyViewModels[indexPath.row].cellSelected()
    }
}

