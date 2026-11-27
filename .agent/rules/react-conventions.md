---
trigger: model_decision
description: When Working on frontend
---

# bank-frontend — React Project Conventions

## Tech Stack

- **Core**: React 19, TypeScript
- **Routing**: React Router 7
- **State**: Zustand (global store in `src/store.ts`)
- **Data Fetching & API**: Native `fetch` wrapper in `src/api.ts`
- **Styling**: Tailwind CSS 4 (imported in `src/index.css`)
- **UI Elements**: Radix UI primitives (`@radix-ui/react-dialog`, `@radix-ui/react-popover`), Command (`cmdk`), Lucide React icons
- **Build Tool**: Vite

---

## Folder Structure

```text
src/
├── assets/                        # Static files: images, svgs
├── components/                    # UI Components
│   ├── ui/                        # Low-level atomic components (e.g., custom UI components)
│   └── ...                        # App components (Sidebar, Topbar, Modals, etc.)
├── hooks/                         # Custom hooks
├── lib/                           # Third-party client setups / libraries
├── pages/                         # Route/page folder-based structure
│   ├── accounts/
│   │   └── page.tsx               # Route component for /accounts
│   ├── dashboard/
│   │   └── page.tsx               # Route component for /dashboard
│   ├── descriptions/
│   │   └── page.tsx               # Route component for /descriptions
│   ├── settings/
│   │   └── page.tsx               # Route component for /settings
│   └── transaction/
│       └── page.tsx               # Route component for /transaction
├── api.ts                         # Global API client containing all API request methods
├── store.ts                       # Global Zustand state store (`useAppStore`)
├── types.ts                       # Shared TypeScript interfaces, types, and DTO definitions
├── utils/                         # Pure helper functions, formatting, validation rules
├── index.css                      # Main style sheet with Tailwind directives
├── main.tsx                       # Main entry point
└── App.tsx                        # App component and layout routing structure
```

---

## Naming Conventions

### Files

| Type               | Convention | Example                    |
| ------------------ | ---------- | -------------------------- |
| React components   | PascalCase | `AddTransactionModal.tsx`  |
| Page entries       | lowercase  | `page.tsx`                 |
| Custom Hooks       | camelCase  | `useLocalStorage.ts`       |
| Service/API files  | camelCase  | `api.ts`                   |
| Store files        | camelCase  | `store.ts`                 |
| Type files         | camelCase  | `types.ts`                 |
| Utility files      | camelCase  | `validation.ts`            |

### Symbols (inside files)

| Type                       | Convention | Example                          |
| -------------------------- | ---------- | -------------------------------- |
| React component (function) | PascalCase | `function Sidebar()`             |
| Zustand store              | camelCase  | `useAppStore`                    |
| TypeScript interface       | PascalCase | `VwTransactionList`              |
| TypeScript type alias      | PascalCase | `SearchRequest`                  |
| Utility function           | camelCase  | `formatDate()`                   |
| Variables & properties     | camelCase  | `const isLoaded`                 |
| Backend payload/fields     | snake_case | `const account_name`, `page_size`|

---

## Routing & Pages Convention

Pages must follow the subfolder `page.tsx` layout convention under `src/pages/`.
- Every page is a default export in `page.tsx`.
- Keep pages focused on layout composition and coordinating UI elements.

---

## API & Network Calls Convention

- Do not make inline `fetch` or network requests directly from components or pages.
- Define all API endpoints inside `src/api.ts` under the exported `api` object.
- Components should import `api` from `@/api` (or relative path `./api`) to execute network requests.
- Handle validation exceptions via `ValidationError` class defined in `utils/validation.ts`.

---

## State Management

- Use Zustand's `useAppStore` in `src/store.ts` for managing application-wide state (e.g., loaded accounts, quick-add modal open state).
- Prefer local component state (`useState`) for UI-only variables (such as input field values, loading states specific to a button click, etc.) that do not need to be shared globally.

---

## General Rules

- Keep props fully typed. Leverage the interfaces and types defined in `src/types.ts`.
- When communicating with the backend, match the `snake_case` field names for request/response payloads (e.g. `page_size`, `account_name`).
- Follow the Tailwind CSS 4 style standards.
