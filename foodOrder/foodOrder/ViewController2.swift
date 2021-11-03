//
//  ViewController2.swift
//  foodOrder
//
//  Created by Richson Sedjie on 08/10/21.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    var cartProductArray:[Product] = []
    var subTotal: Int = 0
    @IBOutlet weak var cartTableView: UITableView!
    
    @IBOutlet weak var subTotalLabel: UILabel!
    @IBOutlet weak var totalPaymentLabel: UILabel!
    
    @IBAction func confirmOrderButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Confirm Order", message: "Are you sure ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {action in self.performSegue(withIdentifier: "moveVC3", sender: self)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: {action in print ("Canceled")}))
        
        //wolfTurnLabel.text = "GAME OVER!"
       
        present(alert, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.delegate = self
        cartTableView.dataSource = self
        title = "Payment"
        
        subTotal = cartProductArray.map{$0.productPrice *  $0.productCount}.reduce(0, +)
        subTotalLabel.text = "Rp \(subTotal)"
        totalPaymentLabel.text = "Rp \(subTotal + (subTotal*10/100))"

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell{
            cell.menuLabel.text = cartProductArray[indexPath.row].productName
            cell.quantityLabel.text = "\(cartProductArray[indexPath.row].productCount) pcs"
            cell.priceLabel.text = "Rp \(cartProductArray[indexPath.row].productPrice * cartProductArray[indexPath.row].productCount )"
            return cell
        }
        return UITableViewCell()
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
