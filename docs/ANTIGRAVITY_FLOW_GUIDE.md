# Antigravity Flow Guide

## 1. The Core Loop (Standard Mode)

For new features and complex changes, we follow the **Standard Mode** loop defined in the Constitution.

### Phase 1: Planning
1.  **Ideation**: Use `/ideate` to brainstorm and generate a PRD.
2.  **Analysis**: Use `/implement` with your input manifest.
3.  **Design**: The agent acts as `technical-designer` to create a `docs/design/*.md` file.
    - **Change Management**: If you need to change the design during this phase, use `/amend`.
4.  **Review**: The `document-reviewer` skill validates the design.

### Phase 2: Execution
1.  **Plan**: The `work-planner` breakdowns the design into tasks.
2.  **Execute**: The `task-executor` implements code (Red-Green-Refactor).
3.  **Verify**: The `quality-fixer` ensures TDD compliance.

### Phase 3: Consistency
1.  **Commit**: Code is committed to git.
2.  **Reconcile**: Use `/reconcile` to ensuring the `docs/` reflect the final code state.

---

## 2. The Turbo Loop (Turbo Mode)

For small fixes (< 3 files, < 50 LOC), we bypass the heavy planning phase.

1.  **Trigger**: `/quick-task "fix typo"`
2.  **Gate**: Agent checks file count. If > 3, it rejects and suggests `/implement`.
3.  **Execute**: Immediate `task-executor` run.
4.  **Safeguard**: You MUST run `/reconcile` periodically to catch documentation drift caused by these quick fixes.

---

## 3. Maintenance Protocols

### The Amendment Protocol (`/amend`)
**When**: You want to change the plan *before* or *during* execution.
**Why**: To ensure "Design-Code Consistency" from the start.
**Action**:
- Updates the `docs/design/*.md` file.
- Triggers a re-review.

### The Reconciliation Protocol (`/reconcile`)
**When**: You changed code *without* a plan (e.g., Turbo Mode, Hotfix).
**Why**: To prevent "Documentation Rot".
**Action**:
- Scans `git log` for recent changes.
- Updates `docs/` to match the reality of the code.

---

## 4. Decision Matrix

| Situation | Command | Rationale |
| :--- | :--- | :--- |
| **New Feature** | `/implement` | Needs full rigorous planning. |
| **Bug Fix (Simple)** | `/quick-task` | Low risk, speed is priority. |
| **Bug Fix (Complex)** | `/diagnose` | Needs investigation first. |
| **Change Plan** | `/amend` | Design must stay truthful. |
| **Fixed code manually** | `/reconcile` | Docs must catch up to code. |
