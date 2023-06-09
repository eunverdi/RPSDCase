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
            
            let sortedURLs = videoURLs.sorted(by: { (url1, url2) -> Bool in
                let creationDate1 = getFileCreationDate(for: url1)
                let creationDate2 = getFileCreationDate(for: url2)
                return creationDate1 > creationDate2
            })
            
            return sortedURLs
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
    
    func getFileCreationDate(for url: URL) -> Date {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let creationDate = attributes[.creationDate] as? Date {
                return creationDate
            }
        } catch {
            print("Error retrieving file attributes: \(error)")
        }
        
        return Date()
    }
}

