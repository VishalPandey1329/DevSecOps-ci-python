package policy

# Deny if any vulnerability in input has severity CRITICAL or HIGH (Trivy schema)
deny[msg] {
  some i
  vuln := input.Results[_].Vulnerabilities[i]
  vuln.Severity == "CRITICAL"
  msg = sprintf("CRITICAL vulnerability found: %s", [vuln.Title])
}

deny[msg] {
  some i
  vuln := input.Results[_].Vulnerabilities[i]
  vuln.Severity == "HIGH"
  msg = sprintf("HIGH vulnerability found: %s", [vuln.Title])
}
