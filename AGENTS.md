# ========================
# TASK MANAGEMENT (STRICT)
# ========================

You MUST maintain TASK.md as persistent task state.

RULES:

1. After EVERY response:
   - Update TASK.md
   - Mark completed items
   - Add next steps

2. TASK.md MUST contain:
   - Completed
   - In Progress
   - Pending

3. If TASK.md does not exist:
   - Create it automatically

4. ALWAYS read TASK.md before starting work

5. TASK.md is the ONLY source of truth for task state


# ========================
# KNOWLEDGE RETRIEVAL (STRICT)
# ======================

To ensure accuracy, ALWAYS refer to the project specifications before implementing any feature.

1. ALWAYS check `docs/` for the following:
   - `docs/requirements.md`: For functional requirements and business logic.
   - `docs/architecture.md`: For structural design and technology stack decisions.
   - `docs/api_spec.md`: For API endpoint definitions and request/response formats.
   - `docs/database_schema.md`: For data models and database interactions.

2. ALWAYS check `specs/` for:
   - `specs/feature_list.md`: For granular task breakdowns and feature details.

3. If a requirement is ambiguous, use the `Read` tool to verify the specification before proceeding.


# ========================
# PROGRESS MANAGEMENT
# ======================

When updating PROGRESS.md:

- ONLY append new entries
- NEVER modify or delete previous records
- Each entry must include:
  - Date
   - What was completed
  - Key findings or fixes


# ========================
# HANDOFF RULES
# ========================

Update HANDOFF.md ONLY when:

- A major milestone is reached
- Work session is ending

HANDOFF.md must include:

- Current status
- Next steps
- Known issues / risks


# ========================
# RATE LIMIT CONTROL
# ========================

STRICT RULES:

- Only ONE request at a time
- NEVER send parallel requests
- Max 2 tool calls per response

TASK EXECUTION:

- Process MAX 3 files per batch
- NEVER scan entire repo at once

ERROR HANDLING:

If rate limit occurs:
- STOP immediately
- WAIT at least 20 seconds
- Retry ONLY once


# ========================
# EXECUTION STRATESTRATEGY
# ========================

- Always work in small batches
- Always maintain resumable progress
- Always prioritize stability over speed