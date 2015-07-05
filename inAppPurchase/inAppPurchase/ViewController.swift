//
//  ViewController.swift
//  inAppPurchase
//
//  Created by Alexis Saint-Jean on 7/4/15.
//  Copyright (c) 2015 Alexis Saint-Jean. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    @IBOutlet weak var lblAd: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var outRemoveAds: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        outRemoveAds.enabled = false
        
        if(SKPaymentQueue.canMakePayments()) {
            println("In App Purchase enabled. Loading...")
            var productID:NSSet = NSSet(objects: "asjdev.inAppPurchase.vocabulary", "asjdev.inAppPurchase.removeAds")
            var request:SKProductsRequest = SKProductsRequest(productIdentifiers: productID as Set<NSObject>)
            request.delegate = self
            request.start()
        } else {
            println("Please enable in app purchases")
            resultLabel.text = "Please enable in app purchases"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnRemoveAds(sender: UIButton) {
        for product in list {
            var prodID = product.productIdentifier
            if(prodID == "asjdev.inAppPurchase.vocabulary"){
                p = product
                buyProduct()
                break
            }
        }
    }
    
    func removeAds() {
        println("Removing Ads")
        resultLabel.text = "Removing Ads"
    }
    
    func addCoins() {
        println("Adding coins")
        resultLabel.text = "Adding Coins"
    }

    @IBAction func RestorePurchases(sender: UIButton) {
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
    }
    
    
    
    var list = [SKProduct]()
    var p = SKProduct()
    
    func buyProduct() {
        println(" buy " + p.productIdentifier)
        var pay = SKPayment(product: p)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().addPayment(pay as SKPayment)
    }

    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        println("product request")
        var myProduct = response.products
        
        for product in myProduct {
            println("product added")
            println(product.productIdentifier)
            println(product.localizedTitle)
            println(product.localizedDescription)
            println(product.price)
            
            list.append(product as! SKProduct)
        }
        
        outRemoveAds.enabled = true
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(queue: SKPaymentQueue!) {
        println("Transactions restored.")
        
        var purchasedItemIDs = []
        for transaction in queue.transactions {
            var t:SKPaymentTransaction = transaction as! SKPaymentTransaction
            
            let prodID = t.payment.productIdentifier as String
            switch prodID {
            case "asjdev.inAppPurchase.vocabulary":
                println("add vocabulary")
                removeAds()
            case "asjdev.inAppPurchase.removeAds":
                println("remove Ads")
                addCoins()
            default:
                println("ID not set up")
            }

        }
    }
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        println("add payment")
        
        for transaction:AnyObject in transactions {
            var trans = transaction as! SKPaymentTransaction
            println(trans.error)
            
            
            switch trans.transactionState {
            case .Purchased:
                println("buy, OK to unlock")
                println(p.productIdentifier)
                
                let prodID = p.productIdentifier as String
                switch prodID {
                    case "asjdev.inAppPurchase.vocabulary":
                        println("add vocabulary")
                        removeAds()
                    case "asjdev.inAppPurchase.removeAds":
                        println("remove Ads")
                        addCoins()
                default:
                    println("ID not set up")
                }
                queue.finishTransaction(trans)
                break
                
            case .Failed:
                println("Buy error")
                queue.finishTransaction(trans)
                break
            default:
                println("default")
                break
            }
            
        }
        
    }
    
    func finishTransaction(trans:SKPaymentTransaction){
        println("finish trans")
    }
    
    func paymentQueue(queue: SKPaymentQueue!, removedTransactions transactions: [AnyObject]!) {
        println("remove trans")
    }
    
    
    
}

