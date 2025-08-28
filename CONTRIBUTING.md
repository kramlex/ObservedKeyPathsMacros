# Contributing to ObservedKeyPathsMacros

Thank you for your interest in contributing to ObservedKeyPathsMacros! This document provides guidelines and information for contributors.

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
3. **Create a feature branch** for your changes
4. **Make your changes** following the guidelines below
5. **Test your changes** thoroughly
6. **Submit a pull request**

## Development Setup

### Prerequisites

- Xcode 15.0+
- Swift 5.10+
- iOS 17.0+ / macOS 10.15+

### Building the Project

```bash
# Clone the repository
git clone https://github.com/yourusername/ObservedKeyPathsMacros.git
cd ObservedKeyPathsMacros

# Build the package
swift build

# Run tests
swift test
```

### Running Tests

```bash
# Run all tests
swift test

# Run specific test
swift test --filter ObservedKeyPathsMacrosTests/testBasicMacroExpansion
```

## Code Style Guidelines

### Swift Code

- Follow [Swift API Design Guidelines](https://www.swift.org/documentation/api-design-guidelines/)
- Use 4 spaces for indentation
- Prefer `let` over `var` when possible
- Use meaningful variable and function names
- Add documentation comments for public APIs

### Macro Implementation

- Keep macro logic simple and focused
- Add comprehensive error handling
- Include helpful error messages
- Test edge cases thoroughly

## Testing Guidelines

### Test Coverage

- Write tests for all new functionality
- Include positive and negative test cases
- Test edge cases and error conditions
- Ensure tests are deterministic and fast

### Test Structure

- Use descriptive test names
- Group related tests in test classes
- Use `XCTAssert` macros appropriately
- Clean up resources in `tearDown()`

## Pull Request Guidelines

### Before Submitting

1. **Ensure tests pass** locally
2. **Update documentation** if needed
3. **Add changelog entry** for user-facing changes
4. **Check code formatting** and style

### Pull Request Description

- Describe the problem being solved
- Explain the solution approach
- Include any relevant issue numbers
- Add screenshots for UI changes

### Review Process

- All PRs require at least one review
- Address review comments promptly
- Keep discussions constructive and focused
- Be open to feedback and suggestions

## Issue Reporting

### Bug Reports

When reporting bugs, please include:

- **Environment details** (OS, Xcode version, Swift version)
- **Steps to reproduce** the issue
- **Expected vs actual behavior**
- **Code samples** if applicable
- **Screenshots** for UI issues

### Feature Requests

For feature requests, please describe:

- **Use case** and problem being solved
- **Proposed solution** or approach
- **Alternative solutions** considered
- **Impact** on existing functionality

## Communication

- **GitHub Issues** for bug reports and feature requests
- **GitHub Discussions** for general questions and ideas
- **Pull Request comments** for code-specific discussions

## Code of Conduct

- Be respectful and inclusive
- Focus on the code and technical aspects
- Help others learn and grow
- Report inappropriate behavior to maintainers

## Getting Help

If you need help with contributing:

1. Check existing documentation and issues
2. Ask questions in GitHub Discussions
3. Open an issue for specific problems
4. Reach out to maintainers directly

Thank you for contributing to ObservedKeyPathsMacros! 🚀
