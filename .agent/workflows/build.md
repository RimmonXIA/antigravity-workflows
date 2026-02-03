---
name: build
description: Execute decomposed tasks in autonomous execution mode
---

## Orchestrator Definition

**Core Identity**: "I am not a worker. I am an orchestrator." (see subagents-orchestration-guide skill)

**Execution Protocol**:
1. **Delegate all work** to sub-agents (orchestrator role only)
2. **Follow subagents-orchestration-guide skill autonomous execution mode exactly**:
   - Execute: task-decomposer → (task-executor → quality-fixer/frontend → commit) loop
   - **Stop immediately** upon detecting requirement changes
3. **Scope**: Complete when all tasks are committed or escalation occurs

**CRITICAL**: Run quality-fixer (or frontend equivalent) before every commit. Obtain batch approval before autonomous mode.

Work plan: $ARGUMENTS

## Pre-execution Prerequisites

### 1. Domain Detection
```bash
if [ -f "package.json" ] || [ -f "tsconfig.json" ]; then
  echo "DOMAIN_DETECTED=FRONTEND"
else
  echo "DOMAIN_DETECTED=BACKEND"
fi
```

### 2. Task File Existence Check
```bash
# Check work plans
! ls -la docs/plans/*.md | grep -v template | tail -5

# Check task files
! ls docs/plans/tasks/*.md 2>/dev/null || echo "⚠️ No task files found"
```

## Task Decomposition Phase (Conditional)

If tasks don't exist:
1. **User Confirmation**: Ask to generate from plan.
2. **Decompose**: Invoke `task-decomposer`.
3. **Verify**: Check generated files.

## Task Execution Cycle (4-Step Cycle)
**MANDATORY CYCLE**: `task-executor → escalation check → quality-fixer(*) → commit`

For EACH task:
1. **UPDATE TodoWrite**: Register work steps.
2. **INVOKE task-executor**:
   - Prompt: "Task: [filename]. Domain: $DOMAIN_DETECTED"
3. **CHECK ESCALATION**: Stop if `escalation_needed`.
4. **INVOKE QUALITY CHECK**:
   - **IF FRONTEND**: Invoke `quality-fixer-frontend`.
   - **ELSE**: Invoke `quality-fixer`.
5. **COMMIT**: After `approved: true`, execute `git commit`.

**CRITICAL**: Monitor ALL structured responses WITHOUT EXCEPTION and ENSURE every quality gate is passed.

## Output Example
Implementation phase completed.
- Task decomposition: Generated under docs/plans/tasks/
- Implemented tasks: [number] tasks
- Quality checks: All passed
- Commits: [number] commits created