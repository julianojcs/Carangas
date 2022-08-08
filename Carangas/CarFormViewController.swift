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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(_ sender: UIButton) {

    }
    
}
