//
//  CarsTableViewController.swift
//  Carangas
//
//

import UIKit

class CarsTableViewController: UITableViewController {
    
    var cars: [Car] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCars()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carViewController = segue.destination as? CarViewController,
           let row = tableView.indexPathForSelectedRow?.row {
            carViewController.car = cars[row]
        }
    }

    // MARK: - Table view data source
    func loadCars() {
        CarAPI().loadCars {[weak self] result in
            switch result {
            case .success(let cars):
//                cars.forEach({print($0.name)})
                self?.cars = cars
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                break
            case .failure(let apiError):
                switch apiError {
                case .badURL:
                    print("Invalid URL")
                case .invalidStatusCode(let statusCode):
                    print("Invalid status code: \(statusCode)")
                default:
                    print("Other error")
                }
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let car = cars[indexPath.row]
        cell.textLabel?.text = car.name
        cell.detailTextLabel?.text = car.brand
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let car = cars[indexPath.row]
            CarAPI().deleteCar(car) { result in
                switch result {
                case .success:
                    self.cars.remove(at: indexPath.row)
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                case .failure:
                    print("Delete failure")
                }
            }
        }
    }
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
