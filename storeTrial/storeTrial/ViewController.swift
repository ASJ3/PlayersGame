//
//  ViewController.swift
//  storeTrial
//
//  Created by Alexis Saint-Jean on 7/4/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import StoreKit


class ViewController: UIViewController,SKPaymentTransactionObserver, SKProductsRequestDelegate {
    
    var product: SKProduct!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var level2Button: UIButton!
    @IBOutlet weak var buyNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        level2Button.enabled = false
        level2Button.hidden = true
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        self.getProductInfo()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!){
        let products = response.products
        if products.count != 0
        {
            product = products[0] as! SKProduct
            productTitle.text = product.localizedTitle + "\n" + product.localizedDescription
            
        }
    }
    
    
    
    func getProductInfo(){
        if SKPaymentQueue.canMakePayments(){
            let productID:NSSet = NSSet(object:"1001")
            let request:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>)
            request.delegate = self
            request.start()
        }
    }
    
    
    
    //in app level 2 - non-consumable
    @IBAction func buyProduct(sender: AnyObject) {
        let payment:SKPayment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addPayment(payment)
        
    }

    func openLevel2(){
        println("next VC called")
        level2Button.enabled = true
        level2Button.hidden = false
        
    }
    
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!){
        for transaction:AnyObject in transactions {
            if let trans:SKPaymentTransaction = transaction as? SKPaymentTransaction{
                switch trans.transactionState {
                case .Purchased:
                    self.openLevel2()
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .Failed:
                    SKPaymentQueue.defaultQueue().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .Restored:
                    SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
                    break
                default:
                    break
                }
            }
        }
    }
}

