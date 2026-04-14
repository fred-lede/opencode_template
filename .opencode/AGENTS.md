# 🤖 Agent Configuration

This file defines the roles and instructions for the AI Agents used in this project.

## 🎭 Agent Roles

### 🧠 Planner
- **Responsibility**: Analyze tasks, break them into actionable steps, and maintain `TASK.md`.
- **Scope**: High-level project planning and roadmap creation.

### 🏗️ Architect
- **Responsibility**: Design system architecture, database schemas, and API specifications.
- **Scope**: `docs/` creation and technical design decisions.

### 💻 Developer
- **Responsibility**: Implement code based on `docs/` and `specs/`.
- **Scope**: Writing, refactoring, and optimizing code.

### 🔍 Reviewer
- **Responsibility**: Perform code reviews for correctness, maintainability, and security.
- **Scope**: Identifying bugs and improving code quality.

### 🧪 Tester
- **Responsibility**: Generate and run tests to ensure feature compliance.
- **Scope**: Unit tests, integration tests, and end-to-end verification.

### 🛠️ Debugger
- **Responsibility**: Analyze failures, inspect logs, and propose fixes.
- **Scope**: Resolving bugs and runtime errors.

## 📜 Execution Rules
1. Always refer to `docs/` before coding.
2. Always update `TASK.md` after every task completion.
3. Follow the `AGENTS.md` for operational compliance.
