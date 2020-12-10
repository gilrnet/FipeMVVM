//
//  ViewController.swift
//  Fipe_MVVM
//
//  Created by Gilvã Lopes on 10/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: ViewModelProtocol!
    
//  MARK: - Outlets
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableViewList: UITableView!

    class func setView(viewModel: ViewModelProtocol) -> ViewController {
        let main = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        main.viewModel = viewModel
        return main
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTitle.text = viewModel.getViewTitle()
        tableViewList.delegate = self
        tableViewList.dataSource = self
        searchBar.delegate = self
        
        loadData()
        
        title = "Consulta de Veículos"
    }

    func loadData() {
        viewModel.loadData { success in
            self.tableViewList.reloadData()
        }

    }

}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextController = viewModel.getNextController!(index: indexPath.row)
        navigationController?.pushViewController(nextController, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.getTitleForCell(at: indexPath.row)
        return cell
    }
    
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter?(terms: searchText)
        tableViewList.reloadData()
    }
}

