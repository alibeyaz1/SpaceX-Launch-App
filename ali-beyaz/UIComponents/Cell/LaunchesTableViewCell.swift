//
//  LaunchesTableViewCell.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 28.11.2023.
//

import UIKit
import SnapKit
import Kingfisher

class LaunchesTableViewCell : UITableViewCell{
    
    // MARK: - UI Elements
    
    let bgView = UIView()
    let launchImageView = UIImageView()
    let launchNameLabel = UILabel()
    let arrowButton = UIButton()
    let launchDate = UILabel()
   
    
    
    static let identifier = "LaunchesCell"
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        backgroundColor = .lightText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    
    private func setupViews(){
        
        bgView.layer.cornerRadius = 10
        bgView.backgroundColor = .white
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor(red: 0.95, green: 0.96, blue: 0.98, alpha: 1).cgColor
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.75)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        launchImageView.contentMode = .scaleAspectFill
        launchImageView.translatesAutoresizingMaskIntoConstraints = true
        
        bgView.addSubview(launchImageView)
        launchImageView.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.12)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        arrowButton.setImage(UIImage(named: "btn_forward"), for: .normal)
        bgView.addSubview(arrowButton)
        arrowButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalTo(bgView.snp.centerY)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        
        
        launchNameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        launchNameLabel.textColor = .black
        launchNameLabel.textAlignment = .left
        launchNameLabel.numberOfLines = 0
        
        bgView.addSubview(launchNameLabel)
        launchNameLabel.snp.makeConstraints { make in
            make.left.equalTo(launchImageView.snp.right).offset(16)
            make.top.equalToSuperview().offset(16)
            make.right.equalTo(arrowButton.snp.left).offset(-8)
        }
        
        launchDate.font = UIFont.systemFont(ofSize: 14)
        launchDate.textColor = .gray
        launchDate.textAlignment = .left
        launchDate.numberOfLines = 1
        
        bgView.addSubview(launchDate)
        launchDate.snp.makeConstraints { make in
            make.left.equalTo(launchImageView.snp.right).offset(16)
            make.bottom.equalToSuperview().offset(-16)        }
        
    }
    
    func configure(with launch: Launch) {
        
        if let imageURL = URL(string: launch.links.patch.small ?? "") {
            launchImageView.kf.setImage(with: imageURL, completionHandler: { result in
                switch result {
                case .success(let value):
                    print("Image downloaded successfully: \(value)")
                case .failure(let error):
                    print("Image download failed: \(error)")
                }
            })
        } else {
            print("Image URL is nil or empty.")
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: launch.dateUTC)

        launchNameLabel.text = launch.name
        launchDate.text = date?.returnString()
    }
}
