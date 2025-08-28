# Support

## Getting Help

If you need help with ObservedKeyPathsMacros, here are the best ways to get support:

### 📚 Documentation
- **README.md** - Start here for installation and basic usage
- **Examples/** - Working code examples
- **CHANGELOG.md** - Recent changes and updates

### 🐛 Bug Reports
If you found a bug, please:
1. Check existing issues to see if it's already reported
2. Create a new issue using the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md)
3. Include all requested information (OS, Xcode version, code example)

### 💡 Feature Requests
Have an idea for improvement?
1. Check existing feature requests
2. Create a new issue using the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md)
3. Explain your use case and proposed solution

### ❓ Questions & Discussions
- **GitHub Discussions** - For general questions and community help
- **GitHub Issues** - For specific problems or feature requests

### 🔧 Development Support
- **CONTRIBUTING.md** - How to contribute to the project
- **CODE_OF_CONDUCT.md** - Community guidelines
- **Tests/** - Examples of how to use the macros

## Common Issues

### Build Errors
- Ensure you're using Swift 5.10+ and Xcode 15.0+
- Check that your deployment target is iOS 17.0+ or macOS 10.15+
- Verify swift-syntax dependency is properly resolved

### Macro Not Working
- Make sure you've imported `ObservedKeyPaths`
- Check that your class/struct has the `@Observable` attribute
- Verify the `@GenerateObservedKeyPaths` macro is applied

### Property Not Tracked
- Properties must be stored properties (not computed)
- Static properties are automatically ignored
- Use `@ObservationTracked` to explicitly mark properties
- Use `@ObservationIgnored` to exclude properties

## Community Resources

- **Swift Forums** - [Observation framework discussions](https://forums.swift.org/c/evolution/observation)
- **Swift Documentation** - [Macros guide](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/macros/)
- **SwiftUI Documentation** - [State and data flow](https://developer.apple.com/documentation/swiftui/state-and-data-flow)

## Professional Support

For enterprise or commercial support:
- **Email**: [support@kramlex.com]
- **Response Time**: Within 24 hours during business days
- **Priority Support**: Available for sponsors and enterprise users

## Contributing to Support

Help improve support for everyone:
- Answer questions in GitHub Discussions
- Improve documentation
- Report unclear error messages
- Suggest improvements to templates

Thank you for using ObservedKeyPathsMacros! 🚀
