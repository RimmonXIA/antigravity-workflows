---
description: Systematically audit codebase for Cognitive Debt and Mental Model Alignment (Fractal Consistency).
---

# Cognitive Integrity Protocol (CIP)

This workflow institutionalizes the "Meta-Audit" process to ensure the codebase remains a faithful projection of the Domain Truth.

## Phase 1: Establish the "Source of Truth"
1. **Identify Domain Documents**: Locate the core domain logic files, requirements docs, or "Bible" of the project (e.g., PRDs, RFCs, Algorithm Specs).
2. **Extract Axioms**: Read these files and extract the "Immutable Truths" and "Business Invariants" (e.g., "Order total must equal sum of items", "State A cannot transition to State C").
3. **Formulate Mental Model**: Synthesize a concise summary of how the system *should* work according to the domain expert.

## Phase 2: Ingest "Implementation Reality"
1. **Scan Architecture**: Read high-level design docs (System Architecture, Context Maps) to understand the intended boundaries.
2. **Inspect Core Logical Units**: 
   - **Monolith/Layered**: `view_file` on core Business Logic Classes/Functions.
   - **Hexagonal/Clean**: Inspect "Port" definitions and "Domain Entity" purity.
   - **Microservices**: Check API Contracts (Protobuf/OpenAPI) and Event Schemas.
3. **Check Naming, Boundaries & Data Structures**:
   - Do Component/Service boundaries map to Domain Contexts (Bounded Contexts)?
   - Do variable types (Float vs Enum vs Object) correctly represent the Domain Concepts?
   - Are there "Simplified" names that create ambiguity or conflate distinct concepts?

## Phase 3: The Interrogation (Cognitive Diff)
Compare **Phase 1** vs **Phase 2**. Ask:
1. **Terminology Drift**: Are we using "Legacy Terms" or "Tech Slang" instead of "Domain Terms"?
2. **Scope Drift**: Does the Code logic (e.g., Local vs Global scope) match the Domain logic?
3. **Precision Drift**: Does the Implementation fidelity match the Domain's precision requirements?

## Phase 4: Rectification & Reporting
1. **Report Findings**: Create a `cognitive_audit_report.md` artifact listing any "Cognitive Debt".
2. **Plan Refactoring**: If debt is found, propose specific renames, type changes, or logic updates.
3. **Verify**: Ensure Verification Tests (Golden Sets / Acceptance Tests) expect the *Correct* behavior defined in Phase 1, removing any "Legacy Expectations".

## Trigger Conditions
Run this workflow when:
- Interpreting a new complex Domain Requirement.
- Users/Stakeholders report "Confusion" about model outputs.
- Refactoring core data structures or algorithms.
- Onboarding new agents or developers to ensure alignment.
