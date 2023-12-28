//
//  LaunchDetailsCollectionCell.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 29.11.2023.
//

import UIKit
import SnapKit

final class LaunchDetailsCollectionCell: UICollectionViewCell {
    
    
    
    private lazy var launchTitleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: "Inter-Regular", size: 13)
        label.numberOfLines = .zero
        label.textAlignment = .left
        label.textColor = .primaryColor50
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.font = UIFont(name: "Inter-SemiBold", size: 14)
        label.numberOfLines = .zero
        label.textAlignment = .left
        label.textColor = .primaryColor100
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        self.layer.borderColor = UIColor.systemGray4.cgColor
        self.layer.borderWidth = 0.4
            }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureCell(title: String, subtitle: String) {
       addSubview(launchTitleLabel)
        addSubview(subtitleLabel)
        
        launchTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(24)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(launchTitleLabel.snp.bottom)
            make.height.equalTo(24)
        }
        
        launchTitleLabel.text = title
        subtitleLabel.text = subtitle
        
    }
    
}
