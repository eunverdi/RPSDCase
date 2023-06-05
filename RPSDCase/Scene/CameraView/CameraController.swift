//
//  CameraController.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 2.06.2023.
//

import UIKit
import AVFoundation

final class CameraController: UIViewController {
    
    private var viewModel: CameraViewModel!
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private let informationView = ShotInformationView()
    
    var primaryKey: String = ""
    var name: String = ""
    
    var userDatas: [PlayerInformationResponseRealm] = []
    
    private lazy var recordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.borderWidth = 4
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.cornerRadius = 50
        button.addTarget(self, action: #selector(startStopRecording), for: .touchUpInside)
        return button
    }()
    
    let notificationCenter = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = CameraViewModel()
        setupPreviewLayer()
        view.addSubview(recordButton)
        tabBarController?.delegate = self
        
        NSLayoutConstraint.activate([
            recordButton.widthAnchor.constraint(equalToConstant: 100),
            recordButton.heightAnchor.constraint(equalToConstant: 100),
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
        
        self.view.addSubview(informationView)
        informationView.translatesAutoresizingMaskIntoConstraints = false
        informationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        informationView.alpha = 0
        fetchAllData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func fetchAllData() {
        viewModel.fetchAllDataFromDatabase { [weak self] response, error in
            guard let self = self else { return }
            if let error = error {
                print(error)
            }
            
            if let response = response {
                self.userDatas = response
            }
        }
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: viewModel.captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.bounds
        view.layer.addSublayer(previewLayer!)
    }
    
    private func configureInfoView() {
        let playerIndex = Int.random(in: 0...userDatas.count - 1)
        let shotsIndex = Int.random(in: 0...userDatas[playerIndex].shots.count - 1)
        
        self.primaryKey = userDatas[playerIndex].shots[shotsIndex].id
        self.name = "\(userDatas[playerIndex].name) \(userDatas[playerIndex].surname)"
        DispatchQueue.main.async {
            self.informationView.pointLabel.text = "\(self.userDatas[playerIndex].shots[shotsIndex].point)"
            self.informationView.segmentLabel.text = "\(self.userDatas[playerIndex].shots[shotsIndex].segment)"
            self.informationView.inOutLabel.text = "\(self.userDatas[playerIndex].shots[shotsIndex].inOut)"
            self.informationView.shotPosXLabel.text = "\(self.userDatas[playerIndex].shots[shotsIndex].shotPosX)"
            self.informationView.shotPosYLabel.text = "\(self.userDatas[playerIndex].shots[shotsIndex].shotPosY)"
        }
        
        let notification = Notification(name: Notification.Name(NotificationNames.UserShotInformationNotificationName.rawValue), object: nil, userInfo: ["primary" : self.primaryKey, "name": self.name])
        notificationCenter.post(notification)
    }
    
    @objc private func startStopRecording() {
        viewModel.startStopRecording()
        recordButton.backgroundColor = viewModel.isRecording ? .red : .gray
        UIView.animate(withDuration: 1.1) {
            self.informationView.alpha = self.viewModel.isRecording ? 0 : 1
        }
        if !viewModel.isRecording {
            configureInfoView()
        }
    }
}

extension CameraController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController != self {
            self.informationView.alpha = 0
            viewModel.isRecording = false
        }
    }
}

