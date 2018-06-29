# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2018-06-29
### Added
- Added support for 'import sheet from XLSX, CSV file' endpoints

## [1.1.0] - 2018-03-16
### Added
- Integration test suite (see https://github.com/smartsheet-platform/smartsheet-sdk-tests)
- Endpoints for automation rules
- Endpoint for 'sort rows in sheet'
- Endpoints for cross-sheet references
- Support for looser JSON content types in responses
- Support for custom app name in the user agent header
- URL constructor for requesting app authorization from a user
- This changelog

### Changed
- Empty filenames in file-accepting endpoints are now equivalent to nil filenames
- Specifying `Assume-User` header override in a request will now override the `assume_user` value configured in a client
- Client now requests and handles gzipped responses

### Removed
- Unsupported `filename` and `content_type` attributes in `RequestSpec` (internal)


## [1.0.0] - 2017-11-08
### Added
- Error type `Smartsheet::HttpResponseError` for HTTP failures that do not correspond to Smartsheet errors
- Basic YARD documentation
- Re-add support for Ruby versions ~> 2.2 (from > 2.2)

### Fixed
- Removing one or many favorite sights now uses the correct URL


## [1.0.0.beta.2] - 2017-10-12
### Added
- Inspect formatting for the Smartsheet client (for interactive use)

### Changed
- Log retry failures only when retries were actually attempted, and not on non-retryable failures
- Accept an empty string for a client token as being equivalent to a nil token
- Adjust formatting of logs

### Deprecated
- Required Ruby versions restricted to > 2.2 (from ~> 2.2)

### Removed
- Read-write-sheet example (now available at https://github.com/smartsheet-samples/ruby-read-write-sheet)

### Fixed
- Pass the 'log full body' client configuration flag correctly
- Log responses

### Security
- **Properly censors client tokens** by fixing the header censor to no longer be case-sensitive


## [1.0.0.beta.1] - 2017-10-10
### Changed
- Set required Ruby version to ~> 2.2


## [1.0.0.beta.0] - 2017-10-10
### Added
- Endpoints for sheets
- Endpoints for rows
- Endpoints for columns
- Endpoints for comments
- Endpoints for attachments
- Endpoints for update requests
- Endpoints for folders
- Endpoints for home
- Endpoints for workspaces
- Endpoints for favorites
- Endpoints for users
- Endpoints for contacts
- Endpoints for groups
- Endpoints for reports
- Endpoints for sights
- Endpoints for templates
- Endpoints for search
- Endpoints for sharing
- Endpoints for webhooks
- Endpoints for server info
- Endpoints for API token management
- Support for making arbitrary requests
- Support for assuming the role of a user as an administrator
- Support for automatic request retry
- Support for logging
- Test suite with unit tests and two-column-accounting endpoint tests

[Unreleased]: https://github.com/smartsheet-platform/smartsheet-ruby-sdk/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/smartsheet-platform/smartsheet-ruby-sdk/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/smartsheet-platform/smartsheet-ruby-sdk/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/smartsheet-platform/smartsheet-ruby-sdk/compare/v1.0.0.beta.2...v1.0.0
[1.0.0.beta.2]: https://github.com/smartsheet-platform/smartsheet-ruby-sdk/compare/v1.0.0.beta.1...v1.0.0.beta.2
[1.0.0.beta.1]: https://github.com/smartsheet-platform/smartsheet-ruby-sdk/compare/v1.0.0.beta.0...v1.0.0.beta.1
[1.0.0.beta.0]: https://github.com/smartsheet-platform/smartsheet-ruby-sdk/compare/init...v1.0.0.beta.0