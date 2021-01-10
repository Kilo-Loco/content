import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(push_notifications_lambdaTests.allTests),
    ]
}
#endif
