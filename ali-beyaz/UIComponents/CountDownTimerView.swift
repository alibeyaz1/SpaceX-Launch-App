//
//  LauncDateView.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 29.11.2023.
//

import UIKit

class LauncDateView: UIView {
    
    
    private var lauchDateLabel = UILabel()
    var launchDate = UILabel()
    let countdownView = CountDownTimer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .day, value: 5, to: Date())!

        countdownView.startCountdown(from: startDate, to: endDate)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    
    private func setupUI() {
        
        layer.cornerRadius = 8
        backgroundColor = .black
        
        lauchDateLabel.text = "LAUNCH DATE"
        lauchDateLabel.font = UIFont(name: "Inter-Medium", size: 16)
        lauchDateLabel.textAlignment = .left
        lauchDateLabel.textColor = .white
        
        launchDate.font = UIFont(name: "Inter-Regular", size: 13)
        launchDate.textColor = .white
    
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8

        stackView.addArrangedSubview(lauchDateLabel)
        stackView.addArrangedSubview(launchDate)

        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        addSubview(countdownView)
        countdownView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        
    }

}
