# Kubernetes: 5W1H, Development Process, Security and Testing

Sourced notes, checked against official pages on 2026-10-08. Every claim carries a source link. Items I could not verify are listed at the end; do not rely on them.

## 1. 5W1H

| Question | Answer | Source |
|----------|--------|--------|
| **What** | "a portable, extensible, open source platform for managing containerized workloads and services that facilitate both declarative configuration and automation." Not a traditional all-inclusive PaaS; it provides building blocks. | [Overview](https://kubernetes.io/docs/concepts/overview/) |
| **Who** | Open-sourced by Google; today a CNCF project. Many Kubernetes developers at Google previously worked on Borg. | [Overview](https://kubernetes.io/docs/concepts/overview/), [Borg article, 2015](https://kubernetes.io/blog/2015/04/borg-predecessor-to-kubernetes/) |
| **When** | Open-sourced by Google in 2014. Accepted into CNCF (Incubating) on March 10, 2016; Graduated on March 6, 2018. | [Overview](https://kubernetes.io/docs/concepts/overview/), [CNCF project page](https://www.cncf.io/projects/kubernetes/) |
| **Where** | Anywhere containers run: cloud, on-premises, local. (Portable by design; see "portable" in the definition above.) | [Overview](https://kubernetes.io/docs/concepts/overview/) |
| **Why** | Service discovery and load balancing, storage orchestration, automated rollouts and rollbacks, automatic bin packing, self-healing, secret and configuration management, horizontal scaling. | [Overview](https://kubernetes.io/docs/concepts/overview/) |
| **How** | "a set of independent, composable control processes that continuously drive the current state towards the provided desired state." Centralized control is not required. | [Overview](https://kubernetes.io/docs/concepts/overview/) |

Borg lineage: Kubernetes carried over Borg's ideas (Pods ~ Borg alloc, Services, labels, IP-per-Pod) and tried to fix pain points Borg users reported. Source: [Borg article](https://kubernetes.io/blog/2015/04/borg-predecessor-to-kubernetes/) (2015, the page notes it may be outdated).

## 2. Governance

- **SIGs** are the main organizational unit. "Every identifiable subpart of the project ... is intended to be owned by some SIG." Each SIG needs chairs and a charter and must communicate openly.
- **Working groups** handle short-lived or cross-SIG topics.
- **Committees** handle sensitive topics such as security or conduct; they do not have open membership.
- **Steering Committee:** a 7-member body overseeing project governance. Cross-SIG decisions are coordinated by the affected SIGs (KEP process for larger efforts); escalation to Steering "is expected to be uncommon."
- Contributions are judged on technical merit; the community follows the Code of Conduct; all contributors must sign the CNCF CLA.
- **License:** Apache License 2.0.

Sources: [Governance](https://github.com/kubernetes/community/blob/master/governance.md), [Steering](https://github.com/kubernetes/steering), [LICENSE](https://github.com/kubernetes/kubernetes/blob/master/LICENSE)

## 3. Change process

- **KEP (Kubernetes Enhancement Proposal):** "a way to propose, communicate and coordinate on new efforts for the Kubernetes project." Needed for anything potentially controversial, most new features (excluding very small ones), major changes to existing features, and wide-ranging changes. Each SIG decides for smaller work. Source: [KEP README](https://github.com/kubernetes/enhancements/blob/master/keps/README.md)
- **Feature gates:** key=value pairs, set per component with `--feature-gates`. Alpha features are listed with default `false`; most Beta features default to `true`, with exceptions. Source: [Feature gates](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/)
- **Deprecation policy (API versions):**
  - GA (v1): may be deprecated but must not be removed within a major version.
  - Beta: deprecated no more than 9 months or 3 minor releases after introduction (whichever is longer), no longer served 9 months or 3 minor releases after deprecation (whichever is longer).
  - Alpha: may be removed in any release without notice.
  - API elements may only be removed by incrementing the API group version.
  
  Source: [Deprecation policy](https://kubernetes.io/docs/reference/using-api/deprecation-policy/)

## 4. Releases and support

- Patch support: "roughly fourteen (14) months" per release series; first 12 months standard, last 2 maintenance mode (CVE fixes, dependency issues, critical core component issues).
- Patch cadence: typically monthly.
- Supported as of this check: 1.37, 1.36, 1.35 (active), 1.34 (maintenance, EOL Oct 27, 2026). The page was last modified April 14, 2026 but lists later dates; confirm on the live page.
- Release rhythm (derived, not stated): the maintenance-mode dates in the table fall about four months apart (1.34: Aug 2026, 1.35: Dec 2026, 1.36: Apr 2027, 1.37: Aug 2027), which means roughly three minor releases per year.

Source: [Patch releases](https://kubernetes.io/releases/patch-releases/)

## 5. Testing

- **Unit tests:** `make test`; should be hermetic and pass on macOS and Windows.
- **Integration and e2e tests:** exist and are documented in separate guides (not read here).
- **CI:** Prow runs pre-submit tests on every PR (non-members need `/ok-to-test`). "Kubernetes only merges pull requests when unit, integration, and e2e tests are passing."
- **TestGrid** visualizes CI status: tests as rows, jobs as tabs, dashboards grouping jobs, with run history.

Source: [Testing guide](https://github.com/kubernetes/community/blob/master/contributors/devel/sig-testing/testing.md)

- **Conformance:** the Certified Kubernetes Conformance Program lets vendors certify products. Submissions need `e2e.log` and `junit_01.xml` generated with Sonobuoy or Hydrophone, and pass automated checks before CNCF review. Source: [cncf/k8s-conformance](https://github.com/cncf/k8s-conformance)
  - Note: this certifies products (distributions). The CKA is a separate, personal certification.

## 6. Security

- **Reporting:** via the [bug bounty](https://hackerone.com/kubernetes) or the private `security@kubernetes.io` list. GPG encryption is optional.
- **Response:** reports are acknowledged and analyzed by Security Response Committee members within 3 working days, which starts the Security Release Process. Disclosure date is negotiated; for straightforward mitigations, report-to-disclosure is expected on the order of 7 days. Announcements go to `kubernetes-security-announce`.
- **External audits:** the SIG-Security repo has audit folders for 2019 (RFP, vendor selection, findings), 2021-2022, a 2022 fuzzing audit, and 2025. The auditing firms and findings are in those folders; I did not read them.
- **Release integrity:** all binary artifacts (tarballs, SPDX files, standalone binaries) are signed with cosign keyless signing; image signing and SBOMs (served from `sbom.k8s.io`) are published. Feature state: Beta since v1.26.
- **For cluster operators:** Pod Security Standards define three profiles: Privileged (unrestricted), Baseline (minimally restrictive, blocks known privilege escalations), Restricted (heavily restricted, follows hardening best practices).

Sources: [Security](https://kubernetes.io/docs/reference/issues-security/security/), [External audits](https://github.com/kubernetes/sig-security/tree/main/sig-security-external-audit), [Verify signed artifacts](https://kubernetes.io/docs/tasks/administer-cluster/verify-signed-artifacts/), [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)

## 7. Not verified (do not rely on these)

- How Steering Committee members are chosen (the page links to an elections document I did not read).
- Lazy consensus and `OWNERS`/auto-merge details (not on the governance page I read).
- The KEP section list (test plan, production readiness, graduation criteria) and the exact definitions of Alpha/Beta/GA stages.
- The auditing firms and results of each security audit.
- The official release cadence statement (`sig-release` versioning page returned 404).
- How the Release Team is organized.
