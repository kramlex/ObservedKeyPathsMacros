# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.1] - 2024-08-29

### Fixed
- **Code Quality**: Fixed all SwiftLint violations (51 → 0)
- **YAML Configuration**: Resolved SwiftLint configuration parsing issues
- **Line Length**: Fixed line length violation in ObservedKeyPathsMacros.swift
- **Trailing Whitespace**: Removed all trailing whitespace from source files
- **Import Sorting**: Fixed import order according to sorted_imports rule
- **Unused Parameters**: Fixed unused closure parameter in BasicExample.swift

### Technical Improvements
- **Code Standards**: All source code now follows SwiftLint best practices
- **Maintainability**: Improved code readability and consistency
- **CI Ready**: Code is now ready for strict linting in CI/CD pipeline

## [1.1.0] - 2024-08-29

### Fixed
- **Critical Bug Fix**: Fixed `self` capture issue in macro-generated code for `ObservableObjectPublisherHolder`
- **Swift 6 Compatibility**: Resolved concurrent access warnings in observation tracking
- **Macro Expansion**: Fixed missing `_holder` property generation in macro output
- **Test Coverage**: Updated all tests to reflect corrected macro behavior

### Changed
- **Code Quality**: Improved code formatting and readability in macro implementation
- **Import Order**: Reorganized imports for better organization
- **CI Pipeline**: Enhanced GitHub Actions workflow with better caching and error handling
- **Example Code**: Updated BasicExample.swift to use `final` classes for better Swift conformance

### Technical Improvements
- **Macro Generation**: Enhanced `@GenerateObservedKeyPaths` macro to properly handle `self` references
- **Property Detection**: Improved logic for detecting observable properties
- **SwiftLint**: Added configuration for better code quality enforcement
- **Build System**: Optimized package structure and dependencies

## [1.0.0] - 2024-12-19

### Added
- Initial release
- Core macro functionality
- Basic documentation and examples
- Test suite
