//
//  NflixView.swift
//  CodeBaseUI
//
//  Created by 유연탁 on 2022/08/20.
//

import UIKit

import SnapKit

class NflixView: BaseView {
    
    var posterImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "movie2")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let nLabel: UILabel = {
        let view = UILabel()
        view.text = "N"
        view.textColor = .white
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 50)
        return view
    }()
    
    let tvprogramButton: UIButton = {
        let view = UIButton()
        view.setTitle("TV 프로그램", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let movieButton: UIButton = {
        let view = UIButton()
        view.setTitle("영화", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return view
    }()
    
    let myfavoriteButton: UIButton = {
        let view = UIButton()
        view.setTitle("내가 찜한 콘텐츠", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return view
    }()

    let playButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "play_normal"), for: .normal)
        view.setImage(UIImage(named: "play_highlighted"), for: .highlighted)
        return view
    }()
    
    let thumnailLabel: UILabel = {
        let view = UILabel()
        view.text = "미리보기"
        view.textColor = .white
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let thunailMovieImageView1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "movie2")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let thunailMovieImageView2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "movie2")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    let thunailMovieImageView3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "movie2")
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    override func configureUI() {
        self.backgroundColor = .black
        
        [posterImageView, nLabel, tvprogramButton, movieButton, myfavoriteButton, playButton, thumnailLabel, thunailMovieImageView1, thunailMovieImageView2, thunailMovieImageView3].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.trailing.leading.equalTo(0)
            make.height.equalTo(self).multipliedBy(0.7)
        }
        
        nLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.top).inset(20)
            make.leading.equalTo(posterImageView.snp.leading).inset(16)
            make.width.height.equalTo(50)
        }
        
        tvprogramButton.snp.makeConstraints { make in
            make.bottom.equalTo(nLabel.snp.bottom).offset(-10)
            make.leading.equalTo(nLabel.snp.trailing).offset(20)
            make.width.equalTo(88)
            make.height.equalTo(20)
        }
        
        movieButton.snp.makeConstraints { make in
            make.top.equalTo(tvprogramButton.snp.top)
            make.leading.equalTo(tvprogramButton.snp.trailing).offset(16)
            make.width.equalTo(40)
            make.height.equalTo(20)
        }
        
        myfavoriteButton.snp.makeConstraints { make in
            make.top.equalTo(tvprogramButton.snp.top)
            make.leading.equalTo(movieButton.snp.trailing).offset(16)
            make.width.equalTo(120)
            make.height.equalTo(20)
        }
        
        playButton.snp.makeConstraints { make in
            make.bottom.equalTo(posterImageView.snp.bottom).inset(16)
            make.centerX.equalTo(self.posterImageView)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        thumnailLabel.snp.makeConstraints { make in
            make.bottom.equalTo(thunailMovieImageView1.snp.top).offset(-16)
            make.top.equalTo(posterImageView.snp.bottom).offset(8)
            make.leading.equalTo(20)
//            make.height.equalTo(20)
        }
        
        thunailMovieImageView1.snp.makeConstraints { make in
            make.leading.equalTo(thumnailLabel.snp.leading)
            make.bottom.equalTo(self).offset(-20)
            make.height.width.equalTo((UIScreen.main.bounds.width - 16 * 4) / 3)
        }
        
        thunailMovieImageView2.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(thunailMovieImageView1.snp.bottom)
            make.height.width.equalTo(thunailMovieImageView1.snp.width)
        }
        
        thunailMovieImageView3.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.bottom.equalTo(thunailMovieImageView1.snp.bottom)
            make.height.width.equalTo(thunailMovieImageView1.snp.width)
        }
    }
}
