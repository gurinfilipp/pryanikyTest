//
//  Data.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//


import AnyCodable

struct GlobalJsonData: Decodable {
    var data: [GlobalData]
    var view: [String]
}

struct GlobalData:Decodable {
    var name: String
    var data: DataFields
}

struct DataFields:Decodable {
    var url: String?
    var text: String?
    var selectedId: Int?
    var variants: [Variant]?
}

struct Variant:Decodable {
    var id: Int?
    var text: String?
}
