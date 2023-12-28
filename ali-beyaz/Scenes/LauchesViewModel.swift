//
//  LauchesViewModel.swift
//  ali-beyaz
//
//  Created by Ali Beyaz on 29.11.2023.
//

import Foundation

class LauchesViewModel {
    private(set) var upcomingLaunches: [Launch] = []
    private(set) var pastLaunches: [Launch] = []

    let apiManager = APIManager.shared
    
    func fetchUpcomingLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        apiManager.fetchUpcomingLaunches { result in
            switch result {
            case .success(let launches):
                self.upcomingLaunches = launches
                completion(.success(launches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchPastLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        apiManager.fetchPastLaunches { result in
            switch result {
            case .success(let launches):
                self.pastLaunches = launches
                completion(.success(launches))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func timeRemainingForLaunch(at index: Int, isUpcoming: Bool) -> TimeInterval {
            let launch = isUpcoming ? upcomingLaunches[index] : pastLaunches[index]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-mm-dd - HH:mm"

            if let launchDate = dateFormatter.date(from: launch.dateUTC) {
                let remainingTime = launchDate.timeIntervalSinceNow
                return max(remainingTime, 0)
            }

            return 0
        }
    func numberOfUpcomingLaunches() -> Int {
           return upcomingLaunches.count
       }

       func numberOfPastLaunches() -> Int {
           return pastLaunches.count
       }

    func getLaunch(at index: Int, isUpcoming: Bool) -> Launch {
        return isUpcoming ? upcomingLaunches[index] : pastLaunches[index]
    }
}

