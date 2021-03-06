//
//  FetchPersonalizationSpec.swift
//  ExponeaSDKTests
//
//  Created by Ricardo Tokashiki on 02/08/2018.
//  Copyright © 2018 Exponea. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

@testable import ExponeaSDK

class FetchPersonalizationSpec: QuickSpec {
    override func spec() {
        describe("A personalization") {
            context("Fetch personalization from mock repository") {
                
                let configuration = try! Configuration(plistName: "ExponeaConfig")
                let repo = ServerRepository(configuration: configuration)

                MockingjayProtocol.addStub(matcher: { (request) -> (Bool) in
                    return true
                }) { (request) -> (Response) in
                    let data = MockData().personalizationResponse
                    let stubResponse = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
                    return Response.success(stubResponse, .content(data))
                }
                let mockData = MockData()
                
                waitUntil(timeout: 3) { done in
                    repo.fetchPersonalization(with: mockData.personalizationRequest, for: mockData.customerIds) { (result) in
                        it("Result error should be nil") {
                            expect(result.error).to(beNil())
                        }
                        
                        context("Validating personalization data") {
                            let data = result.value?.data[0]
                            
                            it("html should contain value [String: exponea-banner]") {
                                expect(data?.html).to(contain("exponea-banner"))
                            }
                            
                            it("script should have the prefix [String: var self = this]") {
                                expect(data?.script).to(beginWith("var self = this"))
                            }
                            
                            it("style should have the prefix [String: .exponea-leaderboard]") {
                                expect(data?.style).to(beginWith(".exponea-leaderboard"))
                            }
                        }
                        done()
                    }
                }
            }
        }
    }
}
