//
//  SubjectDataResolver.swift
//  uLessoniOS
//
//  Created by Mojisola Adebiyi on 02/03/2021.
//

import Foundation

class SubjectDataResolver {
    private static let images = ["biology", "chemistry", "english", "mathematics", "physics"]
    private static let color = ["ubrightorange", "ugreen", "uorange", "upurple", "uteal"]
    
    static func resolve(name: String) -> (image: String, icon: String, color: String) {
        
        switch name.lowercased() {
        case "biology":
            return (image: "biology", icon:"biology_logo", color: "ugreen")
        case "chemistry":
            return (image: "chemistry", icon:"chemistry_logo", color: "ubrightorange")
        case "english":
            return (image: "english", icon:"english_logo", color: "uteal")
        case "mathematics":
            return (image: "mathematics", icon:"mathematics_logo", color: "uorange")
        case "physics":
            return (image: "physics", icon:"physics_logo", color: "upurple")
        default:
            return (image: images[Int.random(in: 1..<images.count)], icon:"", color: color[Int.random(in: 1..<color.count)])
        }
    }
}
