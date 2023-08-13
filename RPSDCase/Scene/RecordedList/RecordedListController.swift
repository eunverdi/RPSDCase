//
//  RecordedListController.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 2.06.2023.
//

import UIKit
import AVKit
import RealmSwift

protocol RecordedListInterface: AnyObject {
    func configureInformationView(url: URL)
    func prepareDidLoad()
    func prepareWillAppear()
}

class RecordedListController: UIViewController {
    
    var viewModel: RecordedListViewModel = RecordedListViewModel()
    var tableView: UITableView!
    let playerViewController = AVPlayerViewController()
    let informationView = ShotInformationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
}

extension RecordedListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.videoURLs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CellRowHeight.RecordedListCellRowHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.cellForItem(tableView: tableView, at: indexPath)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        viewModel.editingStyle(tableView: tableView, editingStyle: editingStyle, at: indexPath)
    }
    
}

extension RecordedListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let videoURL = viewModel.videoURLs[indexPath.row]
        let player = AVPlayer(url: videoURL)
        configureInformationView(url: videoURL)
        playerViewController.player = player
        UIView.animate(withDuration: 1.1) {
            self.playerViewController.contentOverlayView?.addSubview(self.informationView)
        }
        
        self.present(playerViewController, animated: true) {
            self.playerViewController.player!.play()
        }
    }
}

extension RecordedListController: RecordedListInterface {
    func prepareDidLoad() {
        
        self.title = "Recorded List"
        
        viewModel.loadVideos()
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func prepareWillAppear() {
        viewModel.loadVideos()
        tableView.reloadData()
    }
    
    func configureInformationView(url: URL) {
        let videoFileName = url.lastPathComponent
        
        DatabaseManager.shared.fetchData(withPrimaryKey: videoFileName, objectType: VideoRealm.self) { response in
            if let response = response {
                DispatchQueue.main.async {
                    self.informationView.pointLabel.text = "\(response.point)"
                    self.informationView.segmentLabel.text = "\(response.segment)"
                    self.informationView.inOutLabel.text = "\(response.inOut)"
                    self.informationView.shotPosXLabel.text = "\(response.shotPosX)"
                    self.informationView.shotPosYLabel.text = "\(response.shotPosY)"
                }
            } else {
                print("RecordedListController: An error happened")
            }
        }
    }
}
