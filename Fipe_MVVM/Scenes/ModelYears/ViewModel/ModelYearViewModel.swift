//
//  ModelYearViewModel.swift
//  20.11_MVCAdvanced
//
//  Created by Gilvã Lopes on 10/12/20.
//

import Foundation
import Alamofire

class ModelYearViewModel: ViewModelProtocol {
    
    var apiManager = APIManager()
    
    var selectedBrand: Brand
    var selectedModel: Model
    
    init(brand: Brand, model: Model) {
        selectedBrand = brand
        selectedModel = model
    }
    
    var arrayYears = [ModelYear]()
    var arrayFiltered = [ModelYear]()
    
    func filter(terms: String) {
        if terms.count == 0 {
            arrayFiltered = arrayYears
            return
        }
        
        self.arrayFiltered = arrayYears.filter( { model in
            let modelUpper = model.name.uppercased()
            return modelUpper.contains(terms.uppercased())
        })
    }
    
    func getArray() -> [Any] {
        return arrayFiltered
    }
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.request(url: "https://parallelum.com.br/fipe/api/v1/carros/marcas/\(selectedBrand.id!)/modelos/\(selectedModel.id!)/anos") { (json, jsonArray, string) in
            if let jsonYears = jsonArray {
                var years = [ModelYear]()
                for item in jsonYears {
                    years.append(ModelYear(fromDictionary: item))
                }
                self.arrayYears = years
                self.arrayFiltered = years
                onComplete(true)
                return
            }
            onComplete(false)
        }
    }
    
    func getNumberOfRows() -> Int {
        return arrayFiltered.count
    }
    
    func getNextController(index: Int) -> UIViewController {
        let nextController =  CarViewModel(brand: selectedBrand, model: selectedModel, year: arrayYears[index])
        nextController.selectedBrand = selectedBrand
        nextController.selectedModel = selectedModel
        nextController.selectedYear = arrayYears[index]
        return CarDetailViewController.setView(viewModel: nextController)
    }
    
    func getTitleForCell(at index: Int) -> String {
        return arrayFiltered[index].name
    }
    
    func getViewTitle() -> String {
        return "Ano - \(selectedModel.name!)"
    }
}
