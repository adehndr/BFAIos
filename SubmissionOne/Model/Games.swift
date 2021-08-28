//
//  Games.swift
//  SubmissionOne
//
//  Created by Ade Hendra on 24/08/21.
//  Copyright © 2021 Organisasi Berbudaya. All rights reserved.
//

import UIKit


struct Games : Codable
{   let count : Int
    let seoTitle : String
    let games : [Game]
    enum CodingKeys: String, CodingKey {
        case count
        case seoTitle = "seo_title"
        case games = "results"
    }
}

struct Game : Codable{
    let id : Int
    let name : String
    let released : String
    let backgroundImage : String
    let rating : Float
    let metacritic : Int
    let ratingCount : Int
    
    enum CodingKeys : String, CodingKey {
        case id
        case backgroundImage = "background_image"
        case name
        case rating
        case released
        case metacritic
        case ratingCount = "ratings_count"
    }
}

struct DetailGame : Codable{
    let id : Int
    let name : String
    let released : String
    let backgroundImage : String
    let rating : Float
    let metacritic : Int
    let ratingCount : Int
    let description : String
    let website : String
    enum CodingKeys : String, CodingKey {
        case id
        case backgroundImage = "background_image"
        case name
        case rating
        case released
        case metacritic
        case ratingCount = "ratings_count"
        case description = "description_raw"
        case website
    }
}
