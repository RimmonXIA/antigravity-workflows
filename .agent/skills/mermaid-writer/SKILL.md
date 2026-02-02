---
name: mermaid-writer
description: State-of-the-Art expert in generating Mermaid.js diagrams for flowcharts, sequence diagrams, class diagrams, state diagrams, ER diagrams, and Gantt charts.
---

# Mermaid Writer Skill

## Purpose
This skill transforms textual descriptions, code structures, or system logic into strict, syntactically correct, and visually optimized Mermaid.js diagrams.

## Interface
**Input**: 
- `Type`: The desired diagram type (flowchart, sequence, class, state, er, gantt, gitgraph, mindmap).
- `Context`: The logic, code, or process to visualize.
- `Style`: (Optional) 'Simple', 'Detailed', or 'Technical'.

**Output**:
- A single markdown code block containing the mermaid code.

## Critical Rules (Syntax Safety)
1.  **Node IDs**: ALWAYS use alphanumeric IDs (no spaces/symbols) and put labels in quotes/brackets.
    *   Correct: `A["User Login"]`
    *   Incorrect: `User Login[User Login]` or `A[User Login]` (risk of syntax error with parens)
2.  **Special Characters**: Escape quotes in labels. Avoid complex logical symbols inside labels unless quoted.
3.  **Direction**: Default to `TD` (Top-Down) for processes, `LR` (Left-Right) for timelines or data flows.
4.  **Subgraphs**: Use subgraphs to group related components (e.g., `subgraph Backend`).
    *   *Note*: Subgraph IDs must also be simple alphanumeric.
5.  **Styling**: Use simple `classDef` or `style` only when requested. Do NOT over-complicate unless necessary.

## Diagram Specifics

### Flowcharts (`graph` / `flowchart`)
- Use `flowchart TD` or `flowchart LR`.
- Shapes:
    - Process: `["Label"]`
    - Decision: `{"Label"}`
    - Database/Storage: `[("Label")]`
    - Subroutine: `[["Label"]]`
- **Edges**: `-->` for flow, `-.->` for dependency/async, `==>` for critical path.
- **Labels on Edges**: `A -->|text| B`

### Sequence Diagrams (`sequenceDiagram`)
- Participants: Define aliases first: `participant A as Alice`.
- Messages:
    - Sync: `A->>B: Message`
    - Async: `A--)B: Message`
    - Return: `B-->>A: Result`
- Activations: Use `activate A` / `deactivate A` or `+`/`-` suffix.
- Notes: `Note right of A: Text`

### Class Diagrams (`classDiagram`)
- Visibility: `+` (public), `-` (private), `#` (protected).
- Relations:
    - Inheritance: `<|--`
    - Composition: `*--`
    - Aggregation: `o--`
    - Association: `-->`

### State Diagrams (`stateDiagram-v2`)
- Start/End: `[*]`
- States: `state "Label with spaces" as S1`
- Composite States: Nestle `state` blocks.

### Entity Relationship (`erDiagram`)
- Cardinality: `||--o{`, `}|..|{`, etc.
- Attributes: `type name` inside entity block.

## Example Output (Flowchart)

```mermaid
flowchart TD
    %% Nodes
    User(["User"])
    API["API Gateway"]
    Auth{"Authenticated?"}
    DB[("User Database")]
    Svc["Service"]

    %% Flow
    User -->|Request| API
    API --> Auth
    Auth -- Yes --> Svc
    Auth -- No -->|401| User
    Svc -.-> DB
```

## Self-Correction Checklist
Before returning code:
1.  Are all parentheses `()` inside labels balanced or escaped?
2.  Are node IDs free of spaces and special chars?
3.  Did I close all brackets `[]`?
4.  Are relationships correct for the diagram type (e.g., don't use `-->` in sequence diagrams)?
