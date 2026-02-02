---
name: mermaid-reader
description: State-of-the-Art expert in parsing, interpreting, and validating Mermaid.js diagrams to extract system logic, topology, and process flows.
---

# Mermaid Reader Skill

## Purpose
This skill analyzes Mermaid.js code blocks to "understand" the visual representation of a system. It reverses the visualization back into semantic understanding of logic, architecture, and flow.

## Capability
Use this skill when:
1.  You encounter a mermaid block in documentation and need to understand the architecture.
2.  You need to validate if a diagram matches the textual description (Validation).
3.  You need to convert a diagram into a written summary or another format.

## Interpretation Strategy

### 1. Structural Analysis (Topology)
*   **Identify Nodes/Participants**: List all unique entities.
*   **Groups/Subgraphs**: Identify boundaries (e.g., "Components in the VPC", "Legacy System").
*   **Hierarchy**: What contains what?

### 2. Relationship Analysis (Connectivity)
*   **Flow**: Follow the arrows. Trace the path from Start to End.
*   **Cardinality/Multiplicity**: For ER/Class diagrams, define the strictness of relationships (1:1, 1:N).
*   **Types**: Distinguish between strong links (composition, sync calls) and weak links (aggregation, async events).

### 3. Logic Extraction (Semantics)
*   **Decisions**: Identify rhombuses `{?}` in flowcharts. Reconstruct the Logic/If-Else blocks.
*   **Lifecycle**: In sequence diagrams, track the chronological order of operations.
*   **State Changes**: In state diagrams, list valid transitions and impossible transitions.

## Validation Checklist (Critique)
When reading, also check for logical consistency:
*   Are there orphan nodes (disconnected)?
*   Are there dead ends in a process flow that shouldn't terminate?
*   Is the syntax erroneously defining duplicate IDs?

## Output Format
When asked to read/explain a diagram, structure the response:
1.  **Summary**: High-level view (e.g., "A user authentication flow involving 3 services").
2.  **Components**: List of key actors/systems.
3.  **Process/Logic**: Step-by-step walkthrough or relationship description.
4.  **Issues Code** (If any): Logical gaps or structural anomalies found.
