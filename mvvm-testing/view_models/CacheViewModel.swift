//
//  CacheViewModel.swift
//  mvvm-testing
//
//  Created by Alex Tran on 12/24/24.
//

import Foundation
import SwiftUI

class CacheManager {
    static let instance = CacheManager()
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        
        return cache
    }()
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("ADDED TO CACHE")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("REMOVED FROM CACHE")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
    
    private init() {}
    
}

class CacheViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    
    private let imageName = "golang-piano"
    private let cacheManager = CacheManager.instance
    
    init() {
        getImageFromAssets()
    }
    
    func getImageFromAssets() {
        self.image = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let imageToSave = image else { return }
        cacheManager.add(image: imageToSave, name: imageName)
    }
    
    func removeFromCache() {
        cacheManager.remove(name: imageName)
    }
    
    func getImageFromCache() {
        self.cachedImage = cacheManager.get(name: imageName)
    }
}
