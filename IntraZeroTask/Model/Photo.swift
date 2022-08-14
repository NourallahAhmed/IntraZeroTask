//
//  Photo.swift
//  IntraZeroTask
//
//  Created by NourAllah Ahmed on 11/08/2022.
//

import Foundation

struct Photo: Codable , Hashable ,Identifiable  {

    let id: String
    let author: String
    let width: Int16
    let height: Int16
    let url: String
    let downloadUrl: String

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case author = "author"
        case width = "width"
        case height = "height"
        case url = "url"
        case downloadUrl = "download_url"
    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(String.self, forKey: .id)
//        author = try values.decode(String.self, forKey: .author)
//        width = try values.decode(Int.self, forKey: .width)
//        height = try values.decode(Int.self, forKey: .height)
//        url = try values.decode(String.self, forKey: .url)
//        downloadUrl = try values.decode(String.self, forKey: .downloadUrl)
//    }

//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(author, forKey: .author)
//        try container.encode(width, forKey: .width)
//        try container.encode(height, forKey: .height)
//        try container.encode(url, forKey: .url)
//        try container.encode(downloadUrl, forKey: .downloadUrl)
//    }

}
