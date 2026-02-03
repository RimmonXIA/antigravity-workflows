# Antigravity Workflow Constitution (Google Antigravity Workflows 宪法)

> **PREAMBLE**: This document is the **Supreme Law** of the Antigravity Workflow. It must be followed by both Human Users and AI Agents without deviation under any circumstances.
>
> **Article I**: The Workflow defined herein is the absolute authority on how software is built within this workspace.
> **Article II**: No shortcuts, bypasses, or "quick fixes" are permitted that violate the integrity of this flow.
> **Article III**: All work begins with an **Input Manifest**—a collection of markdown files describing the User's Requirements and Context.
> **Article IV**: The rigor of the process must be proportional to the complexity of the task (The Proportionality Principle).

## Definitions

- **Input Manifest**: A set of markdown files collected by the User to serve as the immutable source of truth for `requirement-analyzer`. It contains the "User Request" and "Context".

## The Supreme Workflow

```mermaid
graph TD
    %% Nodes
    Start(["Input Manifest"])
    
    subgraph Phase1 ["1. Analysis Phase"]
        RA["requirement-analyzer"]
        PRD["prd-creator"]
        RevPRD["document-reviewer <br/> (PRD Review)"]
    end

    subgraph Phase2 ["2. Architecture Phase"]
        SA["solution-architect <br/> (System Architecture & Tech Stack)"]
        RevSAD["document-reviewer <br/> (SAD Review)"]
    end

    subgraph Phase3 ["3. Design Phase"]
        TD["technical-designer <br/> (Detailed Design & Low-level ADRs)"]
        RevDD["document-reviewer <br/> (Design Doc Review)"]
        Sync["design-sync <br/> (Consistency Check)"]
    end

    subgraph Phase4 ["4. Planning Phase"]
        ATG["acceptance-test-generator <br/> (Test Skeletons)"]
        WP["work-planner <br/> (Implementation Plan)"]
    end

    subgraph Phase5 ["5. Execution Loop"]
        Decomp["task-decomposer"]
        Exec["task-executor <br/> (Implementation)"]
        QF["quality-fixer <br/> (QA & Fixes)"]
        Commit["Git Commit"]
        Cycle{"Next Task?"}
    end

    %% Flow
    Start --> RA
    
    %% BRANCHING LOGIC (Proportionality)
    RA --> Route{Complexity?}
    
    %% Path A: Turbo Mode
    Route -- "Small" --> Quick[Task Executor <br/> (Turbo Mode)]
    Quick --> QF
    
    %% Path B: Standard Mode
    Route -- "Large" --> PRD
    PRD --> RevPRD
    
    %% Critical Gate (Standard)
    RevPRD -->|Approved| SA
    SA --> RevSAD
    
    RevSAD -->|Approved| TD
    TD --> RevDD
    RevDD --> Sync
    
    Sync -->|Synced| ATG
    ATG --> WP
    WP -->|Batch Approval| Decomp
    
    Decomp --> Exec
    Exec --> QF
    QF -->|Approved| Commit
    Commit --> Cycle
    
    Cycle -->|Yes| Exec
    Cycle -->|No| Done(["Completion Report"])

    %% Styling
    style Start fill:#f9f,stroke:#333,stroke-width:2px
    style RevPRD fill:#ff9,stroke:#f66,stroke-width:2px,stroke-dasharray: 5 5
    style RevSAD fill:#ff9,stroke:#f66,stroke-width:2px,stroke-dasharray: 5 5
    style RevDD fill:#ff9,stroke:#f66,stroke-width:2px,stroke-dasharray: 5 5
    style Sync fill:#ff9,stroke:#f66,stroke-width:2px,stroke-dasharray: 5 5
    style WP fill:#ff9,stroke:#f66,stroke-width:2px,stroke-dasharray: 5 5
    style QF fill:#ff9,stroke:#f66,stroke-width:2px,stroke-dasharray: 5 5
    style Phase5 fill:#e1f5fe,stroke:#0277bd,stroke-width:2px
```

## Compliance Mandates

1.  **Architecture First**: detailed design (`technical-designer`) MUST NOT begin until System Architecture (`solution-architect`) is approved.
2.  **Verification Loop**: implementation (`task-executor`) MUST NOT commit without `quality-fixer` approval.
3.  **Strict Handoffs**: inputs and outputs between agents must follow the defined JSON/Markdown contracts.
