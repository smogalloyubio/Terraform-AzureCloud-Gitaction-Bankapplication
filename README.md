# SimpleBank DevSecOps Project

This repository contains the SimpleBank application, a modern React/TypeScript banking dashboard integrated with a microservices backend (currently in sandbox/mock mode).

## DevSecOps CI Pipeline

The SimpleBank project implements a production-grade DevSecOps CI pipeline using GitHub Actions. This pipeline ensures that every code change is validated for security, quality, and compliance before it can be considered for deployment.

### Pipeline Stages & Security Tools

| Stage | Tool | Description |
| :--- | :--- | :--- |
| **Secret Scanning** | Gitleaks | Scans the entire repository history for leaked secrets and credentials. |
| **Dependency Audit** | `npm audit` | Checks for known vulnerabilities in the project's dependency tree. |
| **Static Analysis (SAST)** | CodeQL | Deep semantic analysis of the codebase to identify security vulnerabilities. |
| **Filesystem Scan** | Trivy | Scans the repository for vulnerabilities and misconfigurations. |
| **Type Checking** | TypeScript (`tsc`) | Validates structural integrity and type safety of the application. |
| **Production Build** | Vite | Verifies that the application can be successfully compiled for production. |
| **Software Bill of Materials** | Syft | Generates a CycloneDX SBOM for the application dependencies. |

### Artifact Strategy

Every major stage of the pipeline produces a dedicated, downloadable artifact in the GitHub Actions run. This allows for granular inspection of security reports and build outputs:

*   `simplebank-gitleaks`: Gitleaks SARIF reports.
*   `simplebank-dependency-audit`: JSON output of `npm audit`.
*   `simplebank-lint`: Results of the linting process.
*   `simplebank-typescript`: TypeScript compiler output.
*   `simplebank-tests`: Unit test results (currently **NOT FOUND**).
*   `simplebank-codeql`: SAST analysis results.
*   `simplebank-frontend-build`: The final production-ready `dist/` directory.
*   `simplebank-application-sbom`: CycloneDX SBOM in JSON format.
*   `simplebank-trivy-filesystem`: Vulnerability reports for the repository.

### Vulnerability Policy

The pipeline enforces a strict security gate:
*   **FAIL**: The build will fail if Gitleaks detects any secrets.
*   **FAIL**: The build will fail if Trivy detects **CRITICAL** or **HIGH** vulnerabilities in the filesystem.
*   **FAIL**: The build will fail if any TypeScript or Build errors occur.

### Local Reproduction

You can reproduce the primary CI checks locally using the following commands:

```bash
# Install dependencies
npm ci

# Run Type Checking (mapped to lint)
npm run lint

# Audit dependencies
npm audit

# Production Build
npm run build

# Run Trivy Scan (requires Trivy installed)
trivy fs .
```

---

## Project Structure

*   `src/`: React frontend source code.
*   `server.ts`: Node.js sandbox/mock server.
*   `simplebank/`: Original Java/microservices backend and documentation.
*   `.github/workflows/`: CI/CD pipeline definitions.
