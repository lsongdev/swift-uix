import XCTest
@testable import SwiftUIX

final class SwiftUIXTests: XCTestCase {
    func testVersion() {
        XCTAssertEqual(SwiftUIXInfo.version, "0.1.0")
    }
} 