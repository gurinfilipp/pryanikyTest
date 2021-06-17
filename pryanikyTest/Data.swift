//
//  Data.swift
//  pryanikyTest
//
//  Created by Philip on 14.06.2021.
//




struct GlobalJsonData: Decodable {
    let data: [GlobalData]
    let view: [String]
}

struct GlobalData: Decodable {
    let name: String
    let data: DataFields
}

struct DataFields: Decodable {
    let url: String?
    let text: String?
    let selectedId: Int?
    let variants: [Variant]?
}

struct Variant: Decodable {
    let id: Int?
    let text: String?
}
