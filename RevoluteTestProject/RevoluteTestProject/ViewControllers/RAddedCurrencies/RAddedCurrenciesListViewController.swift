//
//  RAddedCurrenciesListViewController.swift
//  RevoluteTestProject
//

import UIKit

/*
extension  Dictionary {
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }
    
    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}
 */
extension NSDictionary {
    var swiftDictionary: Dictionary<String, Any> {
        var swiftDictionary = Dictionary<String, Any>()
        
        for key : Any in self.allKeys {
            let stringKey = key as! String
            if let keyValue = self.value(forKey: stringKey){
                swiftDictionary[stringKey] = keyValue
            }
        }
        return swiftDictionary
    }
}


class RAddedCurrenciesListViewController: UIViewController ,SwapRootViewControllerDelegate{
    open var hidesNavigationBarWhenPushed = false
    @IBOutlet weak var addedCurenciesTableView: UITableView!
    var countryDictionary:NSDictionary = [:]

    
    func doSwapRootViewControllerWithNewOne(data: Dictionary<String,Any>) {
        
        var tempDictinary = self.countryDictionary as Dictionary
        tempDictinary.update(other: data as Dictionary<String,Any> as Dictionary<NSObject, AnyObject>)
        self.countryDictionary = tempDictinary as NSDictionary
        self.reloadData()
    }
    
    var viewModel = AddedCurrenciesModelView()
    
    @IBAction func addCurrencyAction(_ sender: Any) {
        self.performSegue(withIdentifier: "OpenCurrenciesListFromAddedSegueId", sender: self)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(hidesNavigationBarWhenPushed, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.addedCurrenciesModelViewTypes.forEach { $0.registerCell(tableView: self.addedCurenciesTableView) }
        self.bindToViewModel()
        self.reloadData()
    }
    //MARK: - ViewModel
    private func bindToViewModel() {
        self.viewModel.didUpdate = { [weak self] _ in
            self?.viewModelDidUpdate()
        }
    }
    private func viewModelDidUpdate() {
        self.addedCurenciesTableView.reloadData()
    }
    //MARK: - Actions
    @objc private func reloadData() {
        viewModel.addedcurrencyList = self.countryDictionary
        DispatchQueue.main.async {
            self.viewModel.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "OpenCurrenciesListFromAddedSegueId") {
            let navigation = segue.destination as! UINavigationController
            let displayVC  = navigation.topViewController as! RCurrenciesListViewController
            displayVC.delegate = self
            displayVC.selectedArray = self.countryDictionary
        }
    }
}

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}


extension RAddedCurrenciesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.addedCurrenciesModelView.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.addedCurrenciesModelView[indexPath.row]
            .dequeueCell(tableView: tableView, indexPath: indexPath as NSIndexPath)
    }
}

extension RAddedCurrenciesListViewController: UITableViewDelegate {
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.viewModel.addedCurrenciesModelView[indexPath.row].cellSelected()
    }
}
