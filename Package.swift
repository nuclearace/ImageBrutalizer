import PackageDescription

let package = Package(
    name: "Cropper",
    targets: [
        Target(name: "ImageRunner", dependencies: ["ImageBrutalizer"]),
        Target(name: "ImageBrutalizer")
    ]
)
