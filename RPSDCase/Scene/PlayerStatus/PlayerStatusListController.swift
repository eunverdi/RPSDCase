//
//  PlayerStatusController.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 2.06.2023.
//

import UIKit
import AVKit
import RealmSwift

class PlayerStatusListController: UIViewController {
    
    var viewModel: PlayerStatusViewModel!
    var tableView: UITableView!
    
    let notificationCenter = NotificationCenter.default
    var playerName: [String] = []
    
    var userShotDatas: [ShotRealm] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nil, bundle: nil)
        notificationCenter.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name(NotificationNames.UserShotInformationNotificationName.rawValue), object: nil)
        viewModel = PlayerStatusViewModel()
        tableView = UITableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Player Status"
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PlayerStatusCell.self, forCellReuseIdentifier: PlayerStatusCell.identifier)
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let primaryKey = notification.userInfo?["primary"] as? String,
           let name = notification.userInfo?["name"] as? String {
            self.playerName.append(name)
            viewModel.fetchDataWith(primaryKey: primaryKey) { response, error in
                if let error = error {
                    print(error)
                }
                if let response = response {
                    for shot in response {
                        let containsData = self.userShotDatas.contains { $0.id == shot.id }
                        if !containsData {
                            self.userShotDatas.append(shot)
                        }
                    }
                }
            }
        }
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name(NotificationNames.UserShotInformationNotificationName.rawValue), object: nil)
        
        tableView.reloadData()
    }
}

extension PlayerStatusListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CellRowHeight.PlayerStatusListCellRowHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userShotDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerStatusCell.identifier, for: indexPath) as? PlayerStatusCell else { return UITableViewCell() }
        cell.configureCellLabelText(name: self.playerName[indexPath.row], userDatas: self.userShotDatas[indexPath.row])
        
        return cell
    }
}
