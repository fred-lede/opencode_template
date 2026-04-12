# 🚀 Opencode Project Template

This is a standardized template for starting new projects using the Opencode workflow. It includes all necessary configurations, documentation structures, and agent instructions to ensure a consistent and efficient development process.

## 🛠️ Quick Start Workflow

To start a new project, follow these steps exactly:

1.  **Clone/Copy the Template**:
    ```bash
    cp -r D:/Ai/opencode_template path/to/your_new_project
    ```
    *(Note: Replace the source path with your actual template location)*

2.  **Enter the Project Directory**:
    ```bash
    cd path/to/your_new_project
    ```

3.  **Initialize Git**:
    ```bash
    git init
    ```

4.  **Launch Opencode**:
    ```bash
    opencode
    ```

## 📂 Project Structure

- **`.opencode/`**: Core agent configurations, including roles (`agents.yaml`) and specialized instructions.
- **`docs/`**: The "Source of Truth". Contains all technical specifications (Requirements, Architecture, API, Database).
- **`specs/`**: Detailed feature breakdowns and granular task lists.
- **`AGENTS.md`**: The fundamental operating principles for AI Agents in this project.
- **`TASK.md`**: The active task tracker (Must be maintained!).
- **`PROGRESS.md`**: The historical log of all development progress.
- **`HANDOFF.md`**: Context for resuming development sessions.

## 🤖 Agent Instructions

The AI Agents in this project are configured to:
1.  **Context-First**: Always read `docs/` before writing code.
2.  **Traceable**: Every change must be reflected in `TASK.md` and `PROGRESS.md`.
3.  **Structured**: Follow the strict rate-limiting and execution rules defined in `AGENTS.md`.

## 📝 Development Standards

- **Documentation**: Always update `docs/` when the architecture or API changes.
- **Commitments**: Use meaningful commit messages.
- **Task Management**: Never leave a `TASK.md` item in `in_progress` without an update.
