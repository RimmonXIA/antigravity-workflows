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
| **New Feature (Backend)** | `/implement` | Full lifecycle: Requirements -> Plan -> Code (TDD) -> Review. |
| **New Feature (Frontend)** | `/front-design` | Step 1: Design React components. |
| **Frontend Build** | `/front-build` | Step 2: Implement components from design. |
| **Quick Fix** | `/task` | Execute a single, specific task (Backend/General). |
| **Bug Investigation** | `/diagnose` | Deep dive investigation using the `investigator` persona. |
| **Reverse Engineering** | `/reverse-engineer` | Generate PRDs and Design Docs from existing code. |
| **Update Docs** | `/update-doc` | Update existing design documents. |

### Example Usage

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
