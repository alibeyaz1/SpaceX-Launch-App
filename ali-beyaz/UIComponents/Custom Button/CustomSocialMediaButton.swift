//
//  CustomSocialMediaButton.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 30.11.2023.
//

import UIKit
import SnapKit

class CustomSocialMediaButton: UIButton {
    
    // MARK: - Properties
    
    let buttonLabel = UILabel()
    let buttonImageView = UIImageView()
    let forwardButton = UIImageView()
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        // UIButton özelliklerini ayarlayın
        setTitleColor(.primaryColor100, for: .normal)
        layer.cornerRadius = 10
        layer.borderColor = UIColor.primaryColor20.cgColor
        layer.borderWidth = 1

        
        buttonImageView.layer.cornerRadius = 16
        buttonImageView.clipsToBounds = true
        
        addSubview(buttonImageView)
        buttonImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.width.equalTo(32)
        }
        
        buttonLabel.textColor = .primaryColor100
        buttonLabel.font = UIFont(name: "Inter-SemiBold", size: 14)
        addSubview(buttonLabel)
        buttonLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(buttonImageView.snp.right).offset(16)
            
        }
        
        forwardButton.image = UIImage(named: "btn_forward")
        addSubview(forwardButton)
        forwardButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(16)
        }
     
    }
    
    // MARK: - Public Methods
    
    func configure(title: String?, image: UIImage?) {
        buttonLabel.text = title
        buttonImageView.image = image
    }
    
    convenience init(title: String?, image: UIImage?) {
        self.init()
        configure(title: title, image: image)
    }
}
