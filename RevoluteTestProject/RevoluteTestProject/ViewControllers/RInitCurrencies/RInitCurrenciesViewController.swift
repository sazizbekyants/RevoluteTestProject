//
//  RInitCurrenciesViewController.swift
//  RevoluteTestProject
//

import UIKit


class RInitCurrenciesViewController: UIViewController ,SwapRootViewControllerDelegate {
    
    func doSwapRootViewControllerWithNewOne(data: Dictionary<String,Any>) {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = (mainStoryBoard.instantiateViewController(withIdentifier: "RAddedCurrenciesListViewControllerID") as! RAddedCurrenciesListViewController)
        viewController.countryDictionary = data as NSDictionary
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController = self.viewController
        }
    }
    var viewController:RAddedCurrenciesListViewController! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewCurencyAction(_ sender: Any) {
        self.performSegue(withIdentifier: "OpenCurrenciesListFromInitSegueId", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "OpenCurrenciesListFromInitSegueId") {
            let navigation = segue.destination as! UINavigationController
            let displayVC  = navigation.topViewController as! RCurrenciesListViewController
            displayVC.delegate = self
        }
    }

}



