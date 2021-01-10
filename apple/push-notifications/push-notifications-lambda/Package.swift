// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "push-notifications-lambda",
    platforms: [.macOS(.v10_13)],
    products: [
        .executable(
            name: "push-notifications-lambda",
            targets: ["push-notifications-lambda"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/swift-aws-lambda-runtime.git", .upToNextMajor(from: "0.3.0")),
        .package(name: "AWSSDKSwift", url: "https://github.com/soto-project/soto.git", .upToNextMajor(from: "4.7.0"))
    ],
    targets: [
        .target(
            name: "push-notifications-lambda",
            dependencies: [
                .product(name: "AWSLambdaRuntime", package: "swift-aws-lambda-runtime"),
                .product(name: "AWSLambdaEvents", package: "swift-aws-lambda-runtime"),
                .product(name: "Pinpoint", package: "AWSSDKSwift")
            ]),
        .testTarget(
            name: "push-notifications-lambdaTests",
            dependencies: ["push-notifications-lambda"]),
    ]
)
