Created by: mr.shakey
Overview
AdminX is a comprehensive command-line security assessment tool designed for penetration testers, security researchers, and system administrators. Built with bash scripting for maximum compatibility and lightweight deployment, AdminX provides essential web application security testing capabilities in a single, portable tool.

Core Features
🔍 XSS Vulnerability Detection

Cross-Site Scripting Scanner: Identifies reflected, stored, and DOM-based XSS vulnerabilities

Payload Injection: Tests web forms and parameters with various XSS payloads

Response Analysis: Analyzes server responses to detect successful XSS injection points

Filter Bypass: Attempts to bypass common XSS filters and WAF protections

🔐 Authentication Security Testing

Login Form Analysis: Tests authentication mechanisms for common vulnerabilities
SQL Injection Detection: Probes login forms for SQL injection vulnerabilities
Brute Force Protection: Evaluates account lockout and rate limiting mechanisms
Credential Validation: Tests for weak password policies and default credentials

🍪 Cookie Security Analysis

Cookie Extraction: Captures and catalogs all cookies from target applications
Security Flag Analysis: Checks for missing Secure, HttpOnly, and SameSite flags
Sensitive Data Detection: Identifies cookies containing potentially sensitive information
Session Token Analysis: Evaluates session management security practices

Key Capabilities

Automated Scanning: Streamlined security assessment workflow
Detailed Reporting: Comprehensive vulnerability reports with severity ratings
Stealth Mode: Configurable request timing to avoid detection
Multi-Target Support: Scan multiple URLs and endpoints
Export Functionality: Generate reports in multiple formats

Use Cases

Penetration Testing: Essential tool for web application security assessments
Bug Bounty Hunting: Identify common web vulnerabilities for responsible disclosure
Security Audits: Systematic evaluation of web application security posture
Development Testing: Pre-deployment security validation for development teams
Compliance Verification: Ensure applications meet security standards

Advanced Options..>>

./adminx.sh -u https://example-admin-panel.com/login \
                -p "<script>alert(document.cookie)</script>" \
                -c /tmp/admin_cookies.txt \
                -l /var/log/xss_attack.log \
                -d /tmp/xss_attack_dir \
                -v /tmp/vulnerabilities.txt \
                -x /tmp/xss_payloads.txt

Technical Specifications

Platform: Cross-platform bash script
Dependencies: Standard Unix/Linux utilities (curl, grep, awk)
Output: Terminal display with optional file logging
Portability: Single script deployment, no installation required

Ethical Use Notice
⚠️ IMPORTANT: AdminX is designed for authorized security testing only. Users must obtain explicit written permission before testing any web application or system. This tool is intended for legitimate security research, penetration testing, and educational purposes only.
Target Audience

Penetration Testers
Security Researchers
System Administrators
Web Developers
Cybersecurity Students
Bug Bounty Hunters


AdminX combines simplicity with power, providing security professionals with a reliable, efficient tool for web application security assessment. Its bash-based architecture ensures maximum compatibility while delivering comprehensive security testing capabilities.
