//
//  LaunchDetailsVC.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 29.11.2023.
//


import UIKit


class LaunchDetailsVC: UIViewController {
    
    let launch : Launch
    let youTubeButton = CustomSocialMediaButton(title: "YouTube", image: UIImage(named: "ic_youtube"))
    let presskitButton = CustomSocialMediaButton(title: "Presskit", image: UIImage(named: "ic_presskit"))


    private lazy var collectionView : UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = view.frame.size.width
        let height = view.frame.size.height
        layout.itemSize = CGSize(width: width / 2 - 20, height: 250 / 3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.collectionView?.contentMode = .scaleToFill
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.register(LaunchDetailsCollectionCell.self, forCellWithReuseIdentifier:"myCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 8
        collectionView.layer.borderColor = UIColor.systemGray4.cgColor
        collectionView.layer.borderWidth = 1
        return collectionView
    }()
    
    let countDownTimer = LauncDateView()
    lazy var launchHeaderView = LaunchDetailsHeaderView(laungImage: URL(string: self.launch.links.patch.small ?? String("https://images2.imgbox.com/a9/9a/NXVkTZCE_o.png"))!, launchName: self.launch.name, launchTime: launch.dateUTC)

    let header = HeaderView(title: "", showBackButton: true )

    
    
    
    init(launch: Launch) {
        self.launch = launch
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        

        setupUI()
        launchStatus()
    
    }
    
    func setupUI(){
        
 
        view.backgroundColor = .white
        
        view.addSubview(header)
        header.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(launchHeaderView)
        launchHeaderView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(header.snp.bottom).offset(16)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        view.addSubview(countDownTimer)
        countDownTimer.snp.makeConstraints { make in
            make.top.equalTo(launchHeaderView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(9.41)
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(countDownTimer.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(250)
        }

        

        view.addSubview(youTubeButton)
        youTubeButton.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(24)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(13)
        }
                
        view.addSubview(presskitButton)
        presskitButton.snp.makeConstraints { make in
            make.top.equalTo(youTubeButton.snp.bottom).offset(24)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(13)
        }
        
    }
    
    func launchStatus() {
        if launch.upcoming {
            launchHeaderView.launchDate.isHidden = true
            countDownTimer.isHidden = false
            collectionView.snp.remakeConstraints { make in
                make.top.equalTo(countDownTimer.snp.bottom).offset(24)
                make.horizontalEdges.equalToSuperview().inset(20)
                make.height.equalTo(250)
            }
        } else {
            launchHeaderView.launchDate.isHidden = false
            countDownTimer.isHidden = true
            collectionView.snp.remakeConstraints { make in
                make.top.equalTo(launchHeaderView.snp.bottom).offset(24)
                make.leading.trailing.equalToSuperview().inset(20)
                make.height.equalTo(250)
            }
        }
        self.view.layoutIfNeeded()
    }
}
    extension LaunchDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          6
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! LaunchDetailsCollectionCell
            
            let core = self.launch.cores.first
            
            switch indexPath.item {
            case 0:
                cell.configureCell(title: "Landing Attempt", subtitle: "\(core?.landingAttempt == nil ? "-" : "\(core!.landingAttempt!)")" )
            case 1:
                cell.configureCell(title: "Landing Success", subtitle: "\(core?.landingSuccess == nil ? "-" : "\(core!.landingSuccess!)")")
            case 2:
                cell.configureCell(title: "Landing Type", subtitle: "\(core?.landingType ?? "-")")
            case 3:
                cell.configureCell(title: "Flight Number", subtitle: "\(self.launch.flightNumber ?? 0)")
            case 4:
                cell.configureCell(title: "Upcoming", subtitle: "\(self.launch.upcoming)")
            case 5:
                cell.configureCell(title: "Date Precision", subtitle: "\(self.launch.datePrecision.rawValue)")
           
            
                
            default:
                print("out of range")
            }
            
            
        
            return cell
        }
       
    }

