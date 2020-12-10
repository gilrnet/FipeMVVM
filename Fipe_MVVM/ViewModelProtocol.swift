//
//  ViewModelProtocol.swift
//  Fipe_MVVM
//
//  Created by Gilvã Lopes on 10/12/20.
//

import Foundation
import UIKit

@objc protocol ViewModelProtocol {
    
    @objc optional func filter(terms: String)
    
    func loadData(onComplete: @escaping (Bool) -> Void)
    
    func getNumberOfRows() -> Int
    
    @objc optional func getNextController(index: Int) -> UIViewController
    
    func getTitleForCell(at index: Int) -> String
    
    func getViewTitle() -> String
    
    @objc optional func getArray() -> [Any] 
    
}
