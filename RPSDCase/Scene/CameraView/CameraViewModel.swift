//
//  CameraViewModel.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 2.06.2023.
//

import UIKit
import AVFoundation
import RealmSwift

protocol CameraViewModelInterface: AnyObject {
    
    var view: CameraControllerInterface? { get set }
    func viewDidLoad()
}

final class CameraViewModel: NSObject {
    
    weak var view: CameraControllerInterface?
    
    private(set) var captureSession: AVCaptureSession?
    private var videoOutput: AVCaptureMovieFileOutput?
    var isRecording = false
    let notificationCenter = NotificationCenter.default
    
    var userDatasFromDatabase: [PlayerInformationResponseRealm] = []
    private var userShotInformation: ShotRealm?
    
    private var userDatasResponse: [PlayerInformationResponse] = [] {
        didSet {
            let realmObjects = userDatasResponse.map { data in
                let realmData = PlayerInformationResponseRealm()
                realmData.name = data.name
                realmData.surname = data.surname
                
                let realmShots = data.shots.map({ ShotRealm(shot: $0 )})
                realmData.shots.append(objectsIn: realmShots)
                
                return realmData
            }
            DatabaseManager.shared.saveData(objects: realmObjects)
            DispatchQueue.main.async {
                self.fetchAllDataFromDatabase()
            }
        }
    }
    
    override init() {
        super.init()
        fetchData()
        setupSession()
        notificationCenter.addObserver(self, selector: #selector(handleNotification(_:)), name: Notification.Name(NotificationNames.UserShotInformationNotificationName.rawValue), object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let primaryKey = notification.userInfo?["primary"] as? String {
            DatabaseManager.shared.fetchData(withPrimaryKey: primaryKey, objectType: ShotRealm.self) { response in
                if let response = response {
                    DispatchQueue.main.async {
                        self.userShotInformation = response
                    }
                } else {
                    print("An error happened while fetching data from Realm")
                }
            }
        }
        
    }
    
    private func setupSession() {
        captureSession = AVCaptureSession()
        
        guard let videoDevice = AVCaptureDevice.default(for: .video),
              let videoInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            fatalError("Unable to access camera")
        }
        
        if captureSession!.canAddInput(videoInput) {
            captureSession!.addInput(videoInput)
        }
        
        videoOutput = AVCaptureMovieFileOutput()
        
        if captureSession!.canAddOutput(videoOutput!) {
            captureSession!.addOutput(videoOutput!)
        }
        
        DispatchQueue.global().async { [weak self] in
            self?.captureSession?.startRunning()
        }
    }
    
    func startStopRecording() {
        if isRecording {
            stopRecording()
        } else {
            startRecording()
        }
        
        isRecording.toggle()
    }
    
    private func createOutputURL() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let outputURL = documentsDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mov")
        return outputURL
    }
    
    private func startRecording() {
        let outputURL = createOutputURL()
        startVideoRecording(outputURL: outputURL)
    }
    
    private func startVideoRecording(outputURL: URL) {
        videoOutput?.startRecording(to: outputURL, recordingDelegate: self)
    }
    
    private func stopRecording() {
        videoOutput?.stopRecording()        
    }
}


extension CameraViewModel: AVCaptureFileOutputRecordingDelegate {
    func fileOutput(_ output: AVCaptureFileOutput,
                    didStartRecordingTo fileURL: URL,
                    from connections: [AVCaptureConnection]) {
        print("Started recording to \(fileURL)")
    }
    
    func fileOutput(_ output: AVCaptureFileOutput,
                    didFinishRecordingTo outputFileURL: URL,
                    from connections: [AVCaptureConnection],
                    error: Error?) {
        if let userShotInformation = userShotInformation {
            let videoRealm = VideoRealm()
            let videoFileName = outputFileURL.lastPathComponent
            videoRealm.videoURL = videoFileName
            videoRealm.inOut = userShotInformation.inOut
            videoRealm.point = userShotInformation.point
            videoRealm.segment = userShotInformation.segment
            videoRealm.shotPosX = userShotInformation.shotPosX
            videoRealm.shotPosY = userShotInformation.shotPosY
            
            DatabaseManager.shared.saveData(object: videoRealm)
        }
        
        if let error = error {
            print("Failed to record video: \(error.localizedDescription)")
        } else {
            print("Successfully recorded video to \(outputFileURL)")
        }
    }
}

extension CameraViewModel {
    func fetchData() {
        NetworkManager.shared.request(type: [PlayerInformationResponse].self, url: NetworkHelper.shared.baseURL, method: .get) { response in
            switch response {
            case .success(let response):
                self.userDatasResponse = response
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchAllDataFromDatabase() {
        DatabaseManager.shared.fetchAllData(type: PlayerInformationResponseRealm.self) { response, error in
            if let response = response {
                DispatchQueue.main.async {
                    self.userDatasFromDatabase = Array(response)
                }
            } else if let error = error {
                print("An error happened: \(error)")
            }
        }
    }
}

extension CameraViewModel: CameraViewModelInterface {
    func viewDidLoad() {
        view?.prepareViewDidLoad()
    }
    
}
