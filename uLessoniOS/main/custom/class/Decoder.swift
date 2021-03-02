//
//  Decoder.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 28/02/2021.
//

import Foundation

class Decoder<T: Decodable> {
    func decode(from data: Data) -> (Result<T,Error>) {
        do {
            let json = try JSONDecoder().decode(T.self, from: data)
            return .success(json)
        } catch {
            return .failure(error)
        }
    }
}

