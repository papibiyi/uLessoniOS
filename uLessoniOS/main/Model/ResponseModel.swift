//
//  ResponseModel.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 28/02/2021.
//

import Foundation

struct Response: Codable {
    let data: ResponseModel?
}

struct ResponseModel: Codable {
    let status, message: String?
    let subjects: [Subject]?
}

struct Subject: Codable {
    let id: Int?
    let name: String?
    let icon: String?
    let chapters: [Chapter]?
}

struct Chapter: Codable {
    let id: Int?
    let name: String?
    let lessons: [Lesson]?
}

struct Lesson: Codable {
    let id: Int?
    let name: String?
    let icon: String?
    let media_url: String?
    let subject_id, chapter_id: Int?
}
