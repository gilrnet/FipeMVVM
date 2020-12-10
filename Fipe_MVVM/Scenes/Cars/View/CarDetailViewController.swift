//
//  CarViewController.swift
//  Fipe_MVVM
//
//  Created by Gilvã Lopes on 10/12/20.
//

import UIKit

class CarDetailViewController: UIViewController {

    var viewModel: CarViewModel?
    
    @IBOutlet weak var labelCarName: UILabel!
    @IBOutlet weak var labelCarYear: UILabel!
    @IBOutlet weak var labelCarBrand: UILabel!
    @IBOutlet weak var labelCarPrice: UILabel!
    
    @IBOutlet weak var modelStackView: UIStackView!
    @IBOutlet weak var yearStackView: UIStackView!
    @IBOutlet weak var brandStackView: UIStackView!
    @IBOutlet weak var valueStackView: UIStackView!
    
    
    func setComponents(car: Car) {
        
        labelCarName.text = car.modelo
        labelCarYear.text = String(car.anoModelo)
        labelCarBrand.text = car.marca
        labelCarPrice.text = car.valor
    }
    
    class func setView(viewModel: CarViewModel) -> CarDetailViewController {
        let nextView = UIStoryboard(name: "CarDetail", bundle: nil).instantiateInitialViewController() as! CarDetailViewController
        nextView.viewModel = viewModel
        return nextView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modelStackView.layer.cornerRadius = 20
        yearStackView.layer.cornerRadius = 20
        brandStackView.layer.cornerRadius = 20
        valueStackView.layer.cornerRadius = 20
        
        if let viewModel = viewModel {
            viewModel.loadData(onComplete: { (succes) in
                if let car = viewModel.car {
                    self.setComponents(car: car)
                }
            })
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
