//
//  LaunchesVC.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 28.11.2023.
//

import UIKit
import SnapKit

class LaunchesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let launchesViewModel = LauchesViewModel()
    private var isUpcomingSelected = true
    
    // MARK: - UI Elements
    var tableView: UITableView!
    let header = HeaderView(title: "Launches")
    let segmentedControl = UISegmentedControl(items: ["Upcoming", "Past"])
    var launches: [Launch] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        segmentedControl.selectedSegmentIndex = 0
        fetchUpcoming()
        
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Setup TableView
    private func setupTableView() {
                
        view.backgroundColor = .white
        
        view.addSubview(header)
        
        header.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(segmentedControl)
        segmentedControl.backgroundColor = .white
        segmentedControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(header.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LaunchesTableViewCell.self, forCellReuseIdentifier: LaunchesTableViewCell.identifier)
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            
        }
        
  
    }
    
    func fetchUpcoming(){
        launchesViewModel.fetchUpcomingLaunches { [weak self] result in
                   guard let self = self else { return }
                   switch result {
                   case .success(let launches):
                       self.launches = launches
                       DispatchQueue.main.async {
                           self.tableView.reloadData()
                           
                       }
                   case .failure(let error):
                       print("Error: \(error.localizedDescription)")
                   }
               }
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        isUpcomingSelected = sender.selectedSegmentIndex == 0
        switch sender.selectedSegmentIndex {
        case 0:
            launchesViewModel.fetchUpcomingLaunches { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let launches):
                    self.launches = launches
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            break
        case 1:
            launchesViewModel.fetchPastLaunches { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let launches):
                    self.launches = launches
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            break
        default:
            break
        }
    }
    
    
    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = launches[indexPath.item]
        
        
        
        let vc = LaunchDetailsVC(launch: launch)
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            vc.header.titleLabel.text = "Upcoming Lauch"
            break
        case 1:
            vc.header.titleLabel.text = "Past Lauch"
            break
        default:
            break
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: launch.dateUTC)
        
        vc.countDownTimer.launchDate.text = "\(date!)"
        vc.launchHeaderView.launchTime = launch.name
        vc.header.backAction = {
            self.dismiss(animated: true)
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesTableViewCell.identifier, for: indexPath) as? LaunchesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        let launchesCount = launchesViewModel.numberOfUpcomingLaunches()
        
        guard indexPath.row < launchesCount else {
            
            return UITableViewCell()
        }
        
        let launch = launchesViewModel.getLaunch(at: indexPath.row, isUpcoming: isUpcomingSelected)
        cell.configure(with: launch)
        return cell
    }
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

#Preview{
    LaunchesVC()
}
