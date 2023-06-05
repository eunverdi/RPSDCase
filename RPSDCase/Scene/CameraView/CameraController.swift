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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: viewModel.captureSession!)
        previewLayer?.videoGravity = .resizeAspectFill
        previewLayer?.frame = view.bounds
        view.layer.addSublayer(previewLayer!)
    }
    
    private func configureInfoView() {
        let playerIndex = Int.random(in: 0...viewModel.userDatasFromDatabase.count - 1)
        let shotsIndex = Int.random(in: 0...viewModel.userDatasFromDatabase.count - 1)
        
        self.primaryKey = viewModel.userDatasFromDatabase[playerIndex].shots[shotsIndex].id
        self.name = "\(viewModel.userDatasFromDatabase[playerIndex].name) \(viewModel.userDatasFromDatabase[playerIndex].surname)"
        DispatchQueue.main.async {
            self.informationView.pointLabel.text = "\(self.viewModel.userDatasFromDatabase[playerIndex].shots[shotsIndex].point)"
            self.informationView.segmentLabel.text = "\(self.viewModel.userDatasFromDatabase[playerIndex].shots[shotsIndex].segment)"
            self.informationView.inOutLabel.text = "\(self.viewModel.userDatasFromDatabase[playerIndex].shots[shotsIndex].inOut)"
            self.informationView.shotPosXLabel.text = "\(self.viewModel.userDatasFromDatabase[playerIndex].shots[shotsIndex].shotPosX)"
            self.informationView.shotPosYLabel.text = "\(self.viewModel.userDatasFromDatabase[playerIndex].shots[shotsIndex].shotPosY)"
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

