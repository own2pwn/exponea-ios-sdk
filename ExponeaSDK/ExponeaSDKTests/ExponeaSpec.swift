//
//  ExponeaSpec.swift
//  ExponeaSDKTests
//
//  Created by Ricardo Tokashiki on 29/03/2018.
//  Copyright © 2018 Exponea. All rights reserved.
//

import XCTest
import Quick
import Nimble

@testable import ExponeaSDK

class ExponeaSpec: QuickSpec {

    override func spec() {

        describe("Configure SDK") {

            context("After being properly initialized token with string") {
                it("Configuration with token string should be initialized") {
                    Exponea.configure(projectId: "123")
                    expect(Exponea.shared.configured).to(beTrue())
                    expect(Exponea.shared.projectId).to(equal("123"))
                }
            }
            context("After being properly initialized token with plist") {
                it("Configuration with plist token should be initialized") {
                    Exponea.configure(plistName: "ExponeaConfig.plist")
                    expect(Exponea.shared.configured).to(beTrue())
                    expect(Exponea.shared.projectId).to(equal("ExponeaProjectIdKeyFromPList"))
                }
            }
        }

        describe("Check projectId (token)") {

            Exponea.configure(plistName: "ExponeaConfig.plist")

            context("Get projectId (token) after it's being setup") {
                it("ProjectId string should be returned") {
                    expect(Exponea.shared.projectId).notTo(beNil())
                    expect(Exponea.shared.projectId).to(equal("ExponeaProjectIdKeyFromPList"))
                }
            }
            context("Update projectId (token)") {
                it("ProjectId should be updated") {
                    let oldProjectId = Exponea.shared.projectId
                    Exponea.shared.projectId = "NewProjectId"
                    let newProjectId = Exponea.shared.projectId
                    expect(oldProjectId).notTo(equal(newProjectId))
                    expect(newProjectId).to(equal("NewProjectId"))
                }
            }
        }
    }
}