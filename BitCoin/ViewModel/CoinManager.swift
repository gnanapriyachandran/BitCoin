//
//  CoinManager.swift
//  BitCoin
//
//  Created by Vidhya C on 20/09/21.
//  Copyright © 2021 Gnanapriya C. All rights reserved.
//

import Foundation

struct CoinManager {
    //Delegate variable
    var delegate: CoinManagerDelegate?
    
    //Fetch Coin price details
    func getCoinPrice(currency: String) {
        let urlString = "\(Constants().baseURL)/\(currency)?apikey=\(Constants().apiKey)"
        performRequest(with: urlString)
    }
    
    //API call
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error ?? Constants().emptyString)
                }
                
                if let safeData = data {
                    print(safeData)
                    //Parse Json
                    if let parsedData = self.parseJson(data: safeData) {
                        self.delegate?.didUpdateRate(coinData: parsedData)
                    }
                }
            })
            
            task.resume()
        }
    }
    
    //Decode data and return price
    func parseJson(data: Data) -> CoinData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            return CoinData(rate: decodedData.rate)
        }
        catch {
            print(error)
        }
        return nil
    }
    
}

//Update rate label value
protocol CoinManagerDelegate {
    func didUpdateRate(coinData: CoinData)
}
