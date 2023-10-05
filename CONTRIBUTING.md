# SwissSchema Contribution Guide

This document documents information about how to maintain and contribute to SwissSchema.

## Contributing Checklist

- [ ] **Commit messages must follow [Conventional Commits](https://www.conventionalcommits.org)**  
       _It distinguishes commits types (fixes, features, rewrites, etc.) and is required for changelogs_
- [ ] **Every commit must pass the quality workflow (style, analysis, test, etc.)**  
       Commits must always change the codebase to a working state (aka.: no breaking commits)
- [ ] **Updates to deps list must be isolated**  
       _This is a security practice. Any change to the deps list (adding, removing items - even version adjusts), can introduce security issues, and these changes are manually reviewed. Isolating them into their own commits can facilitate code reviews._
