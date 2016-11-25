import PackageDescription

let package = Package(
    name: "Cropper",
    targets: [
        Target(name: "Runner", dependencies: ["ImageBrutalizer"]),
        Target(name: "ImageBrutalizer")
    ]
)
