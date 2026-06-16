# robot-api-tests — Agent Context

## Purpose
Keyword-driven API test suite targeting a public REST API.

## Status
In Progress.

## Tech Stack
Robot Framework · RequestsLibrary · REST API · keyword-driven.

## Architecture Intent
Keyword-driven design: reusable keywords in resource files, test cases compose keywords.
Covers CRUD operations, authentication, error handling, and edge cases. Robot Framework
generates output.xml / log.html / report.html.

## Planned Layout (not yet created)
- `tests/` — .robot test suites
- `resources/` — reusable keyword + variable files
- `results/` — generated Robot reports
- `requirements.txt` — deps (robotframework, robotframework-requests)

## Conventions
- Relative paths only — repo is portable.
- Test cases call keywords; no raw HTTP logic inline.
