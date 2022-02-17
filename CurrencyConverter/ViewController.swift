//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by ece on 17.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var euLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        
        //1. Request/Session
        //**not:http linklerine girişe izin vermek için info.plist Allow Artbitrary Loads'ı yes yapmalısın
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=5d4f1280ceae3fb2e5021177f140490c")
        let session = URLSession.shared
        
        //closure
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                let alert = UIAlertController(title: "OK", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
            } else {
         //2.Response/Data
                if data != nil {
                    do {
                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        //Async --senkronize olmayan işleri yaparken uygulama kitlenmesin birden fazla işi biranda yapsın
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let eu = rates["EUR"] as? Double {
                                    self.euLabel.text = "EUR: \(eu)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(tr)"
                                }
                            }
                        }
                        
                    } catch {
                        print("error")
                    }
                }
            }
           
        };  task.resume()
    }
}

