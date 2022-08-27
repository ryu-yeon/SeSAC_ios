//
//  FileManager+Extension.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

extension UIViewController {
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return documentDirectory
    }
    
    
    //도큐먼트에 잇는 이미지 가져오기
    //이미지가 없을 수도 있으니 옵셔널
    func loadImageFromDocument(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil } // 내 앱에 해당되는 도큐먼트 폴더가 있니?
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 이걸로 도큐먼트에 저장해줌 세부파일 경로(이미지 저장위치)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "xmark")
        }
        
        let image = UIImage(contentsOfFile: fileURL.path)
        return image
    }
    
    func removeImageFromDocument(fileName: String) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // 내 앱에 해당되는 도큐먼트 폴더가 있늬?
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch let error {
            print(error)
        }
    }
    
    func saveImageToDocument(fileName: String, image: UIImage) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return } // 내 앱에 해당되는 도큐먼트 폴더가 있늬?
        let fileURL = documentDirectory.appendingPathComponent(fileName) // 이걸로 도큐먼트에 저장해줌 세부파일 경로(이미지 저장위치)
        guard let data = image.jpegData(compressionQuality: 0.5) else { return } //용량을 줄이기 위함 용량을 키우는 건 못하고 작아질수밖에 없음
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    func fetchDocumentZipFile() -> [String] {
        
        do {
            
            guard let path = documentDirectoryPath() else { return [] }
            
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
            
            print("docs: \(docs)")
            
            let zip = docs.filter { $0.pathExtension == "zip" }
            
            print("zip: \(zip)")
            
            let result = zip.map { $0.lastPathComponent }
            print("result: \(result)")
            return result
            
        } catch {
            print("Error")
            return []
        }
        return []
    }
    
}
