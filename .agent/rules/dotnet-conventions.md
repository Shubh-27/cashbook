---
trigger: model_decision
description: When Working on backend
---

# backend — Project Conventions

## Solution Structure

```text
backend          → Web API: Controllers, Middleware, Validators, Helper, DI Extensions
backend.service  → Business Logic: Repository/Interface, Repository/Implementation, Repositories/Interfaces, Repositories/Implementations, UnitOfWork
backend.model    → Data & Domain: Data/AppDbContext, Models (Entities), RequestModel/ResponseModel, Migrations
backend.common   → Shared Utilities: Extensions, Models, helper classes (no upstream deps), Constants, Exceptions
```

---

# What Lives Where

| Concern                    | Project         | Folder                     |
| -------------------------- | --------------- | -------------------------- |
| HTTP pipeline              | backend         | Middleware/                |
| DI registration            | backend         | Extensions/                |
| Controllers                | backend         | Controllers/               |
| Validators                 | backend         | Validators/                |
| Helper                     | backend         | Helper/                    |
| Service interfaces         | backend.service | Services/Interfaces/       |
| Service implementations    | backend.service | Services/Implementations/  |
| Repository interfaces      | backend.service | Repository/Interface/      |
| Repository implementations | backend.service | Repository/Implementation/ |
| UnitOfWork                 | backend.service | UnitOfWork/                |
| DB entities                | backend.model   | TenantDB/                  |
| DbContext                  | backend.model   | TenantDB/                  |
| EF migrations              | backend.model   | Migrations/                |
| Request models             | backend.model   | RequestModel/              |
| Response models            | backend.model   | ResponseModel/             |
| Query extensions           | backend.model   | Extensions/                |
| Shared helpers/utilities   | backend.common  | root & subfolders          |
| Constants                  | backend.common  | root                       |
| Exceptions                 | backend.common  | root                       |

---

# Model File Conventions (`backend.model`)

## Per Controller Model Files

Every controller should have corresponding request and response model files in:

```text
RequestModel/{ControllerName}RequestModel.cs
ResponseModel/{ControllerName}ResponseModel.cs
```

---

## Empty Model File Rule

Empty model files are allowed and should be preserved.

Example:

```csharp
// HealthRequestModel.cs
namespace backend.model.RequestModel
{
    // Reserved for future Health request models
}
```

Do not delete empty controller model files.

---

## Multiple Classes per File

Allowed:

```text
AuthRequestModel.cs
 ├── LoginRequest
 ├── RegisterRequest
 └── ForgotPasswordRequest
```

Never create one file per DTO unless specifically needed.

---

# Shared Model Rule

Apply in this order:

## 1. Used globally/commonly

Place in:

```text
backend.common/Models/
```

Namespace:

```csharp
backend.common.Models
```

---

## 2. Used by some controllers

Keep inside the controller/model folder it most logically belongs to.

Other controllers reference via `using`.

---

## 3. Used by one controller only

Keep only inside that controller’s request/response model file.

---

## Never Duplicate Models

A model class must only exist once in the solution.

Reuse via `using`.

Never copy-paste model definitions across files.

---

# Naming Conventions

## C# Property Naming

Always:

```text
PascalCase
```

Example:

```csharp
FirstName
AccountId
CreatedAt
```

---

## JSON Naming

Always:

```text
snake_case
```

Example:

```json
first_name
account_id
created_at
```

---

## SQL Alias Naming

Always:

```sql
SELECT
    first_name AS first_name,
    account_id AS account_id
```

Always `snake_case`.

---

# Attribute Preservation

Always preserve exactly:

- `[JsonProperty(...)]`
- `[JsonPropertyName(...)]`
- `[Required]`
- `[MaxLength]`
- `[EmailAddress]`
- XML comments
- validation attributes

Never remove existing attributes unless explicitly refactoring them.

---

# Controller Rules

Controllers must remain thin.

Controllers should only:

- receive HTTP request
- call service/repository/UnitOfWork
- return HTTP response

Controllers must NOT contain:

- business logic
- DbContext usage
- entity framework queries directly
- large LINQ transformations
- domain calculations
- mapping duplicated across endpoints

---

# Repository / Service Rules

Repository implementations handle:

- EF Core access
- SQL queries
- CRUD operations
- persistence only

Repositories should avoid:

- business workflows
- HTTP concerns

---

## Query Rules

Filtering must happen before paging.

Correct:

```csharp
query.Where(x => x.UserId == userId)
     .Skip(...)
     .Take(...)
```

Never page full dataset before filtering.

---

## Avoid Full Table Loading

Avoid:

```csharp
GetAllAsync()
ToList()
Count()
Sum()
```

Prefer DB-level aggregation:

```csharp
CountAsync()
SumAsync()
AnyAsync()
FirstOrDefaultAsync()
```

---

# Mapping Rules

If mapping appears more than once:

Extract it.

Examples:

```text
Transaction → TransactionResponseModel
Account → AccountResponseModel
```

Move to extension or helper methods. Avoid duplicated inline controller mapping.

---

# Validator Rules (`Validators/`)

- one validator per request model
- validator name = `{RequestModel}Validator`
- inherit `AbstractValidator<T>`

Validators contain FluentValidation rules only. No business logic.

---

# Dependency Injection Rules

Remove unused constructor dependencies.

If injected dependency is unused: remove it.

Avoid duplicate registrations.

Use appropriate lifetimes:

- Singleton → stateless shared services
- Scoped → request lifecycle services
- Transient → lightweight temporary services

---

# Security Rules

Never use:

```csharp
new Random()
```

for:

- OTP
- verification codes
- token generation
- secret generation

Use:

```csharp
RandomNumberGenerator.GetInt32(...)
```

---

# Common File Ownership

These files live only in `backend.common`

- PasswordHasherHelper.cs
- StringCipher.cs
- HttpStatusCodeException.cs

Never duplicate elsewhere.

---

# General Rules

- no inline request/response models inside controllers
- folder names always plural (except RequestModel/ResponseModel which follow project conventions)
- no duplicated helpers
- no duplicated constants
- no duplicated mapping code
- preserve API contracts during refactor
- preserve business behaviour during cleanup
