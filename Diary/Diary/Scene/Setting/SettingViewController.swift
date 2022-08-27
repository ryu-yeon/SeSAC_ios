//
//  SettingViewController.swift
//  Diary
//
//  Created by 유연탁 on 2022/08/25.
//

import UIKit

import Zip

class SettingViewController: BaseViewController {
    
    let mainView = SettingView()
    
    var backupList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    override func configure() {
        navigationItem.title = "Setting"
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reusableIdentifier)
        mainView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
        mainView.restoreButton.addTarget(self, action: #selector(restoreButtonClicked), for: .touchUpInside)
        backupList.append(contentsOf: fetchDocumentZipFile())
    }
    
    @objc func backupButtonClicked() {
        
        var urlPaths = [URL]()
        
        //도규먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            //Alert 도큐먼트 위치에 오류
            showAlertMessage(text: "도큐먼트 위치 오류")
            return
        }
        
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            //Alert 백업파일 X
            showAlertMessage(text: "백업파일 존재X")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        //백업 파일을 압축
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSacDiary_1")
            print("Archive Location: \(zipFilePath)")
            
            //ACtivityViewController
            showActivityViewController()
        } catch {
            //Alert 압축실패
            showAlertMessage(text: "압축실패")
        }
    }
    
    func showActivityViewController() {
        
        guard let path = documentDirectoryPath() else {
            //Alert 도큐먼트 위치에 오류
            showAlertMessage(text: "도큐먼트 위치 오류")
            return
        }
        
        let backupFileURL = path.appendingPathComponent("SeSacDiary_1.zip")
        
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
            let vc = HomeViewController()
            let nav = UINavigationController(rootViewController: vc)

            sceneDelegate?.window?.rootViewController = nav
            sceneDelegate?.window?.makeKeyAndVisible()
            
        
        }
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reusableIdentifier, for: indexPath) as? SettingTableViewCell else { return SettingTableViewCell() }
        
        cell.dataLabel.text = backupList[indexPath.row]
        return cell
        
    }
}

extension SettingViewController: UIDocumentPickerDelegate {

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {

        guard let selectedFileURL = urls.first else {
            showAlertMessage(text: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlertMessage(text: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        //path + 파일
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            let fileURL = path.appendingPathComponent("SeSacDiary_1.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.restoreAlert(text: "복구가 완료되었습니다.")
                })
            } catch {
                showAlertMessage(text: "압축 해제에 실패했습니다.")
            }
            
        } else {
            
            do {
                
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("SeSacDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress: \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print("unzippedFile: \(unzippedFile)")
                    self.restoreAlert(text: "복구가 완료되었습니다.")
                    
                })
                
            } catch {
                showAlertMessage(text: "압축 해제에 실패했습니다.")
            }
            
        }
    }
}
