//
//  DashboardWebService.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import Foundation

class DashboardWebService: WebService {
    let networkManager = NetworkManager()

    func getSubjects(completion: @escaping (Result<Response, Error>) -> ()) {
        networkManager.makeRequest(requestType: .get, url: "https://jackiechanbruteforce.ulesson.com/3p/api/content/grade", params: nil, completionHandler: completion)
    }
}
