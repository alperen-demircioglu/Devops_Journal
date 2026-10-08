# CKA Study Context

Preparing for the Certified Kubernetes Administrator (CKA) exam, target **December 2026**.

## Exam facts

- Hands-on, 2 hours, live clusters in a terminal. Only kubernetes.io docs allowed.
- Exam Kubernetes version: v1.35 as of the last check (Oct 2026). The exam tracks the latest minor release within ~4-8 weeks of its release, so it may be newer by December. Confirm in the Candidate Handbook before the exam.
- Domain weights: Troubleshooting 30%, Cluster Architecture/Installation/Config 25%, Services & Networking 20%, Workloads & Scheduling 15%, Storage 10%.

## Current state

- No local Kubernetes cluster set up yet; no version chosen. When one is set up, use the exam's version (or the closest available) and record it here.

## How to help

- Answer in Turkish; keep commands, YAML, and Kubernetes terms in English.
- Never state a version-specific flag, API, or command from memory as certain. Check kubernetes.io for the exam version, or say it needs verifying.
- Prefer the fastest exam-style approach (imperative commands, `--dry-run=client -o yaml`, `kubectl explain`) over long manifests. Time is the constraint.
- Point to the relevant kubernetes.io page when useful, since the docs are the only allowed reference in the exam.
- Weigh effort by domain weight; Troubleshooting is the biggest.
- When asked to quiz me, ask first and reveal the answer after I respond.

## Files

- `cheatsheet.md`: kubectl shortcuts and YAML skeletons
- `mistakes.md`: my mistake log; read it to find weak topics and build practice questions. Add entries with `./mistake.sh`.
- `README.md`: exam info, curriculum weights, progress tracker
