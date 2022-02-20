//
//  MakesList.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/17/22.
//
// MARK: - Welcome
struct Makes: Codable {
    let totalNumber, totalPages: Int
    var results: [Make]
}

// MARK: - Result
struct Make: Codable {
    let id: Int
    let name, niceName, adTargetID, niceID: String?
    let useInUsed, useInNew, useInPreProduction, useInFuture: String?
    let attributeGroups: AttributeGroups?
    let models: [Model]?

    enum CodingKeys: String, CodingKey {
        case id, name, niceName
        case adTargetID = "adTargetId"
        case niceID = "niceId"
        case useInUsed, useInNew, useInPreProduction, useInFuture, attributeGroups, models
    }
}
