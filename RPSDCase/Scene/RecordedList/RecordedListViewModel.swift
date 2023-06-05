//
//  RecordedListViewModel.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 2.06.2023.
//

import UIKit

class RecordedListViewModel {
    private(set) var videoURLs = [URL]()
    
    func loadVideos() {
        videoURLs = fetchVideos()
    }
    
    private func fetchVideos() -> [URL] {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            let videoURLs = fileURLs.filter { $0.pathExtension == "mov" }
            
            return videoURLs
        } catch {
            print("Error: \(error)")
        }
        
        return []
    }
    
    func deleteVideo(at index: Int) throws {
        let fileURL = videoURLs[index]
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("\(videoURLs[index]) is succesfully delete!")
            videoURLs.remove(at: index)
        } catch {
            print("An error while trying to delete video!")
        }
    }
}

