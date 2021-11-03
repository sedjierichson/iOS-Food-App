//
//  ViewController.swift
//  foodOrder
//
//  Created by Richson Sedjie on 08/10/21.
//

import UIKit
import Foundation

class Product {
    var productName: String
    var productPrice: Int
    var isProductAddedToCart: Bool
    var productCount: Int
    init(productName: String, productPrice: Int, isProductAddedToCart: Bool, productCount: Int) {
        self.productName = productName
        self.productPrice = productPrice
        self.isProductAddedToCart = isProductAddedToCart
        self.productCount = productCount
    }
}


class ListOfProduct {
    var productsArray: [Product] = []
    
    func addProdcutsInToList() -> [Product] {
        let indomie = Product(productName: "Indomie Jumbo", productPrice: 15000, isProductAddedToCart: false, productCount: 0)
        let orangejuice = Product(productName: "Jus Jeruk", productPrice: 10000, isProductAddedToCart: false, productCount: 0)
        let coffee = Product(productName: "Es Kopi", productPrice: 20000, isProductAddedToCart: false, productCount: 0)
        let nasigoreng = Product(productName: "Nasi Goreng", productPrice: 25000, isProductAddedToCart: false, productCount: 0)
        let ramen = Product(productName: "Mie Ramen", productPrice: 40000, isProductAddedToCart: false, productCount: 0)
        let salad = Product(productName: "Salad Buah", productPrice: 20000, isProductAddedToCart: false, productCount: 0)
        let ayam = Product(productName: "Ayam Saus", productPrice: 8000, isProductAddedToCart: false, productCount: 0)
        
        let coke = Product(productName: "Coca Cola", productPrice: 8000, isProductAddedToCart: false, productCount: 0)
        let mineral = Product(productName: "Air Mineral", productPrice: 5000, isProductAddedToCart: false, productCount: 0)
        let oolong = Product(productName: "Teh Oolong", productPrice: 30000, isProductAddedToCart: false, productCount: 0)
        
        productsArray.append(indomie)
        productsArray.append(nasigoreng)
        productsArray.append(ramen)
        productsArray.append(salad)
        productsArray.append(ayam)
        
        productsArray.append(orangejuice)
        productsArray.append(coffee)
        productsArray.append(coke)
        productsArray.append(mineral)
        productsArray.append(oolong)

        return productsArray
    }
    
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var productArray : [Product] = []
    var productList = ListOfProduct()
    var tempProductArray : [Product] = []
    
    //var productPrice = [15000,10000,20000]
    
    @IBOutlet weak var menuTable: UITableView!
    
    private let floatingButton: UIButton={
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .systemBlue
        
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: view.frame.size.width - 80,
                                      y: view.frame.size.height - 90,
                                      width: 60, height: 60)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        title = "MENU LIST"
        // Do any additional setup after loading the view.
        productArray = productList.addProdcutsInToList()
        menuTable.delegate = self
        menuTable.dataSource = self
        navigationItem.hidesBackButton = true  
    }
    
    @objc private func didTapButton(){
        
        if tempProductArray.count > 0{
            performSegue(withIdentifier: "move", sender: self)
        }else{
            let alert = UIAlertController(title: "No Menu Added", message: "Please add some item to cart!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in print ("Confirmed")}))
            
            //wolfTurnLabel.text = "GAME OVER!"
           
            present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "move"{
            let vc = segue.destination as! ViewController2
            vc.cartProductArray = tempProductArray
        }
    }


}

extension ViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as? ProductsTableViewCell{
            cell.menuLabel.text = productArray[indexPath.row].productName
            cell.priceLabel.text = "Rp \(productArray[indexPath.row].productPrice)"
            cell.addToCart.isHidden = self.productArray[indexPath.row].isProductAddedToCart
            
            cell.addToCartTapped = {
                self.productArray[indexPath.row].isProductAddedToCart = true
                cell.addToCart.isHidden = true
                self.tempProductArray.append(self.productArray[indexPath.row])
            }
            
            cell.quantityLabel.text = "\(productArray[indexPath.row].productCount)"
            cell.addTapped = {
                self.productArray[indexPath.row].productCount += 1
                cell.quantityLabel.text = "\(self.productArray[indexPath.row].productCount)"
            }
            cell.minusTapped = {
                if self.productArray[indexPath.row].productCount > 1{
                    self.productArray[indexPath.row].productCount -= 1
                    cell.quantityLabel.text = "\(self.productArray[indexPath.row].productCount)"
                } else{
                    self.productArray[indexPath.row].productCount = 0
                    cell.addToCart.isHidden = false
                    self.tempProductArray.remove(at: indexPath.row)
                    cell.quantityLabel.text = "\(self.productArray[indexPath.row].productCount)"
                }
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}

