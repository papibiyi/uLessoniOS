//
//  DataFetchedDelegate.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import Foundation

protocol DataFetchedDelegate {
    func onDataFetched()
    func onFetchError(error: Error)
}
