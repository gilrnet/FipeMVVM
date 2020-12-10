//
//  BrandViewModel.swift
//  Fipe_MVVM
//
//  Created by Gilvã Lopes on 10/12/20.
//

import Foundation
import UIKit

class BrandViewModel: ViewModelProtocol {

    var arrayBrands = [Brand]()
    var arrayFiltered = [Brand]()
    var apiManager = APIManager()
    
//    func getArray() -> [Brand?] {
//        return arrayFiltered
//    }
    
    func filter(terms: String) {
        if terms.count == 0 {
            arrayFiltered = arrayBrands
            return
        }
        
        self.arrayFiltered = arrayBrands.filter( { brand in
            let brandUpper = brand.name.uppercased()
            return brandUpper.contains(terms.uppercased())
        })
    }
    
    func loadData(onComplete: @escaping (Bool) -> Void) {
        apiManager.request(url: "https://parallelum.com.br/fipe/api/v1/carros/marcas") { (json, jsonArray, string) in
            if let jsonArray = jsonArray {
                var brands = [Brand]()
                for item in jsonArray {
                    brands.append(Brand(fromDictionary: item))
                }
                self.arrayBrands = brands
                self.arrayFiltered = brands
                onComplete(true)
                return
            }
            onComplete(false)
        }
    }
    
    func getNumberOfRows() -> Int {
        arrayFiltered.count
    }
    
    func getNextController(index: Int) -> UIViewController {
        let nextView = ModelsViewModel(brand: arrayFiltered[index])
        return ViewController.setView(viewModel: nextView)
    }
    
    func getTitleForCell(at index: Int) -> String {
        return arrayFiltered[index].name
    }
    
    func getViewTitle() -> String {
        return "Marcas"
    }
    
}
