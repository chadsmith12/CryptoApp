//
//  LocalFileManager.swift
//  CryptoApp
//
//  Created by Chad Smith on 9/27/21.
//

import Foundation
import UIKit

class LocalFileManager {
    static let instance = LocalFileManager()
    
    private init() { }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        createFolder(folderName: folderName)
        
        guard let data = image.pngData(),
        let url = getUrlForImage(imageName: imageName, folderName: folderName)
        else {
            return
        }
        
        do {
            try data.write(to: url)
        }
        catch {
            print("Error saving image Image Name: \(imageName): \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard let url = getUrlForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
                  return nil
              }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolder(folderName: String) {
        guard let url = getUrlForFolder(name: folderName) else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating directory - Error: \(error) Folder Name: \(folderName)")
            }
        }
    }
    
    private func getUrlForFolder(name: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(name)
    }
    
    private func getUrlForImage(imageName: String, folderName: String) -> URL? {
        guard let url = getUrlForFolder(name: folderName) else {
            return nil
        }
        
        return url.appendingPathComponent("\(imageName).png")
    }
}
