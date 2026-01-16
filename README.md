# 🛠️ AIDDEV_DevTools
### PreFlight Validation Suite for AIDDEV
=======
# WORK IN PROGRESS!!!

# AIDDEV_DevTools
PreFlight Validation Suite for AIDDEV

[![License: MIT](https://img.shields.io)](https://opensource.org)
[![Status: Gatekeeper](https://img.shields.io)](https://github.com)

**AIDDEV_DevTools** is the essential bridge between [AIDDEV_Companion](https://github.com) and the core [AIDDEV](https://github.com) engine. It functions as an in-game CI pipeline, ensuring only **valid, deterministic, and safe projects** are permitted to load.

---

## 🏗️ Role in the Toolchain

DevTools acts as the central validation authority in the three-tier architecture:

1.  **AIDDEV_Companion:** Provides raw project files and environment metadata.
2.  **AIDDEV_DevTools:** Validates the project against strict safety and logic rules.
3.  **AIDDEV:** Consumes the successfully validated project.

---

## 🚦 Rule Taxonomy

DevTools enforces a strict hierarchy of compliance to prevent corruption or crashes:

| Severity | Action | Description |
| :--- | :--- | :--- |
| 💀 **fatal** | **REJECTED** | Critical failure; system cannot proceed. |
| ❌ **error** | **REJECTED** | Logic or syntax violation that prevents valid analysis. |
| ⚠️ **warning** | **ALLOWED** | Potential issue detected, but project remains usable. |
| ℹ️ **info** | **ALLOWED** | General metadata or informational logs. |

---

## ✨ Features

### 🛡️ Validator Framework
A modular system designed for extensibility. Current guards include:
*   **SyntaxGuard:** Ensures script integrity.
*   **EncodingGuard:** Catches illegal characters and line-ending inconsistencies.
*   **TOCGuard:** Validates manifest and metadata files.
*   *(Modular design allows for easy addition of custom validators.)*

### 📊 DevTools Report UI
An intuitive dashboard providing immediate feedback:
*   Real-time counts for Fatals, Errors, and Warnings.
*   Detailed list of all rule violations with Rule IDs.
*   Color-coded severity indicators for rapid debugging.

### ⌨️ Slash Command
Run all validators and invoke the UI instantly with:
```bash
/aiddevtools
```

---

## ⚙️ How It Works

1.  **Ingestion:** Pulls project data from `AIDDEV_Companion`.
2.  **Analysis:** Executes the modular validator suite.
3.  **Reporting:** Compiles a structured validation report.
4.  **Enforcement:**
    *   If **fatal** or **error** flags exist: The project is rejected and `AIDDEV` is not updated.
    *   If clean (or warnings only): Project is forwarded to the main engine via `AIDDEV_Loader:SetCurrentProject()`.

---

## 🚀 When to Use DevTools

Deploy DevTools whenever you need to:
*   Import a new project or update files in the Companion.
*   Ensure your addon is valid before complex analysis.
*   Enforce **deterministic workflows** across your development team.
*   Catch encoding issues before they reach the production environment.
*   **Block invalid code** from ever reaching the AIDDEV core.

---

## 📋 Requirements

*   [AIDDEV_Companion](https://github.com)
*   [AIDDEV](https://github.com)

---
*DevTools: The CI pipeline inside the game.*
