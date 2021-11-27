//
//  ViewController.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import UIKit

protocol ItemViewDisplayable: AnyObject {
    func displayItems(items: [Item])
    func displayError(message: String)
    func displayDetails(for item: Item)
}

class ItemViewController: UIViewController {
    
    private var items = [Item]() {
        didSet {
            tableView?.reloadData()
            updateView()
        }
    }
    
    private var cellIdentifier = "ItemListTableViewCell"
    var presenter: ItemPresentable?
    
    @IBOutlet weak private(set) var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak private(set) var tableView: UITableView?
    @IBOutlet weak private(set) var labelEmpty: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        //start fetching Items
        showLoading()
        presenter?.fetchItems()
    }
}

private extension ItemViewController {
    func configureView() {
        title = "List"
        
        tableView?.register(UINib(nibName: cellIdentifier, bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        tableView?.estimatedRowHeight = 60
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.tableFooterView = UIView(frame: CGRect.zero)
        tableView?.accessibilityIdentifier = "itemListTableView"
    }
    
    func updateView() {
        tableView?.isHidden = items.isEmpty
        labelEmpty?.isHidden = !items.isEmpty
    }
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicator?.isHidden = false
        activityIndicator?.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicator?.isHidden = true
        activityIndicator?.stopAnimating()
    }
}

extension ItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ItemListTableViewCell else { return UITableViewCell() }
        cell.item = items[indexPath.row]
        return cell
    }
}

extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.presentDetails(for: items[indexPath.row], navigationController: navigationController)
    }
}

extension ItemViewController: ItemViewDisplayable {
    func displayItems(items: [Item]) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            self?.items = items
        }
    }
    
    func displayError(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.hideLoading()
            Alert.showErrorMessage(message: message)
        }
    }
    
    func displayDetails(for item: Item) {
        presenter?.presentDetails(for: item, navigationController: self.navigationController)
    }
}
