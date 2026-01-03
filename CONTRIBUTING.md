# Contributing Guidelines

Thank you for your interest in contributing to this project! Please review the following guidelines before submitting your contributions.

## Branch Strategy

### Development Workflow
- **All commits must be made to a development branch**, not directly to `master`
- Development branches should be created from the latest `master` branch
- Branch naming convention: Use descriptive names such as `feature/feature-name`, `bugfix/issue-description`, or `refactor/component-name`

### Hotfix Exception
- **Hotfixes are the only exception** to the dev branch requirement
- Hotfixes may be committed directly to address critical production issues
- All hotfixes must be approved through a diff review by project Maintainers before merging
- Hotfixes should still follow proper commit message conventions

## Merge Process

### Merge Requests
- All merge requests must target the `master` branch
- Branches may be outdated as long as there are no direct conflicts with `master`
- Provide a clear description of changes in the merge request
- Include a proper changelog in the merge request description as per the default GitLab template
- Update documentation where your changes affect user-facing features or functionality
- Link any relevant issues or tickets

### Review Requirements
- Merge requests require approval from at least one Maintainer
- Address all review comments before merging
- Ensure all automated checks pass before requesting review

## Code Standards

### Before Submitting
- Perform thorough user testing of your changes
- Test all affected functionality from an end-user perspective
- Document your testing steps in the merge request description

## Documentation Standards

### Documentation Requirements
- Update all relevant documentation when making changes to functionality
- Keep documentation clear, concise, and up to date
- Use proper formatting and structure

### API Documentation
- When using external APIs, provide links to the relevant API documentation
- Include version information for APIs where applicable
- Document any API-specific configuration or setup requirements

### AI/LLM Usage Disclosure
- Any use of AI or LLM agents (such as ChatGPT, Claude, Copilot, etc.) must be clearly documented in the merge request
- Specify how the AI/LLM was used in your development process
- Explain how AI-generated contributions were vetted and verified
- Clearly identify which parts of the code were created or modified with AI assistance
