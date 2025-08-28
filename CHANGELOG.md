# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of ObservedKeyPathsMacros
- `@GenerateObservedKeyPaths` macro for automatic generation of observed key paths
- Support for `@ObservationTracked` and `@ObservationIgnored` attributes
- Automatic detection of observable properties
- Combine integration with `objectWillChange` publisher
- Support for classes, structs, and actors
- Comprehensive test coverage

### Features
- Automatically generates `observedKeyPaths` array for type-safe key path access
- Creates observation readers for efficient change tracking
- Integrates with SwiftUI and Observation framework
- Provides backward compatibility with ObservableObject patterns
- Lightweight and performant with no runtime overhead

## [1.0.0] - 2024-12-19

### Added
- Initial release
- Core macro functionality
- Basic documentation and examples
- Test suite
