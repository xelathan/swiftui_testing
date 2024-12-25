//
//  FileManagerViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/24/24.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    let profileImageFolderName = "profile_pictures"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent(profileImageFolderName).path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("SUCCESS CREATING FOLDER")
            } catch let error {
                print("ERROR: \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(profileImageFolderName)
            .path else {
            print("ERROR GETTING PATH")
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            print("SUCCESS DELETING FOLDER")
        } catch let error {
            print(error)
        }
    }
    
    func saveImage(image: UIImage, name: String) {
        guard let data = image.pngData(),
        let path = getImagePath(name: name) else {
            print("ERROR GETTING IMAGE DATA")
            return
        }
        
        do {
            try data.write(to: path)
            print(path)
            print("SUCCESS")
        } catch let error {
            print("ERROR: \(error)")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getImagePath(name: name)?.path,
        FileManager.default.fileExists(atPath: path) else { return nil }
        
        return UIImage(contentsOfFile: path)
    }
    func deleteImage(name: String) {
        guard let path = getImagePath(name: name),
              FileManager.default.fileExists(atPath: path.path) else {
            print("ERROR GETTING PATH")
            return
        }
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch let err {
            print("ERROR: \(err)")
        }
    }
    
    func getImagePath(name: String) -> URL? {
        guard let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(profileImageFolderName)
            .appendingPathComponent("\(name).png") else {
            print("ERROR GETTING PATH")
            return nil
        }
        
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    let imageName: String = "golang-piano"
    let manager = LocalFileManager.instance
    
    @Published var image: UIImage? = nil
    
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        self.image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        self.image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let imageToUse = image else { return }
        manager.saveImage(image: imageToUse, name: imageName)
    }
    
    func deleteImage() {
        manager.deleteImage(name: imageName)
        manager.deleteFolder()
        getImageFromFileManager()
    }
}
