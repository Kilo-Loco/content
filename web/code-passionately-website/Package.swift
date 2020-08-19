// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "CodePassionatelyWebsite",
    products: [
        .executable(
            name: "CodePassionatelyWebsite",
            targets: ["CodePassionatelyWebsite"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.6.0")
    ],
    targets: [
        .target(
            name: "CodePassionatelyWebsite",
            dependencies: ["Publish"]
        )
    ]
)