# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),  
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

---

## [0.2.0] - 2025-04-23

### Added
- New block: `Spoiler` – supports nested content via recursive rendering of inner `Document`.
- New block: `Table` – renders as HTML `<table>` or plain text with pipe-delimited rows.
- YAML schemas for `spoiler.yml` and `table.yml`, with validation on required structure.
- Full test coverage for `Spoiler` and `Table` blocks, including deep nesting scenarios.
- Support for nested blocks within blocks (recursive `Document` rendering).
- Improved error messages for validation failures.

### Changed
- `Document` now validates block structure more strictly (e.g., `id`, `type`, `data`, `tunes`).
- Validation is no longer performed in block `initialize`, but deferred to `block_data` access.

### Fixed
- Multiple RuboCop and RSpec style issues (e.g., multiple expectations per example).
- Schema for `paragraph` block now validated only within its `data`.

---

### Added
- Initial support for rendering Editor.js blocks (`paragraph`) in HTML and plain text.
- JSON schema validation for documents and blocks.
- Configurable list of allowed block types.
- Default error handling and logging of skipped blocks.
- Documentation for each component and setup.

---

## [0.1.0] - 2025-04-22

### Added
- First public release of the `editor_rails` gem.
