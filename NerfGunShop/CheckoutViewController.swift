//
//  CheckoutViewController.swift
//  NerfGunShop
//
//  Created by CCIAD3 on 17/2/22.
//

import UIKit
import CoreLocation

class CheckoutViewController: UIViewController {
    
    var totalPrice:Int16!
    var discount:Int = 0
    var credits:Int16!
    var address:String!
    var discounted:Bool = false
    let geoCoder = CLGeocoder()
    @IBOutlet var payableLbl: UILabel!
    @IBOutlet var creditsLbl: UILabel!
    @IBOutlet var addressLbl: UILabel!
    @IBOutlet var timeLbl: UILabel!
    @IBOutlet var payBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        credits = getLoggedInUser().credits
        payBtn.isEnabled = false
        
        if totalPrice != nil {
            payableLbl.text = "\(totalPrice ?? 0) Credits"
            updateCreditLbl()
        } else {
            self.present(createSimpleAlert(title: "Unable to Checkout", message: "totalPrice is nil (code broken?)"), animated: true, completion: nil)
        }
    }
    
    
    @IBAction func completeBtn(_ sender: Any) {
        deductCredits(amount: totalPrice)
        deleteCart(userId: getUserId())
        performSegue(withIdentifier: "toCheckoutSuccess", sender: nil)
    }
    
    @IBAction func topUpBtn(_ sender: Any) {
        performSegue(withIdentifier: "checkoutToAddCredit", sender: nil)
    }
    
    
    @IBAction func changeAddressBtn(_ sender: Any) {
        performSegue(withIdentifier: "toAddresses", sender: nil)
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if !discounted {
                discounted = true
                discount = Int.random(in: 0...20)
                totalPrice = Int16((Float(totalPrice) / 100) * (100 - Float(discount)))
                updateCreditLbl()
                if discount != 0 {
                    payableLbl.text = "\(totalPrice!) Credits\nAfter \(discount)% Discount"
                    self.present(createSimpleAlert(title: "Yay, A Discount!", message: "A \(discount)% discount has been added to your checkout"), animated: true, completion: nil)
                } else {
                    self.present(createSimpleAlert(title: "Oops, No Discount", message: "No discount has been added."), animated: true, completion: nil)
                }
            }
        }
    }
    
    func updateCreditLbl() {
        credits = getLoggedInUser().credits
        if totalPrice > credits {
            creditsLbl.text = "\(credits ?? 0) Credits\nInsufficent Credits"
            creditsLbl.textColor = .red
            payBtn.isEnabled = false
            
        } else {
            creditsLbl.text = "\(credits ?? 0) Credits\n\(credits - totalPrice) Credits after payment"
            creditsLbl.textColor = UIColor.label
        }
    }
    
    @IBAction func unwindToCheckout(segue:UIStoryboardSegue) {
        if segue.identifier == "fromAddressList" {
            addressLbl.text = address ?? "Error getting address"
            timeLbl.text = "Getting weather info..."
            geoCoder.geocodeAddressString(address) {
                (placemarks, error) in
                guard
                    let placemarks = placemarks,
                    let location = placemarks.first?.location
                else {
                    self.timeLbl.text = "Error getting coodinates from address"
                    self.payBtn.isEnabled = false
                    return
                }
                
                let urlstring = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=4476416a83098f6bdffb00356c075d2b"
                print("URL: " + urlstring)
                let url:URL = URL(string: urlstring)!
                var weatherDescriptor:String = ""
                
                let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                    guard let dataResponse = data,
                        error == nil else {
                        print(error?.localizedDescription ?? "Response Error")
                        self.timeLbl.text = "Error in API response"
                        return
                    }
                    do{
                        let decoder = JSONDecoder()
                        let model = try decoder.decode(weather.self, from: dataResponse)
                        if model.weather[0].main == "Rain" {
                            weatherDescriptor = "Bad Weather Condition\nNext Day"
                        } else {
                            weatherDescriptor = "\((model.weather[0].description)?.capitalized ?? "Unknown")\nSame Day"
                        }
                        
                        DispatchQueue.main.async {
                            self.payBtn.isEnabled = true
                        }
                    }
                    catch let parsingError {
                        print("Error", parsingError)
                    }
                    
                    DispatchQueue.main.async {
                        self.timeLbl.text = weatherDescriptor
                    }
                }
                task.resume()
            }
        }
        
        if segue.identifier == "fromAddCredit" {
            updateCreditLbl()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "checkoutToAddCredit" {
            let destVC = segue.destination as! AddCreditsViewController
            destVC.isCheckout = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
