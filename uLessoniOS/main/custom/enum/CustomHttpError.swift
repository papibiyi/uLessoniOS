//
//  CustomHttpError.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 27/12/2020.
//

import Foundation

enum CustomHttpError: Error {
    case NotJson
    case BadRequest
    case ServerError
    case Unknown(error: String)
}

extension CustomHttpError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .NotJson:
            return "Response not in JSON format"
        case .BadRequest:
            return "BadRequest"
        case .ServerError:
            return "ServerError"
        case .Unknown(let error):
            return error
        }
    }
}
