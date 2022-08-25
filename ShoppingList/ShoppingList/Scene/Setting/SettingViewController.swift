//
//  SettingViewController.swift
//  ShoppingList
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

import Zip

class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        navigationItem.title = "Setting"
        
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
    }
    
    @objc func backupButtonClicked() {
        var urlPaths = [URL]()
        
        guard let path = documentDirectoryPath() else { return }
        
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else { return }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "ShoppingList")
            showActivityViewController()
        } catch {
            print("압축 실패")
        }
        
    }
    
    func showActivityViewController() {
        guard let path = documentDirectoryPath() else { return }
        
        let backupFileURL = path.appendingPathComponent("ShoppingList.zip")
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func restoreButtonClicked() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
    }
    
    func restoreAlert(text: String) {
        let alert = UIAlertController(title: "\(text)", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { alert in
            
            let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
            let sceneDelegate = windowScene?.delegate as? SceneDelegate
            let vc = ShoppingListViewController()
            let nav = UINavigationController(rootViewController: vc)

            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension SettingViewController: UIDocumentPickerDelegate {
   
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else { return }
        
        guard let path = documentDirectoryPath() else { return }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("ShoppingList.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.restoreAlert(text: "완료되었습니다.")
                })
            } catch {
                //압축해제 실패
            }
        } else {
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("ShoppingList.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    self.restoreAlert(text: "완료되었습니다.")
                })
            } catch {
                //압축해제 실패
            }
            
        }
        
        
    }
}
