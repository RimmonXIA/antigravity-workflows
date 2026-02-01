# Project Architecture

This diagram visualizes how the **Claude Code Workflows** project has been adapted to run natively within **Google Antigravity**.

```mermaid
graph TD
    %% Actors
    User([User])
    Agent[Antigravity Agent]
    FileSystem[File System]

    %% Flow
    User --> |"Run implement workflow"| Agent
    
    subgraph "Antigravity Brain"
        Workflows["swish/.agent/workflows/*.md"]
        Skills["swish/.agent/skills/*/SKILL.md"]
    end

    Agent --> |"1. Read Workflow"| Workflows
    Workflows --> |"2. Define Process"| Agent
    
    Agent --> |"3. Load Skill (Persona)"| Skills
    Skills --> |"4. Equip Rules & Tools"| Agent

    Agent --> |"5. Execute Actions"| FileSystem

    %% Styling
    classDef actor fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef resource fill:#fff9c4,stroke:#fbc02d,stroke-width:2px;
    
    class User,Agent actor;
    class Workflows,Skills,FileSystem resource;
```

## How it Works

1.  **Trigger**: The user invokes a workflow (e.g., "Run the implement workflow").
2.  **Orchestration**: The agent reads the corresponding markdown file in `.agent/workflows/`.
3.  **Specialization**: The workflow instructs the agent to adopt a specific skill (e.g., `task-executor`).
4.  **Execution**: The agent, now acting as the expert persona, modifies the filesystem to complete the task.
