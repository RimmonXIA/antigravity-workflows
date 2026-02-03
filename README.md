# Antigravity Developer Workflows

[![Constitution](https://img.shields.io/badge/Constitution-Supreme_Law-red)](.agent/rules/00_constitution.md)
[![Antigravity Native](https://img.shields.io/badge/Antigravity-Native-purple)](https://antigravity.google)
[![Dual Memory](https://img.shields.io/badge/Dual_Memory-Active-blue)](#the-dual-memory-philosophy)

> ⚠️ **CONSTITUTION**: All work must strictly adhere to the [Workflow Constitution](.agent/rules/00_constitution.md). This is the supreme law of this workspace.
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Production-ready agentic workflows for Google Antigravity.**
This repository transforms your Antigravity agent into a disciplined engineering partner, capable of planning, testing, and implementing code with strict quality controls.

---

## 🚀 Features

### Agent-First Design
Instead of simple autocompletion, this project provides **Autonomous Workflows**:
- **Requirement Analysis**: The agent stops to think and plan before coding.
- **Visual Cognitive Anchoring**: Agents use **Mermaid Diagrams** to visualize complex logic and decision trees.
- **TDD Enforcement**: The agent writes tests before implementation (Red-Green-Refactor).
- **Quality Gates**: The agent automatically runs linters and tests before committing.

### Native Integration
- **Slash Commands**: Access workflows instantly via `/implement`, `/diagnose`, etc.
- **Skills**: The agent automatically adopts expert personas (e.g., `task-executor`, `investigator`) as needed.

> See [Usage Guide](docs/ANTIGRAVITY_USAGE.md) for detailed instructions and [Architecture](docs/PROJECT_ARCHITECTURE.md) for the design.

---

## 📦 Concepts

| Concept | Description |
| :--- | :--- |
| **Workflows** (`.agent/workflows`) | **Standard Operating Procedures.** Scripts that guide the agent through complex tasks (Analysis -> Plan -> Execute). |
| **Skills** (`.agent/skills`) | **Expert Personas.** Context packages that tell the agent *how* to be a Backend Developer, Frontend Expert, or QA Engineer. |

### The Dual Memory Philosophy

This workspace operates on a **Dual Memory** model to bridge the gap between AI reasoning and engineering rigor:

| Memory Type | Location | Purpose |
| :--- | :--- | :--- |
| **Session Memory** | `~/.gemini/antigravity/brain/` | **Negotiation & Context.** Temporary artifacts (`prd.md`, `task.md`) where the agent thinks, plans, and negotiates with you. **Check these first.** |
| **Project Memory** | `docs/...` | **Truth & Archival.** Permanent documentation (`docs/design/`, `docs/api/`) updated only *after* the plan is approved and executed. |

> See [System Topology](docs/ANTIGRAVITY_SYSTEM_TOPOLOGY.md) for a detailed map of the Antigravity filesystem and resource hierarchy.

---

## 🛠️ Usage

### 1. Ideation (SoTA)
Turn a vague idea into a researched, visualized PRD:
> **/ideate** "I want a habit tracker app."
*(Performs Market Research, Generates Vibe Images, Drafts PRD)*

### 2. New Feature Implementation
To build a new backend feature:
> **/implement** (Ensure you have an `Input Manifest` prepared)

The agent will ask for your **Input Manifest** (requirements files) and proceed through the strict 4-phase workflow.

To build a new frontend feature:
> **/front-design** "Create a user profile page."
> _(Then, once designed)_
> **/front-build**

### 3. Bug Fixes & Small Tasks
For focused tasks that don't need a full design doc:
> **/task** "Fix the typo in the login error message."

### 4. Debugging (SoTA)
To investigate a complex issue with Deep Tracing:
> **/diagnose** "The API is returning 500 on the payment endpoint."
*(Generates Failure Sequence Diagram & Traceability Matrix)*

### 5. Reverse Engineering (SoTA)
To generate living documentation from existing code:
> **/reverse-engineer**
*(Generates Topology Map, Living PRD/Design Docs with Code Permalinks)*

---

## 🤖 How It Works (Adherence)

**How does the agent know to follow these rules?**

Antigravity natively scans the `.agent` directory.
1.  **Discovery**: When you type `/implement`, the agent reads `.agent/workflows/implement.md`.
2.  **Visual Logic**: The agent parses the embedded **Mermaid Flowchart** to understand execution flow and gates.
3.  **Instruction**: This file acts as a **System Prompt injection**. It tells the agent:
    *   "You are an Orchestrator."
    *   "You must not write code yourself."
    *   "You must delegate to the `task-executor` skill."
4.  **Constraint**: The workflow explicitly forbids "shortcuts" (like skipping tests) and forces the agent to stop for user approval at key milestones.

**To enforce strict adherence:**
- **Always use the Slash Commands.** Do not ask "Can you write code for X?" loosely. Using the command locks the agent into the defined process.
- **Review the Plan.** The workflow forces the agent to write a plan. If the plan looks wrong, reject it.

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.