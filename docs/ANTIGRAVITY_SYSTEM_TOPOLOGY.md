# Antigravity System Topology

This document maps the **physical and logical structure** of the Google Antigravity environment. It serves as the authoritative reference for resource locations, configuration paths, and internal data structures.

> **Meta-Information**
> - **Scope**: Global vs. Workspace Resource Mapping
> - **Collection Date**: 2026-02-03
> - **Verification**: Active Filesystem Inspection & Web Research

## 1. Resource Hierarchy (Workflows, Skills, Rules)

Antigravity operates on a **Cascading Priority Model**. Resources defined at the *Workspace* level always override *Global* definitions.

| Resource | Scope | Canonical Path | Purpose |
| :--- | :--- | :--- | :--- |
| **Workflows** | **Global** | `~/.gemini/antigravity/global_workflows/` | Universal commands available in any context (e.g., `/implement`). |
| | **Workspace** | `<project>/.agent/workflows/` | Project-specific logic. **(Overrides Global)** |
| **Skills** | **Global** | `~/.gemini/antigravity/global_skills/` | Universal expert personas/functions. |
| | **Workspace** | `<project>/.agent/skills/` | Project-specific personas. **(Overrides Global)** |
| | *Legacy* | `~/.gemini/antigravity/skills/` | Alternate standard found in older docs (Deprioritized). |
| **Rules** | **Global** | `~/.gemini/GEMINI.md` | **The Constitution.** Universal constraints (Safety, Style). |
| | **Workspace** | `<project>/.agent/rules/` | Project-specific constraints. |

## 2. The Cognitive Substrate (`~/.gemini/antigravity/`)

The `~/.gemini/antigravity/` directory functions as the Agent's "Operating System" storage. It maintains state, memory, and cognition logs.

| Directory | Semantic Role | Description |
| :--- | :--- | :--- |
| **`brain/`** | **Working Memory** | Stores active session artifacts. Ephemeral state where the agent "thinks" and plans (`task.md`, `prd.md`). |
| **`knowledge/`** | **Long-Term Memory** | Vector store for persistent knowledge retrieval across sessions. |
| **`conversations/`** | **Episodic Memory** | Protobuf (`.pb`) logs of all historical chat sessions. |
| **`implicit/`** | **Implicit Memory** | Learned user preferences and behavioral adaptations over time. |
| **`code_tracker/`** | **Semantic Index** | Indexing data for rapid codebase navigation and understanding. |
| **`playground/`** | **Sandboxes** | Isolated environments for safe code execution and testing. |
| **`context_state/`** | **State Snapshots** | IDE state persistence (open files, cursors, scroll positions). |

## 3. Configuration Primitives

| File | Location | Criticality | Role |
| :--- | :--- | :--- | :--- |
| **`GEMINI.md`** | `~/.gemini/GEMINI.md` | **Critical** | **System Prompt Injection.** Defines the base personality, ethical boundaries, and operational mode of the agent. |
| **`knowledge.lock`** | `~/.gemini/antigravity/knowledge/` | System | Mutex lock for the vector database. |

## 4. Extension Patterns

### Creating a Global Workflow
To create a universally accessible command:
1.  Create `~/.gemini/antigravity/global_workflows/<command_name>.md`.
2.  Define metadata in YAML frontmatter.
3.  The agent effectively "installs" this command into its global registry.

### Creating a Global Skill
To create a universally accessible persona:
1.  Create `~/.gemini/antigravity/global_skills/<skill_name>/SKILL.md`.
2.  Define the persona and capabilities.
3.  Trigger via natural language: *"Use the <skill_name> skill"*.
