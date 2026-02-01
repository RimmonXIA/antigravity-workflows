# Antigravity Developer Workflows

[![Constitution](https://img.shields.io/badge/Constitution-Supreme_Law-red)](.agent/WORKFLOW_CONSTITUTION.md)
[![Antigravity Native](https://img.shields.io/badge/Antigravity-Native-purple)](https://antigravity.google)

> ⚠️ **CONSTITUTION**: All work must strictly adhere to the [Workflow Constitution](.agent/WORKFLOW_CONSTITUTION.md). This is the supreme law of this workspace.
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**Production-ready agentic workflows for Google Antigravity.**
This repository transforms your Antigravity agent into a disciplined engineering partner, capable of planning, testing, and implementing code with strict quality controls.

---

## 🚀 Features

### Agent-First Design
Instead of simple autocompletion, this project provides **Autonomous Workflows**:
- **Requirements Analysis**: The agent stops to think and plan before coding.
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

---

## 🛠️ Usage

### 1. New Feature Implementation
To build a new backend feature:
> **/implement** "Add a rate limiting middleware using Redis."

To build a new frontend feature:
> **/front-design** "Create a user profile page."
> _(Then, once designed)_
> **/front-build**

### 2. Bug Fixes & Small Tasks
For focused tasks that don't need a full design doc:
> **/task** "Fix the typo in the login error message."

### 3. Debugging
To investigate a complex issue:
> **/diagnose** "The API is returning 500 on the payment endpoint."

---

## 🤖 How It Works (Adherence)

**How does the agent know to follow these rules?**

Antigravity natively scans the `.agent` directory.
1.  **Discovery**: When you type `/implement`, the agent reads `.agent/workflows/implement.md`.
2.  **Instruction**: This file acts as a **System Prompt injection**. It tells the agent:
    *   "You are an Orchestrator."
    *   "You must not write code yourself."
    *   "You must delegate to the `task-executor` skill."
3.  **Constraint**: The workflow explicitly forbids "shortcuts" (like skipping tests) and forces the agent to stop for user approval at key milestones.

**To enforce strict adherence:**
- **Always use the Slash Commands.** Do not ask "Can you write code for X?" loosely. Using the command locks the agent into the defined process.
- **Review the Plan.** The workflow forces the agent to write a plan. If the plan looks wrong, reject it.

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.