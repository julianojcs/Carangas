//
//  ViewController.swift
//  Carangas
//
//  Created by Eric Alves Brito on 24/05/21.
//

import UIKit

class CarViewController: UIViewController {

    @IBOutlet weak var labelBrand: UILabel!
    @IBOutlet weak var labelGasType: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    var car: Car?
    var numberFormater: NumberFormatter = {
        let numberFormater = NumberFormatter()
        numberFormater.numberStyle = .currency
        numberFormater.locale = Locale(identifier: "pt_BR")
        return numberFormater
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let car = car {
            print(car.name)
            print(car.gasType)
            title = car.name
            labelBrand.text = car.brand
            labelGasType.text = car.fuel
            labelPrice.text = numberFormater.string(from: NSNumber(value: car.price))
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carFormViewController = segue.destination as? CarFormViewController {
            carFormViewController.car = car
        }
    }
}

