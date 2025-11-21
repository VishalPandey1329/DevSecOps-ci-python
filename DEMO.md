## Quick demo steps to show pipeline blocking

1. Introduce a vulnerable dependency (example): edit `requirements.txt` and add a package known to have a vulnerability.
2. Commit & open a Pull Request — GitHub Actions will run.
3. The `trivy` step will scan the built image; if any HIGH/CRITICAL vulnerabilities exist the pipeline will fail.
4. Fix dependency or update package, push again — pipeline should pass.

You can also test Semgrep by adding unsafe code patterns (e.g., `eval()` in Python) to see Semgrep report a finding.
