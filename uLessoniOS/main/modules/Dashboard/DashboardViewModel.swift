//
//  DashboardViewModel.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import Foundation

class DashboardViewModel {
    
    let delegate: DataFetchedDelegate?
    let webService: DashboardWebService
    var subjects: [Subject] = []
    
    init(delegate: DataFetchedDelegate?, webService: DashboardWebService) {
        self.delegate = delegate
        self.webService = webService
        getSubjects()
    }
    
    func getSubjects() {
        webService.getSubjects { [weak self] (response) in
            switch response {
            case .success(let data):
                self?.subjects = data.data?.subjects ?? []
                self?.delegate?.onDataFetched()
            case .failure(let error):
                self?.delegate?.onFetchError(error: error)
            }
        }
    }
    
}
