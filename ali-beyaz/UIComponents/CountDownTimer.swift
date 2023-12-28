//
//  CountDownTimer.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 30.11.2023.
//

import UIKit
import SnapKit

class CountDownTimer: UIView {
    
    var hourLabel: UILabel!
    var minuteLabel: UILabel!
    var secondLabel: UILabel!
    var timeLabelsStackView: UIStackView!
    var timer: Timer?
    var endTime: Date?

    var secondDescriptorLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        layoutViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {

        hourLabel = createLabel()
        minuteLabel = createLabel()
        secondLabel = createLabel()
        
        let hourDescriptorLabel = createDescriptorLabel(text: "Hour")
        let minuteDescriptorLabel = createDescriptorLabel(text: "Minute")
        secondDescriptorLabel = createDescriptorLabel(text: "Second")
        
        let hourStackView = UIStackView(arrangedSubviews: [hourLabel, hourDescriptorLabel])
        let minuteStackView = UIStackView(arrangedSubviews: [minuteLabel, minuteDescriptorLabel])
        let secondStackView = UIStackView(arrangedSubviews: [secondLabel, secondDescriptorLabel])
        
        [hourStackView, minuteStackView, secondStackView].forEach {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .fill
        }
        
        timeLabelsStackView = UIStackView(arrangedSubviews: [hourStackView, minuteStackView, secondStackView])
        timeLabelsStackView.axis = .horizontal
        timeLabelsStackView.alignment = .center
        timeLabelsStackView.distribution = .fillEqually
        timeLabelsStackView.spacing = 8
        
        addSubview(timeLabelsStackView)
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Inter-SemiBold", size: 18)
        label.textAlignment = .center
        label.textColor = .primaryColor10
        return label
    }
    
    private func createDescriptorLabel(text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .white
        label.text = text
        return label
    }
    
    private func layoutViews() {
        timeLabelsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func startCountdown(from startDate: Date, to endDate: Date) {
        guard startDate < endDate else {
            print("Start date must be earlier than end date.")
            return
        }
        
        endTime = endDate
        updateTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopCountdown() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func updateTimer() {
        guard let endTime = endTime else { return }
        
        let remainingTime = endTime.timeIntervalSinceNow
        if remainingTime <= 0 {
            stopCountdown()
            hourLabel.text = "00 :"
            minuteLabel.text = "00 :"
            secondLabel.text = "00"
            secondDescriptorLabel.textColor = .gray
            secondLabel.textColor = .gray
        } else {
            let hours = Int(remainingTime) / 3600
            let minutes = Int(remainingTime) / 60 % 60
            let seconds = Int(remainingTime) % 60
            hourLabel.text = String(format: "%02d  :", hours)
            minuteLabel.text = String(format: "%02d", minutes)
            secondLabel.text = String(format: ":  %02d", seconds)
            secondDescriptorLabel.textColor = .gray
            secondLabel.textColor = .gray

        }
    }
}
