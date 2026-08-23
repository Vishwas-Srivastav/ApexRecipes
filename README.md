# Apex Recipes

A curated, enterprise-grade collection of **Apex code patterns, architecture frameworks, and best practices** for Salesforce developers.
This repository demonstrates bulkified, production-grade Apex implementations targeting API version `60.0`, complete with 4-tier engineering guardrails, strict code quality rules, and 90%+ unit test coverage.

---

## Overview

Apex Recipes demonstrates:

* Clean, maintainable, and bulkified coding standards
* Enterprise Architecture Patterns (Separation of Concerns: Domain, Selector, Service, Unit of Work)
* Asynchronous execution engine (Queueables with Finalizers, Stateful Batches, Schedulables, `@future` callouts)
* REST integration clients, custom `@RestResource` endpoints, and Apex Continuation controllers
* Dynamic Apex, Schema Describes, and FLS enforcement via `WITH USER_MODE` and `Security.stripInaccessible`
* Platform Events, Custom Notifications, Exception Logging, Crypto, CSV parsing, and Inbound Email handlers

---

## Apex Recipes Catalog (30 Production Recipes)

All recipes are located under [`force-app/main/default/classes/`](force-app/main/default/classes/).

| Category | Recipe Class | Description |
| :--- | :--- | :--- |
| **Category A: Trigger Frameworks** | [`TriggerHandlerFramework`](force-app/main/default/classes/TriggerHandlerFramework.cls) | Reusable interface-driven trigger handler framework |
| **Category A: Trigger Frameworks** | [`TriggerRecursionControl`](force-app/main/default/classes/TriggerRecursionControl.cls) | Static transaction set counter preventing infinite trigger loops |
| **Category A: Trigger Frameworks** | [`TriggerBypassUtility`](force-app/main/default/classes/TriggerBypassUtility.cls) | User and profile-based trigger bypass manager |
| **Category B: Async Apex** | [`QueueableChainJob`](force-app/main/default/classes/QueueableChainJob.cls) | Queueable Apex with job chaining and Finalizer transaction tracking |
| **Category B: Async Apex** | [`BatchStatefulProcessor`](force-app/main/default/classes/BatchStatefulProcessor.cls) | Stateful batch Apex tracking success and failure record metrics |
| **Category B: Async Apex** | [`ScheduledMaintenanceJob`](force-app/main/default/classes/ScheduledMaintenanceJob.cls) | Cron-driven scheduled Apex job with programmatic scheduling helpers |
| **Category B: Async Apex** | [`FutureCalloutUtility`](force-app/main/default/classes/FutureCalloutUtility.cls) | `@future(callout=true)` method with error logging wrappers |
| **Category C: Enterprise Architecture** | [`AccountDomainHandler`](force-app/main/default/classes/AccountDomainHandler.cls) | Domain layer pattern encapsulating object validation rules |
| **Category C: Enterprise Architecture** | [`ContactSelector`](force-app/main/default/classes/ContactSelector.cls) | Selector layer pattern managing SOQL query construction and FLS |
| **Category C: Enterprise Architecture** | [`OpportunityService`](force-app/main/default/classes/OpportunityService.cls) | Service layer pattern orchestrating business logic transactions |
| **Category C: Enterprise Architecture** | [`UnitOfWorkManager`](force-app/main/default/classes/UnitOfWorkManager.cls) | Unit of Work pattern managing atomic DML operations |
| **Category D: REST Integrations** | [`RestCalloutClient`](force-app/main/default/classes/RestCalloutClient.cls) | HTTP REST client supporting GET, POST, PUT, DELETE with JSON serialization |
| **Category D: REST Integrations** | [`RestCalloutMockFactory`](force-app/main/default/classes/RestCalloutMockFactory.cls) | Reusable `HttpCalloutMock` implementation for unit test suites |
| **Category D: REST Integrations** | [`RestCustomEndpoint`](force-app/main/default/classes/RestCustomEndpoint.cls) | Custom REST Web Service API endpoint (`@RestResource`) |
| **Category D: REST Integrations** | [`ContinuationCalloutController`](force-app/main/default/classes/ContinuationCalloutController.cls) | Apex Continuation for long-running non-blocking HTTP callouts |
| **Category E: Custom Metadata** | [`CustomMetadataAccessor`](force-app/main/default/classes/CustomMetadataAccessor.cls) | Dynamic Custom Metadata Type (CMDT) cached accessor utility |
| **Category E: Custom Metadata** | [`HierarchyCustomSettingsWrapper`](force-app/main/default/classes/HierarchyCustomSettingsWrapper.cls) | Org and profile hierarchy custom settings resolver |
| **Category F: Platform Events** | [`PlatformEventPublisher`](force-app/main/default/classes/PlatformEventPublisher.cls) | `EventBus.publish` utility with `Database.SaveResult` error handling |
| **Category F: Platform Events** | [`PlatformEventSubscriberTrigger`](force-app/main/default/classes/PlatformEventSubscriberTrigger.cls) | Trigger subscriber processing incoming platform event payloads |
| **Category F: Platform Events** | [`CustomNotificationSender`](force-app/main/default/classes/CustomNotificationSender.cls) | `Messaging.CustomNotification` builder for desktop & mobile alerts |
| **Category G: Dynamic Apex** | [`SchemaDescribeUtility`](force-app/main/default/classes/SchemaDescribeUtility.cls) | Dynamic field describe and picklist value extractor |
| **Category G: Dynamic Apex** | [`DynamicQueryBuilder`](force-app/main/default/classes/DynamicQueryBuilder.cls) | Dynamic SOQL query builder with `WITH USER_MODE` and bind variables |
| **Category G: Dynamic Apex** | [`DynamicDmlHandler`](force-app/main/default/classes/DynamicDmlHandler.cls) | Database DML handler enforcing field-level security (`stripInaccessible`) |
| **Category H: Security & Governance** | [`SecurityUserModeEnforcer`](force-app/main/default/classes/SecurityUserModeEnforcer.cls) | Apex user-mode SOQL and DML security checker (`WITH USER_MODE`) |
| **Category H: Security & Governance** | [`ExceptionLoggerService`](force-app/main/default/classes/ExceptionLoggerService.cls) | Exception logging framework capturing stack traces & user context |
| **Category H: Security & Governance** | [`GovernorLimitMonitor`](force-app/main/default/classes/GovernorLimitMonitor.cls) | Real-time transaction limit monitor logging CPU, heap, and SOQL limits |
| **Category H: Security & Governance** | [`CryptoUtility`](force-app/main/default/classes/CryptoUtility.cls) | Encryption/Decryption utility using `Crypto` AES keys & SHA-256 |
| **Category H: Security & Governance** | [`CsvFileParser`](force-app/main/default/classes/CsvFileParser.cls) | Apex CSV file parser converting Blob data into SObject records |
| **Category H: Security & Governance** | [`EmailServiceHandler`](force-app/main/default/classes/EmailServiceHandler.cls) | `Messaging.InboundEmailHandler` processing inbound email attachments |
| **Category H: Security & Governance** | [`BatchDatabaseLocator`](force-app/main/default/classes/BatchDatabaseLocator.cls) | `Database.QueryLocator` batch processing high-volume records |

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

### 4. Run Guardrail Checks & Prettier Verification
```bash
# Verify engineering guardrail suite
./scripts/check-guardrails.sh --all

# Verify code formatting
npm run prettier:verify
```

---

## Development Workflow

- **Default Branch:** `development` (All Pull Requests must target `development`).
- **Production Release Branch:** `main` (Merged PRs in `development` automatically sync to `main`).
- **Branch Naming Standard:** `APEX-<NUMBER>` or `feature/APEX-<NUMBER>` (e.g., `APEX-01`, `feature/APEX-01`).
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
