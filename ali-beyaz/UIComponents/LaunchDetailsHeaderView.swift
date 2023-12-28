//
//  LaunchDetailsHeaderView.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 29.11.2023.
//

import UIKit
import Kingfisher

class LaunchDetailsHeaderView: UIView {
    
    private var launchImage = UIImageView()
    private var launchName = UILabel()
    var launchDate = UILabel()
    var launchTime = String()
    
 
    init(laungImage : URL, launchName : String, launchTime : String ) {
        super.init(frame: .zero)
        setupUI(laungImage1: laungImage, launchName1: launchName, launchTime1: launchTime)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
    }
    
    private func setupUI(laungImage1 : URL, launchName1 : String,launchTime1 : String) {
        
        launchImage.kf.setImage(with: laungImage1)
        addSubview(launchImage)
        launchImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(50)
        }
        
        launchName.text = launchName1
        launchName.font = UIFont(name: "Inter-Medium", size: 20)
        launchName.textAlignment = .left
        launchName.textColor = .primaryColor100
        addSubview(launchName)
        launchName.snp.makeConstraints { make in
            make.left.equalTo(launchImage.snp.right).offset(12)
            make.centerY.equalTo(launchImage.snp.centerY)
        }
        launchTime = launchTime1
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.primaryColor50, NSAttributedString.Key.font: UIFont(name: "Inter-Regular", size: 14)]
        
        let myString = NSMutableAttributedString(string: "Lauch Date: ", attributes: attribute)
        let TermString = NSAttributedString(string: "\(launchTime)")
        myString.append(TermString)
        let myRange = NSRange(location: "Lauch Date: ".count, length: "\(launchTime)".count)
        myString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.primaryColor50, range: myRange)
        myString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Inter-SemiBold", size: 14), range: myRange)
        
        
        launchDate.attributedText = myString
        addSubview(launchDate)
        launchDate.snp.makeConstraints { make in
            make.top.equalTo(launchImage.snp.bottom).offset(8)
            make.left.equalTo(launchImage.snp.left)
        }
        
        
    }
}

