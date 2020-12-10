//
//  ModelsViewModel.swift
//  20.11_MVCAdvanced
//
//  Created by Gilvã Lopes on 10/12/20.
//

import Foundation
import Alamofire

class ModelsViewModel: ViewModelProtocol {
    
    var arrayModels = [Model]()
    var arrayFiltered = [Model]()
    
    var selectedBrand: Brand
    
    var apiManager = APIManager()
    
    init(brand: Brand) {
        selectedBrand = brand
    }
    
    func filter(terms: String) {
        if terms.count == 0 {
            arrayFiltered = arrayModels
            return
        }
        
        self.arrayFiltered = arrayModels.filter( { model in
            let modelUpper = model.name.uppercased()
            return modelUpper.contains(terms.uppercased())
        })
    }
    
    func getArray() -> [Any] {
        return arrayFiltered
    }
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.request(url: "https://parallelum.com.br/fipe/api/v1/carros/marcas/\(selectedBrand.id!)/modelos") { (json, jsonArray, string) in
            if let json = json {
                if let jsonModels = json["modelos"] as? [[String: Any]] {
                    var models = [Model]()
                    for item in jsonModels {
                        models.append(Model(fromDictionary: item))
                    }
                    self.arrayModels = models
                    self.arrayFiltered = models
                    onComplete(true)
                    return
                }
                onComplete(false)
            }
        }
        
    }
    
    func getNumberOfRows() -> Int {
        return arrayFiltered.count
    }
    
    func getNextController(index: Int) -> UIViewController {
        let nextController =  ModelYearViewModel(brand: selectedBrand, model: arrayFiltered[index])
        return ViewController.setView(viewModel: nextController)
    }
    
    func getTitleForCell(at index: Int) -> String {
        return arrayFiltered[index].name
    }
    
    func getViewTitle() -> String {
        return "Modelos \(selectedBrand.name!)"
    }
}
