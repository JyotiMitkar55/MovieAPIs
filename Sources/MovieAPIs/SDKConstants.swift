//
//  SDKKeys.swift
//  DBSIndia
//
//  Created by Jyoti on 23/01/18.
//  Copyright © 2018 Mind Gate Solutions pvt ltd. All rights reserved.

let API_KEY                                     = "77829b2d614e43119afbeb8466be9da2"
let REQUEST_TIME_OUT                            = 60


enum API {
    
    enum BaseURL {
        static let prod = "https://api.themoviedb.org/3/"
    }
    
    enum Endpoint {
        static let nowPlaying = "now_playing"
        static let configuration = "configuration"
    }
}


struct ApiKeys {
    static let language = "language"
    static let apiKey = "api_key"
    static let page = "page"
}
