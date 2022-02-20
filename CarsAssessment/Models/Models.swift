//
//  Models.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/18/22.
//

import Foundation

// MARK: - Welcome
struct Models: Codable {
    let totalNumber, totalPages: Int
    let results: [Model]
}

// MARK: - Result
class Model: Codable {
    let id: String?
    let makeID: Int?
    let makeName: String?
    let makeNiceName, makeNiceID: String?
    let name, niceName, adTargetID, niceID: String?
    let modelLinkCode: String?
    let make: Make?
    let modelYears: [ModelYear]?
    let attributeGroups: AttributeGroups?
    let categories: Categories?
    let categoryValues: [String]?
    let publicationStates: [PublicationState]?

    enum CodingKeys: String, CodingKey {
        case id
        case makeID = "makeId"
        case makeName, makeNiceName
        case makeNiceID = "makeNiceId"
        case name, niceName
        case adTargetID = "adTargetId"
        case niceID = "niceId"
        case modelLinkCode, make, modelYears, attributeGroups, categories, categoryValues, publicationStates
    }
}

// MARK: - AttributeGroups
struct AttributeGroups: Codable {
    let main: Main?

    enum CodingKeys: String, CodingKey {
        case main = "MAIN"
    }
}

// MARK: - Main
struct Main: Codable {
    let id: Int?
    let name: String?
    let properties: Properties?
    let attributes: [String: Attribute]?
}

// MARK: - Attribute
struct Attribute: Codable {
    let id: Double?
    let name, value: String?
}

enum Name: String, Codable {
    case main = "MAIN"
}

// MARK: - Properties
struct Properties: Codable {
    let useInNew: String?
    let epiCategoryID: String?
    let year, modelLinkCode: String?
    let epiCategoryName: String?
    let workflowstatus: String?
    let useInPreProduction, useInUsed: String?
    let name: String?
    let dataAcquisitionDate: String?
    let minimumViableData: String?

    enum CodingKeys: String, CodingKey {
        case useInNew = "USE_IN_NEW"
        case epiCategoryID = "EPI_CATEGORY_ID"
        case year = "YEAR"
        case modelLinkCode = "MODEL_LINK_CODE"
        case epiCategoryName = "EPI_CATEGORY_NAME"
        case workflowstatus = "WORKFLOWSTATUS"
        case useInPreProduction = "USE_IN_PRE_PRODUCTION"
        case useInUsed = "USE_IN_USED"
        case name = "NAME"
        case dataAcquisitionDate = "DATA_ACQUISITION_DATE"
        case minimumViableData = "MINIMUM_VIABLE_DATA"
    }
}

// MARK: - Categories
struct Categories: Codable {
    let primaryBodyType, vehicleType: [String]
    let crossover: [String]?
    let vehicleStyle, market: [String]
    let vehicleSize: [VehicleSize]

    enum CodingKeys: String, CodingKey {
        case primaryBodyType = "PRIMARY_BODY_TYPE"
        case vehicleType = "Vehicle Type"
        case crossover = "Crossover"
        case vehicleStyle = "Vehicle Style"
        case market = "Market"
        case vehicleSize = "Vehicle Size"
    }
}

enum VehicleSize: String, Codable {
    case compact = "Compact"
    case large = "Large"
    case midsize = "Midsize"
}

enum Href: String, Codable {
    case apiVehicleV3MakesID200001444 = "/api/vehicle/v3/makes?id=200001444"
}

// MARK: - ModelYear
struct ModelYear: Codable {
    let id: Int
    let name: String
    let year: Int
    let publicationStates: [PublicationState]
    let href: String
}

enum PublicationState: String, Codable {
    case new = "NEW"
    case newUsed = "NEW_USED"
    case preProd = "PRE_PROD"
    case used = "USED"
}
