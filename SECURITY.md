# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

## Reporting a Vulnerability

We take security vulnerabilities seriously. If you discover a security issue, please follow these steps:

### 1. **DO NOT** create a public GitHub issue
Security vulnerabilities should be reported privately to prevent exploitation.

### 2. **Email us directly** at [security@yourdomain.com]
Please include:
- A clear description of the vulnerability
- Steps to reproduce the issue
- Potential impact assessment
- Suggested fix (if available)

### 3. **Wait for response**
We will acknowledge your report within 48 hours and provide updates on the investigation.

### 4. **Disclosure timeline**
- **Immediate**: Critical vulnerabilities (remote code execution, data breaches)
- **7 days**: High severity vulnerabilities
- **30 days**: Medium severity vulnerabilities
- **90 days**: Low severity vulnerabilities

## Security Best Practices

### For Users
- Keep dependencies updated
- Review generated code for security implications
- Use the latest stable versions
- Report suspicious behavior immediately

### For Contributors
- Follow secure coding practices
- Validate all inputs in macros
- Avoid code injection vulnerabilities
- Test security edge cases

## Security Features

- **Input validation**: All macro inputs are validated
- **Code generation safety**: Generated code follows Swift security best practices
- **Dependency scanning**: Regular security audits of dependencies
- **Access control**: Proper access modifiers for generated code

## Responsible Disclosure

We believe in responsible disclosure and will:
- Work with reporters to understand and fix issues
- Provide credit in security advisories
- Coordinate with the broader Swift community when needed
- Maintain transparency about security practices

## Security Contacts

- **Security Team**: [security@yourdomain.com]
- **Lead Maintainer**: [maintainer@yourdomain.com]
- **Emergency**: [emergency@yourdomain.com]

## Security Updates

Security updates are released as:
- **Patch releases** (1.0.1, 1.0.2) for critical fixes
- **Minor releases** (1.1.0, 1.2.0) for security improvements
- **Major releases** (2.0.0) for breaking security changes

## Bug Bounty

Currently, we do not offer a formal bug bounty program, but we do appreciate security researchers who:
- Follow responsible disclosure practices
- Provide detailed vulnerability reports
- Help improve our security posture

Thank you for helping keep ObservedKeyPathsMacros secure! 🔒
