//
//  ViewController.swift
//  BitCoin
//
//  Created by Vidhya C on 20/09/21.
//  Copyright © 2021 Gnanapriya C. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CoinManagerDelegate {

    //Outlets
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var currencyUnitTextField: UITextField!
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants().title
        coinManager.delegate = self
        coinManager.getCoinPrice(currency: currencyUnitTextField.text ?? Constants().defaultCurrency)
    }
    
    //delegate function definition
    func didUpdateRate(coinData: CoinData) {
        DispatchQueue.main.sync {
            self.priceValueLabel.text = String(format: Constants().priceFormat,coinData.rate)
        }
    }
    
    @IBAction func checkPrice(_ sender: Any) {
        coinManager.getCoinPrice(currency: currencyUnitTextField.text ?? Constants().defaultCurrency)
    }
    
}

