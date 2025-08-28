# ObservedKeyPathsMacros

A Swift macro that automatically generates `observedKeyPaths` and observation readers for SwiftUI and Observation framework integration.

## Features

- 🔍 Automatically detects observable properties using `@ObservationTracked` or falls back to all non-ignored stored properties
- 📱 Generates `observedKeyPaths` array for type-safe key path access
- 👀 Creates observation readers for efficient change tracking
- 🔄 Integrates with Combine and ObservableObject for backward compatibility
- ⚡ Lightweight and performant with no runtime overhead

## Requirements

- iOS 17.0+ / macOS 10.15+
- Swift 5.10+
- Xcode 15.0+

## Installation

### Swift Package Manager

Add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/kramlex/ObservedKeyPathsMacros.git", from: "1.0.0")
]
```

Or add it directly in Xcode:
1. File → Add Package Dependencies
2. Enter: `https://github.com/kramlex/ObservedKeyPathsMacros.git`
3. Click Add Package

## Usage

### Basic Usage

Simply add the `@GenerateObservedKeyPaths` macro to your Observable class:

```swift
import ObservedKeyPaths
import Observation

@Observable
@GenerateObservedKeyPaths
class UserProfile {
    var name: String = ""
    var email: String = ""
    var age: Int = 0
    
    // The macro will automatically generate:
    // - observedKeyPaths: [\UserProfile.name, \UserProfile.email, \UserProfile.age]
    // - _observationReaders for efficient tracking
    // - objectWillChange publisher for Combine compatibility
}
```

### With Explicit Tracking

You can explicitly mark which properties to track:

```swift
@Observable
@GenerateObservedKeyPaths
class Settings {
    @ObservationTracked var theme: String = "light"
    @ObservationTracked var fontSize: Int = 14
    
    var internalId: String = "123" // This won't be tracked
    
    // Only theme and fontSize will be included in observedKeyPaths
}
```

### Ignoring Properties

Use `@ObservationIgnored` to exclude properties from tracking:

```swift
@Observable
@GenerateObservedKeyPaths
class DataModel {
    var importantData: String = ""
    
    @ObservationIgnored var cachedData: String = "" // This won't be tracked
    @ObservationIgnored var debugInfo: String = "" // This won't be tracked
}
```

### Combine Integration

The macro automatically provides Combine compatibility:

```swift
@Observable
@GenerateObservedKeyPaths
class Counter {
    var count: Int = 0
    
    func increment() {
        count += 1
    }
}

let counter = Counter()
let cancellable = counter.objectWillChange
    .sink { _ in
        print("Counter changed!")
    }

counter.increment() // Will trigger the publisher
```

## How It Works

The `@GenerateObservedKeyPaths` macro:

1. **Analyzes your class/struct** to find observable properties
2. **Generates `observedKeyPaths`** - an array of `PartialKeyPath<Self>` for type-safe access
3. **Creates observation readers** - functions that access each property to trigger observation
4. **Provides Combine compatibility** - integrates with existing ObservableObject patterns

## Generated Code

For a class like:

```swift
@Observable
@GenerateObservedKeyPaths
class Example {
    var value: String = ""
    var count: Int = 0
}
```

The macro generates:

```swift
extension Example: ObservationType {}

static let observedKeyPaths: [PartialKeyPath<Example>] = [\Example.value, \Example.count]
static let _observationReaders: [(Example) -> Void] = [{ _ = $0.value as Any }, { _ = $0.count as Any }]

@ObservationIgnored
private lazy var _holder: ObservableObjectPublisherHolder = {
    ObservableObjectPublisherHolder(changesPublisherUsingReaders())
}()

@ObservationIgnored
public lazy var objectWillChange: ObservableObjectPublisher = {
    _holder.objectWillChange
}()
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built with [SwiftSyntax](https://github.com/apple/swift-syntax)
- Inspired by the Swift Observation framework
- Designed for seamless SwiftUI integration
