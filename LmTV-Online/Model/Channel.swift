//
//  Channel.swift
//  LmTV-Online
//
//  Created by Юрий Чекалюк on 08.04.2022.
//


struct Channel: Decodable {
    let channels: [ChannelData]?
    
}

struct ChannelData: Decodable {
    let name: String?
    let url: String?
    let image: String?
    let current: CurrentBroadcast?
}

struct CurrentBroadcast: Decodable {
    let title: String?
}

extension ChannelData {
    private enum CodingKeys: String, CodingKey {
        case name = "name_ru"
        case url = "url"
        case image = "image"
        case current = "current"
    }
}
