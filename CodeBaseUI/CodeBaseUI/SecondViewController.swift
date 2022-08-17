//
//  SecondViewController.swift
//  CodeBaseUI
//
//  Created by 유연탁 on 2022/08/17.
//

import UIKit

class SecondViewController: UIViewController {

    let titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "strawberry moon"
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let playImageview: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "music.note.list")
        view.tintColor = .white
        return view
    }()
    
    let artistLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "아이유"
        view.textColor = .white
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    let albumImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "album")
        return view
    }()
    
    let heartButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.setTitle("  101,354", for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let shareButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let similarMusicButton: UIButton = {
        let view = UIButton()
        view.setTitle("유사곡", for: .normal)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.tintColor = .white
        return view
    }()
    
    let lyricsLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.text = """
        달이 익어가니 서둘러 젊은 피야
        민들레 한 송이 들고
        """
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 18)
        return view
    }()
    
    let downButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let settingButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let backButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let playButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "play.fill"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let forwardButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let progressBar: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = .green
        view.progress = 0.1
        return view
    }()
    
    let shuffleButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "shuffle"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let repeatButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "repeat"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let volumButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "speaker.wave.3.fill"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let listButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "list.triangle"), for: .normal)
        view.tintColor = .white
        return view
    }()
    
    let detailButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        view.tintColor = .white
        view.transform = view.transform.rotated(by: .pi/2) 
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        
        configureUI()
    }
    
    func configureUI() {
    
        [titleLabel, playImageview, artistLabel, albumImageView, heartButton, shareButton, similarMusicButton, lyricsLabel, downButton, backButton, playButton, forwardButton, progressBar, shuffleButton, repeatButton, listButton, volumButton, detailButton].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(180)
            make.height.equalTo(20)
        }
        
        playImageview.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top).offset(0)
            make.trailing.equalTo(titleLabel.snp.leading).offset(0)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        artistLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
        albumImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).multipliedBy(0.8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(albumImageView.snp.width).multipliedBy(1)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(albumImageView.snp.bottom).offset(16)
            make.leading.equalTo(albumImageView.snp.leading).offset(0)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.top).offset(0)
            make.trailing.equalTo(albumImageView.snp.trailing).offset(0)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        similarMusicButton.snp.makeConstraints { make in
            make.top.equalTo(heartButton.snp.top).offset(0)
            make.trailing.equalTo(shareButton.snp.leading).offset(-8)
            make.width.equalTo(60)
            make.height.equalTo(36)
        }
        
        lyricsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(heartButton.snp.bottom).offset(40)
            make.height.equalTo(80)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-40)
        }
        
        downButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top).offset(0)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(progressBar.snp.bottom).offset(40)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        backButton.snp.makeConstraints { make in
            make.trailing.equalTo(playButton.snp.leading).offset(-40)
            make.top.equalTo(playButton.snp.top).offset(0)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.leading.equalTo(playButton.snp.trailing).offset(40)
            make.top.equalTo(playButton.snp.top).offset(0)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        progressBar.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(lyricsLabel.snp.bottom).offset(40)
            make.width.equalTo(300)
            make.height.equalTo(8)
        }
        
        shuffleButton.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.top).offset(-12)
            make.leading.equalTo(progressBar.snp.trailing).offset(16)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        repeatButton.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.top).offset(-12)
            make.trailing.equalTo(progressBar.snp.leading).offset(-16)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        volumButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.top.equalTo(playButton.snp.top).offset(0)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        listButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.top.equalTo(playButton.snp.top).offset(0)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        detailButton.snp.makeConstraints { make in
            make.trailing.equalTo(downButton.snp.trailing).offset(0)
            make.top.equalTo(downButton.snp.bottom).offset(8)
            make.width.equalTo(36)
            make.height.equalTo(36)
        }
        
        
    }
}
