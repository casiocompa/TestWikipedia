//
//  PlacesListViewController.swift
//  TestWikipedia
//
//  Created by Ruslan Kasian Dev_2 on 29.10.2023.
//

import UIKit
import TinyConstraints
import RealmSwift

final class PlacesListViewController: UIViewControllerCoordinator {
    
    //MARK: - Properties
    private var presenter = PlacesPresenter()
    private var placeList: Results<PlaceObject>?
    private var notificationToken: NotificationToken?
    
    //MARK: - UI
    private lazy var plusBtn : UIButton = {
        let btn = UIButton()
        btn.layer.backgroundColor = UIColor.clear.cgColor
        
        let imageConfiguration = UIImage.SymbolConfiguration(
            pointSize: 25,
            weight: .light,
            scale: .large
        )
        btn.setImage(
            UIImage(
                systemName: "plus",
                withConfiguration: imageConfiguration
            ),
            for: .normal
        )
       
        btn.tintColor = .systemBlue
        return btn
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshView), for: .valueChanged)
        return refreshControl
    }()
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(PlacesListTableViewCell.self, forCellReuseIdentifier: PlacesListTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = true
        tableView.allowsMultipleSelection = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        tableView.automaticallyAdjustsScrollIndicatorInsets = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.addSubview(refreshControl)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    @objc func addNew(){
        let alertController = UIAlertController(
            title: "Enter the place data",
            message: nil,
            preferredStyle: .alert
        )
        
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "long"
            textField.keyboardType = .numbersAndPunctuation
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "lat"
            textField.keyboardType = .numbersAndPunctuation
        }
        
        let saveAction = UIAlertAction(
            title: "Add",
            style: .default
        ) { [weak self] _ in
            self?.craatePlace(
                name: alertController.textFields?[0].text,
                latitude: alertController.textFields?[1].text,
                longitude: alertController.textFields?[2].text
            )
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(
            saveAction
        )
        alertController.addAction(
            cancelAction
        )
        
        present(
            alertController,
            animated: true,
            completion: nil
        )
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        
        self.setUpNavBar()
        self.setUpLayout()
        self.setupDataModel()
    }
    
}

//MARK: -
private extension PlacesListViewController {
    
    func setupDataModel() {
        
        self.placeList = realmDB.readAllObjects(PlaceObject.self)
        
        notificationToken = placeList?.observe { [weak self] changes in
            guard let self = self else {
                return
            }
            
            switch changes {
            case .initial, .update:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .error(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        loadData()
    }
    
    @objc func refreshView() {
        loadData()
    }
    
    func loadData() {
        presenter.getList { [weak self] _ in
            self?.refreshControl.endRefreshing()
        }
    }
    
    func setUpNavBar(){
        
        self.setUpNavigationTitle(text: "Places")
        self.setUpRightNavBarItem(
            menuBtn: self.plusBtn,
            selector: #selector( self.addNew)
        )
        
    }
    
    func setUpLayout(){
        
        self.tableView.topToSuperview(offset: 20, usingSafeArea: true)
        self.tableView.leadingToSuperview()
        self.tableView.trailingToSuperview()
        self.tableView.bottomToSuperview()
        
    }
    
    func craatePlace(name: String?, latitude: String?, longitude: String?) {

        let place = PlaceObject()
        place.name = name
        place.latitude = latitude?.toDouble ?? 0.0
        place.longitude = longitude?.toDouble ?? 0.0
        
        realmDB.updateObject(place)

    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension PlacesListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.placeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PlacesListTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? PlacesListTableViewCell,
            let place = self.placeList?[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        cell.configure(with: place)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let place = self.placeList?[indexPath.row] else {
            return
        }

        if let url = URL(string: "wikipedia-official://places?lat=\(place.latitude)&long=\(place.longitude)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let place = self.placeList?[indexPath.row] else {
            return
        }

        if editingStyle == .delete {
            realmDB.deleteObject(place)
        }
    }
}
