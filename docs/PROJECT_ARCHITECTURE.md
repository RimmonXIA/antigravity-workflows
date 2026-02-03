# Project Architecture

This diagram visualizes how the **Claude Code Workflows** project has been adapted to run natively within **Google Antigravity**.

```mermaid
graph TD
    %% Actors
    User([User])
    Agent[Antigravity Agent]
    
    subgraph "Dual Memory System"
        SessionMem[("Session Memory\n(Artifacts)\n~/.gemini/brain/...")]
        ProjectMem[("Project Memory\n(Repo Docs)\ndocs/...")]
    end
    
    FileSystem[Codebase / File System]

    %% Flow
    User --> |"1. Request"| Agent
    
    subgraph "Antigravity Brain"
        Workflows["swish/.agent/workflows/*.md"]
        Skills["swish/.agent/skills/*/SKILL.md"]
    end

    Agent --> |"2. Load Context"| Workflows
    Skills --> |"3. Equip Persona"| Agent

    %% Interaction Loop
    Agent <--> |"4. Negotiate via Artifacts"| SessionMem
    SessionMem <--> |"5. Review & Approve"| User
    
    %% Execution
    Agent --> |"6. Execute"| FileSystem
    Agent --> |"7. Archive Truth"| ProjectMem

    %% Styling
    classDef actor fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef memory fill:#e8f5e9,stroke:#2e7d32,stroke-width:2px,stroke-dasharray: 5 5;
    
    class User,Agent actor;
    class SessionMem,ProjectMem memory;
```

## How it Works

1.  **Trigger**: The user invokes a workflow (e.g., "Run the implement workflow").
2.  **Orchestration**: The agent reads the corresponding markdown file in `.agent/workflows/`.
3.  **Specialization**: The workflow instructs the agent to adopt a specific skill (e.g., `task-executor`).
4.  **Execution**: The agent, now acting as the expert persona, modifies the filesystem to complete the task.
