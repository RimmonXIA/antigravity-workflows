---
name: diagnose
description: Investigate problem, verify findings, and derive solutions
---

> ⚠️ **CONSTITUTION**: You must strictly follow the [Workflow Constitution](../WORKFLOW_CONSTITUTION.md). This is the supreme law. Violation is not permitted.

**Command Context**: Diagnosis flow to identify root cause and present solutions

Target problem: $ARGUMENTS

## Orchestrator Definition

**Core Identity**: "I am not a worker. I am an orchestrator."

**Execution Method**:
- Investigation → performed by investigator
- Verification → performed by verifier
- Solution derivation → performed by solver

Orchestrator invokes sub-agents and passes structured JSON between them.

**TodoWrite Registration**: Register execution steps in TodoWrite and proceed systematically

## Step 0: Problem Structuring (Before investigator invocation)

### 0.1 Problem Type Determination

| Type | Criteria |
|------|----------|
| Change Failure | Indicates some change occurred before the problem appeared |
| New Discovery | No relation to changes is indicated |

If uncertain, ask the user whether any changes were made right before the problem occurred.

### 0.2 Information Supplementation for Change Failures

If the following are unclear, **ask with AskUserQuestion** before proceeding:
- What was changed (cause change)
- What broke (affected area)
- Relationship between both (shared components, etc.)

### 0.3 Problem Essence Understanding

**Invoke rule-advisor via Task tool**:
```
subagent_type: rule-advisor
prompt: Identify the essence and required rules for this problem: [Problem reported by user]
```

Confirm from rule-advisor output:
- `taskAnalysis.mainFocus`: Primary focus of the problem
- `mandatoryChecks.taskEssence`: Root problem beyond surface symptoms
- `selectedRules`: Applicable rule sections
- `warningPatterns`: Patterns to avoid

### 0.4 Reflecting in investigator Prompt

**Include the following in investigator prompt**:
1. Problem essence (taskEssence)
2. Key applicable rules summary (from selectedRules)
3. Investigation focus (investigationFocus): Convert warningPatterns to "points prone to confusion or oversight in this investigation"
4. **For change failures, additionally include**:
   - Detailed analysis of the change content
   - Commonalities between cause change and affected area
   - Determination of whether the change is a "correct fix" or "new bug" with comparison baseline selection

### Step 0.5: Scope Topology Mapping (New SoTA Step)

**Goal**: Identify the "Blast Radius" and hidden dependencies before investigating.

**Task tool invocation**:
```
subagent_type: scope-discoverer
prompt: |
  Map the topology surrounding the reported error.
  target_path: $SUSPECTED_MODULE
  visualize: true
```
**Store output as**: `$TOPOLOGY_MAP`

## Workflow Logic
```mermaid
flowchart TD
    Start([User Report]) --> Topology[Scope Topology Map]
    Topology --> Investigate[Deep Investigation]
    Investigate --> Verify{Hypothesis Verification}
    
    Verify -- "Low Confidence" --> Loop[Refine Hypothesis]
    Loop --> Investigate
    
    Verify -- "High Confidence" --> Solution[Solution Derivation]
    Solution --> Report([Final Report])
    
    %% Gates
    Investigate -.->|Critical Risk| AskUser[User Intervention]
```

## Step 1: Deep Investigation
**Agent**: `investigator`
**Directives**:
1.  **Map Topology**: Use `scope-discoverer` to find blast radius.
2.  **Deep Trace**: Use `investigator` with `mode: deep_tracing`.
3.  **Output**: Evidence Matrix + Failure Sequence Diagram (Mermaid).

### Step 2: Investigation Quality Check & Design Gap Escalation

Review investigation output:

**Quality Check** (verify JSON output contains the following):
- [ ] comparisonAnalysis
- [ ] causalChain for each hypothesis (reaching stop condition)
- [ ] causeCategory for each hypothesis
- [ ] Investigation covering investigationFocus items (when provided)
- [ ] failureSequenceDiagram

**If quality insufficient**: Re-run investigator specifying missing items

**design_gap Escalation**:

When investigator output contains `causeCategory: design_gap` or `recurrenceRisk: high`:
1. **Insert user confirmation before verifier execution**
2. Use AskUserQuestion:
   "A design-level issue was detected. How should we proceed?"
   - A: Attempt fix within current design
   - B: Include design reconsideration
3. If user selects B, pass `includeRedesign: true` to solver

Proceed to verifier once quality is satisfied.

### Step 3: Verification (verifier)

**Task tool invocation**:
```
subagent_type: verifier
prompt: |
  Verify the following investigation results using Trace Validation.
  
  Investigation results: [Investigation JSON output]
  mode: trace_validation
```

**Expected output**: Confirmed Hypothesis, Disproved Hypotheses, Trace Validity Score.

**Confidence Criteria**:
- **high**: No uncertainty affecting solution selection or implementation
- **medium**: Uncertainty exists but resolvable with additional investigation
- **low**: Fundamental information gap exists

### Step 4: Solution Derivation (solver)

**Task tool invocation**:
```
subagent_type: solver
prompt: Derive solutions based on the following verified conclusion.

Causes: [verifier's conclusion.causes]
Causes relationship: [causesRelationship: independent/dependent/exclusive]
Confidence: [high/medium/low]
```

**Expected output**: Multiple solutions (at least 3), tradeoff analysis, recommendation and implementation steps, residual risks

**Completion condition**: confidence=high

**When not reached**:
1. Return to Step 1 with uncertainties identified by solver as investigation targets
2. Maximum 2 additional investigation iterations
3. After 2 iterations without reaching high, present user with options:
   - Continue additional investigation
   - Execute solution at current confidence level

### Step 5: SoTA Final Report Creation

**Prerequisite**: confidence=high achieved

After diagnosis completion, report to user in the following format:

```markdown
## 🩺 Deep Diagnosis Report

### 🔴 Root Cause Analysis (RCA)
[Summary of the confirmed root cause]

### 📸 Failure Sequence Diagram
[Mermaid Diagram from investigator]

### 🛠️ Recommended Solution
[Solution derivation recommendation]

### 🔗 Traceability
- **Error Source**: [File](file:///path/to/file#L10)
- **Fix Location**: [File](file:///path/to/file#L20)

### ⚠️ Residual Risks
[solver's residualRisks]
```

## Completion Criteria

- [ ] Executed Toplogy Mapping
- [ ] Executed Deep Investigation with Failure Sequence Diagram
- [ ] Verified Hypothesis via Trace Validation
- [ ] Generated SoTA Final Report with Traceability Links.
