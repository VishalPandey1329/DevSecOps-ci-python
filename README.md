# Automated DevSecOps CI/CD with Vulnerability Gates (Python / Flask)

This repository is a **complete demo** for a DevSecOps pipeline that:
- Runs SAST (Semgrep)
- Generates an SBOM (syft)
- Builds a Docker image
- Scans image with Trivy
- Evaluates policy using Conftest/OPA
- Blocks PRs when High/Critical findings are present

## How to use locally

1. Create and activate a virtualenv:
   ```bash
   python -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```

2. Run the app:
   ```bash
   python app/app.py
   ```

3. Build Docker image:
   ```bash
   docker build -t devsecops-demo:latest .
   ```

4. Generate SBOM (if syft installed locally):
   ```bash
   ./scripts/generate_sbom.sh
   ```

5. Scan image with Trivy (if trivy installed):
   ```bash
   ./scripts/scan_trivy.sh devsecops-demo:latest
   ```

## CI
The GitHub Actions workflow (`.github/workflows/ci.yml`) runs automatically on pull requests and uploads scan artifacts.

## Files of interest
- `app/app.py` — sample Flask app
- `Dockerfile` — container image
- `.github/workflows/ci.yml` — DevSecOps pipeline
- `security/semgrep.yml` — Semgrep rules (example)
- `security/policy.rego` — Conftest/OPA policy

## How to push to GitHub (example)
1. Create a new repository on GitHub (e.g., `devsecops-ci-python`)
2. From this project folder:
   ```bash
   git init
   git add .
   git commit -m "Initial commit - DevSecOps pipeline demo"
   git branch -M main
   git remote add origin https://github.com/<your-username>/devsecops-ci-python.git
   git push -u origin main
   ```

## Notes
- CI uses GitHub Container Registry (GHCR) to tag the image; the workflow logs in using `GITHUB_TOKEN`.
- Instructors may require you to set repository visibility or provide GHCR access — for simpler demos you can remove GHCR push steps.
