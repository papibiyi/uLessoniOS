//
//  RecentlyWatchedData.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 03/03/2021.
//

import Foundation

struct RecentlyWatchedDataModel: Codable {
    var chapterTitle: String
    var subjectName: String
    var lesson: Lesson
}

class RecentlyWatchedData {
    static let userDefaultKey = "RecentlyWatchedData"
    
    static func getRecentlyWatched() -> [RecentlyWatchedDataModel] {
        guard let data = UserDefaults.standard.object(forKey: "RecentlyWatchedData") as? Data else {return []}
        let decoder = JSONDecoder()
        guard let recentlyWatched = try? decoder.decode([RecentlyWatchedDataModel].self, from: data) else {return []}
        return recentlyWatched
    }
    
    static func saveToRecetlyWatched(data: RecentlyWatchedDataModel) {
        
        var recentlyWatched = getRecentlyWatched()
        
        if recentlyWatched.contains(where: { (watched) -> Bool in
            watched.lesson.id == data.lesson.id
        }) { return } else {
            if recentlyWatched.count > 4 {
                recentlyWatched.popLast()
            }
            recentlyWatched.insert(data, at: 0)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(recentlyWatched) {
                UserDefaults.standard.set(encoded, forKey: "RecentlyWatchedData")
            }
        }
    }
}
