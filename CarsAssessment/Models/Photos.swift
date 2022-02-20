//
//  Photos.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import Foundation

// MARK: - Photos
struct Photos: Codable {
    let photos: [Photo]
    let photosCount: Int
    let links: [Link]
}

// MARK: - Link
struct Link: Codable {
    let rel: Rel
    let href: String
}

enum Rel: String, Codable {
    case first = "first"
    case last = "last"
    case next = "next"
    case relSelf = "self"
}

// MARK: - Photo
struct Photo: Codable {
    let title: String?
    let category: String?
    let tags: [String]?
    let provider: String?
    let sources: [Source]?
    let makes: [String]?
    let models: [String]?
    let years: [String]?
    let submodels: [String]?
    let trims: [String]?
    let modelYearID: Int?
    let shotTypeAbbreviation: String?
    let styleIDS, exactStyleIDS: [String]?

    enum CodingKeys: String, CodingKey {
        case title, category, tags, provider, sources, makes, models, years, submodels, trims
        case modelYearID = "modelYearId"
        case shotTypeAbbreviation
        case styleIDS = "styleIds"
        case exactStyleIDS = "exactStyleIds"
    }
}

// MARK: - Source
struct Source: Codable {
    let link: Link
    let sourceExtension: String
    let size: Size

    enum CodingKeys: String, CodingKey {
        case link
        case sourceExtension = "extension"
        case size
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
}
