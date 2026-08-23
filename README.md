# Apex Recipes

A curated collection of **Apex code patterns, examples, and best practices** for Salesforce developers.
This repository is designed to help you quickly reference **common scenarios, reusable approaches, and innovative ideas** while working with the Salesforce platform.

---

## Overview

Apex Recipes demonstrates:

* Clean and maintainable coding standards
* Bulkified and scalable logic for production use
* Practical patterns for **SOQL, Triggers, Async Apex, Error Handling, and Testing**
* Reusable utility methods to accelerate development

---

## Categories

### 1. SOQL & DML Recipes

* Queries (basic, relationship, aggregate)
* Efficient DML operations

### 2. Trigger Recipes

* Before vs After triggers
* Trigger Handler Pattern
* Recursion prevention

### 3. Async Apex Recipes

* Future methods
* Queueable Apex
* Batch Apex
* Scheduled Apex

### 4. Error Handling

* Custom exceptions
* Graceful error messages
* Logging strategies

### 5. Utility & Helpers

* Date and String utilities
* JSON handling
* Reusable query builders

### 6. Testing Recipes

* Test data factories
* Mocking callouts
* Assert best practices

---

## Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/Vishwas-Srivastav/ApexRecipes.git
```

### 2. Local Configuration
```bash
cp .env.example .env
```

### 3. Initialize Engineering Guardrails
```bash
./scripts/setup-guardrails.sh
```

### 4. Run Guardrail Checks
```bash
./scripts/check-guardrails.sh --all
```

---

## Development Workflow

- **Default Branch:** `development` (All Pull Requests must target `development`).
- **Production Sync:** Merging into `development` automatically syncs changes to `main`.
- **Branch Naming:** `<PROJECT_INITIALS>-<NUMBER>` (e.g., `AR-01`, `AR-02`).
- **Commit Format:** [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `docs:`, `chore:`).

---

## Documentation & Standards

- **Contributor Guide:** [CONTRIBUTING.md](CONTRIBUTING.md)
- **Engineering Guardrails:** [docs/GUARDRAILS.md](docs/GUARDRAILS.md)
- **UI & Icon Standards:** [docs/UI_GUIDELINES.md](docs/UI_GUIDELINES.md)
- **Security Policy:** [SECURITY.md](SECURITY.md)
- **Template Reference:** [docs/TEMPLATE_GUIDE.md](docs/TEMPLATE_GUIDE.md)

---

## Author

Created and maintained by **Vishwas Srivastav**
