# Workflow & Skill Guide

This repository contains a suite of specialized **Workflows** and **Skills** designed to automate complex development tasks within Antigravity.

![Architecture](./PROJECT_ARCHITECTURE.md)

## ⚡ Quick Start: Native Agent Features

This repository utilizes Google Antigravity's **Agent-First Design**.
- **Skills**: Modular capabilities located in `.agent/skills`.
- **Workflows**: Autonomous plans located in `.agent/workflows`.
- **Artifacts**: The agent will create plans and diagrams in your workspace.

### Slash Commands

| Goal | Command | Description |
| :--- | :--- | :--- |
| **Ideation** | `/ideate` | Interactive research & prototyping to create a PRD. |
| **New Feature (Backend)** | `/implement` | Full lifecycle: Requirements -> Plan -> Code (TDD) -> Review. |
| **New Feature (Frontend)** | `/front-design` | Step 1: Design React components. |
| **Frontend Build** | `/front-build` | Step 2: Implement components from design. |
| **Quick Fix** | `/task` | Execute a single, specific task (Backend/General). |
| **Bug Investigation** | `/diagnose` | Deep dive investigation using the `investigator` persona. |
| **Reverse Engineering** | `/reverse-engineer` | Generate PRDs and Design Docs from existing code. |
| **Update Docs** | `/amend` | Update existing design documents. |

### 3. Rapid Fixes (Turbo Mode)
> **/quick-task**

**Purpose**: High-speed execution for "Atomic Fixes" (<50 LOC).
**When to Use**:
- Typos / Label changes
- Single-function bug fixes
- CSS adjustments

**Security Protocol**:
1.  **Complexity Gate**: The agent analyzes file count. If >3 files, it REJECTS.
2.  **No Design Doc**: It skips the design phase.
3.  **No Work Plan**: It creates a transient plan in memory.

---

### 4. Documentation Safeguard
> **/reconcile**

**Purpose**: "Garbage Collection" for Documentation Drift.
**When to Use**:
- **Fridays**: Run before weekend.
- **Pre-Release**: Run before merging to main.

**Mechanism**:
- **Active Scanner**: `git log` scans last 7 days.
- **Drift Detection**: Finds files changed without doc updates.
- **Back-propagation**: Updates Design Docs to match reality.

- **Back-propagation**: Updates Design Docs to match reality.

---

### 5. Maintenance & Audits

#### Update Design (Planning)
> **/amend** "Add new API field"

**Purpose**: Formal change management.
**Use Case**: You want to change the plan *before* coding (Strong Consistency).

#### Compliance Check (Verification)
> **/review** (Backend) or **/front-review** (Frontend)

**Purpose**: "Is my code legal according to the Design Doc?"
**Use Case**: Run this before a major merge to ensure you haven't drifted from the approved design.

#### Cognitive Audit (Deep Logic)
> **/cognitive_integrity_protocol**

**Purpose**: The "Sanity Check".
**Mechanism**:
- Reads the entire project topology.
- Looks for "Fractal Inconsistencies" (e.g., naming clashes, logic gaps).
- Produces a "Mental Model Alignment Report".

> **/ideate** I want a platform for sharing AI prompts.

> **/implement** Add a user login API using JWT.

> **/front-build** Create the settings page components.

> **/diagnose** Why is the API returning 500?

> **/diagnose** Why is the API returning 500?

---

## 🤝 Interactive Artifacts Guide

The agent communicates intent through **Session Artifacts**. You will see these appear in your IDE's "Brain" or "Artifacts" pane.

| Artifact | Created By | Purpose | Action Required |
| :--- | :--- | :--- | :--- |
| `requirements.md` | `requirement-analyzer` | Summary of what you asked. | **Confirm** scope and scale. |
| `prd.md` | `prd-creator` | Detailed specs and user stories. | **Review** & Approve. |
| `implementation_plan.md` | `technical-designer` | Technical blueprint & file changes. | **Approve** to start coding. |
| `task.md` | `work-planner` | Live progress checklist. | **Watch** progress. |
| `code_review.md` | `code-reviewer` | Quality report on the code. | **Read** before merging. |
| `walkthrough.md` | `quality-fixer` | Final summary of work done. | **Celebrate**! |

**Workflow Tip**: If an artifact appears, the Agent is likely pausing for your feedback. Use the chat to say "Approved" or "Change X".

## 🧠 Manual Skill Usage

While workflows (Slash Commands) handle processes, you can also ask for ad-hoc expert advice by invoking a **Skill**.

| Skill | Usage Trigger | Capability |
| :--- | :--- | :--- |
| **Backend Specialist** | `use the task-executor skill` | Expert in TDD, API design, and clean code. |
| **Frontend Specialist** | `use the task-executor-frontend skill` | Expert in React, TypeScript, and RTL. |
| **Technical Designer** | `use the technical-designer skill` | Expert in architectural planning and ADRs. |

> **User:** "Use the **coding-principles** skill to review `src/utils.ts`."
