//
//  CarFormViewController.swift
//  Carangas
//
//  Created by Eric Alves Brito on 24/05/21.
//

import UIKit

class CarFormViewController: UIViewController {

    @IBOutlet weak var textFieldBrand: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPrice: UITextField!
    @IBOutlet weak var segmentedControlGasType: UISegmentedControl!
    @IBOutlet weak var buttonAddEdit: UIButton!
    
    var car: Car?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let car = car {
            title = "Edit car"
            textFieldName.text = car.name
            textFieldBrand.text = car.brand
            textFieldPrice.text = "\(car.price)"
            segmentedControlGasType.selectedSegmentIndex = car.gasType
            buttonAddEdit.setTitle("Save Edited Car", for: .normal)
        }
    }
    
    @IBAction func save(_ sender: UIButton) {
        if car == nil {
            car = Car()
        }
        car?.name = textFieldName.text!
        car?.brand = textFieldBrand.text!
        car?.price = Int(textFieldPrice.text!) ?? 0
        car?.gasType = segmentedControlGasType.selectedSegmentIndex
        
        if car?._id == nil {
            CarAPI().createCar(car!) { [weak self] result in
                switch result {
                case .success:
                    self?.goBack()
                case .failure:
                    print("Car creation failure")
                }
            }
        } else {
            CarAPI().updateCar(car!) { [weak self] result in
                switch result {
                case .success:
                    self?.goBack()
                case .failure:
                    print("Car update failure")
                }
            }
        }
    }
    
    func goBack() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
