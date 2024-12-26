import XCTest
@testable import Constants
@testable import ConstantsMacros

final class ConstantsTests: XCTestCase {
    // Test for a single constant: appName
    func testConstants_SimpleKeyValue_ReturnsValueSuccessfully() throws {
        struct SimpleConstants {
            #Constants([
                "appName": "MyApp"
            ])
        }
        
        XCTAssertEqual(SimpleConstants.appName, "MyApp")
    }
    
    // Test for a nested constant: NetworkConfig.baseURL
    func testConstants_NestedDictionary_ReturnsValueSuccessfully() throws {
        struct NestedConstants {
            #Constants([
                "NetworkConfig": [
                    "baseURL": "https://api.example.com"
                ]
            ])
        }
        
        XCTAssertEqual(NestedConstants.NetworkConfig.baseURL, "https://api.example.com")
    }
    
    // Test for deeply nested constant: UI.Button.primary
    func testConstants_DeeplyNestedDictionary_ReturnsValueSuccessfully() throws {
        struct DeepNestedConstants {
            #Constants([
                "UI": [
                    "Button": [
                        "primary": "PrimaryButton"
                    ]
                ]
            ])
        }
        
        XCTAssertEqual(DeepNestedConstants.UI.Button.primary, "PrimaryButton")
    }
}
