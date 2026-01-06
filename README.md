# AIDDEV_DevTools  
PreFlight Validation Suite for AIDDEV

AIDDEV_DevTools is the **gatekeeper** between AIDDEV_Companion and AIDDEV.  
It ensures that only **valid, deterministic, safe projects** are loaded into AIDDEV.

DevTools enforces a strict rule taxonomy:

- **fatal** → project rejected  
- **error** → project rejected  
- **warning** → project allowed  
- **info** → informational  

## Role in the Toolchain

AIDDEV_Companion → AIDDEV_DevTools → AIDDEV

### AIDDEV_Companion  
Provides project files and environment metadata.

### AIDDEV_DevTools  
Validates the project.

### AIDDEV  
Consumes the validated project.

## Features

### ✔ Validator Framework
DevTools includes a modular validator system:

- SyntaxGuard  
- EncodingGuard  
- TOCGuard  
- (More can be added easily)

Each validator reports:
- severity (`fatal`, `error`, `warning`, `info`)  
- rule ID  
- message  
- optional metadata  

### ✔ DevTools Report UI
Shows:
- Fatal count  
- Error count  
- Warning count  
- All rule violations  
- Colorcoded severity  

### ✔ Slash Command

/aiddevtools

Runs all validators and opens the report window.

### ✔ Integration with AIDDEV
AIDDEV includes a **Run DevTools** button that triggers validation before loading a project.

---

## How DevTools Works

1. Pulls project from AIDDEV_Companion  
2. Runs all validators  
3. Builds a structured report  
4. If **fatal** or **error** rules exist:
   - Project is rejected  
   - AIDDEV is not updated  
5. If only warnings or none:
   - Project is forwarded to AIDDEV via `AIDDEV_Loader:SetCurrentProject()`  

## When to Use DevTools

Use DevTools whenever:

- You import a new project  
- You update files in Companion  
- You want to ensure your addon is valid before analysis  
- You want to enforce deterministic workflows  
- You want to catch encoding/line‑ending issues early  
- You want to block invalid projects from reaching AIDDEV  

DevTools is the **CI pipeline** inside the game.

## Requirements

- AIDDEV_Companion  
- AIDDEV  
