//
//  HeaderView.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 28.11.2023.
//

import SnapKit
import UIKit

final class HeaderView: UIView {
    var backAction : (() -> ())?
    var title: String?
    let titleLabel = UILabel()
    let backButton = UIButton()
    
    init(title: String?, showBackButton: Bool = false) {
        self.title = title
        super.init(frame: .zero)
        self.setupUI()
        self.backgroundColor = .white
        self.setupBackButton(show: showBackButton)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backButtonTapped() {
        backAction?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI() {
        titleLabel.text = self.title
        titleLabel.font = UIFont(name: "Inter-Medium", size: 16)
        titleLabel.textColor = .textPrimary
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.bottom.equalToSuperview().inset(12)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
    }
    
    func setupBackButton(show: Bool) {
        backButton.setImage(UIImage(named: "btn_back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.isHidden = !show
        self.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(titleLabel)
            make.width.height.equalTo(48)
        }
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
