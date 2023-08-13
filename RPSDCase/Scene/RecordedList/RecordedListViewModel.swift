//
//  RecordedListViewModel.swift
//  RPSDCase
//
//  Created by Ensar Batuhan Ünverdi on 2.06.2023.
//

import UIKit

protocol RecordedListViewModelInterface: AnyObject {
    var view: RecordedListInterface? { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    
    func loadVideos()
    func fetchVideos() -> [URL]
    func deleteVideo(at index: Int) throws
    func getFileCreationDate(for url: URL) -> Date
    func cellForItem(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
    func editingStyle(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, at indexPath: IndexPath)
}


final class RecordedListViewModel {
    
    weak var view: RecordedListInterface?
    private(set) var videoURLs = [URL]()
}

extension RecordedListViewModel: RecordedListViewModelInterface {
    
    func loadVideos() {
        videoURLs = fetchVideos()
    }
    
    func fetchVideos() -> [URL] {
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
    
    func getFileCreationDate(for url: URL)-> Date {
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
    
    func viewDidLoad() {
        view?.prepareDidLoad()
    }
    
    func viewWillAppear() {
        view?.prepareWillAppear()
    }
    
    func cellForItem(tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        
        let videoURL = videoURLs[indexPath.row]
        let creationDate = getFileCreationDate(for: videoURL)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: creationDate)
        
        cell.textLabel?.text = dateString
        return cell
    }
    
    func editingStyle(tableView: UITableView, editingStyle: UITableViewCell.EditingStyle, at indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                try deleteVideo(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error while deleting file: \(error)")
            }
        }
    }
}

