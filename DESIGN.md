---
version: "1.0"
tokens:
  colors:
    palette:
      primary:
        50: "#f0fdfa"
        100: "#ccfbf1"
        500: "#14b8a6"
        600: "#0d9488"
        700: "#0f766e"
      slate:
        50: "#f8fafc"
        100: "#f1f5f9"
        200: "#e2e8f0"
        400: "#94a3b8"
        500: "#64748b"
        600: "#475569"
        800: "#1e293b"
        900: "#0f172a"
    semantic:
      light:
        background: "oklch(0.984 0.003 247.858)"
        foreground: "oklch(0.208 0.042 265.755)"
        card: "oklch(1 0 0)"
        card-foreground: "oklch(0.208 0.042 265.755)"
        popover: "oklch(1 0 0)"
        popover-foreground: "oklch(0.208 0.042 265.755)"
        primary: "oklch(0.205 0.006 285.885)"
        primary-foreground: "oklch(0.985 0 0)"
        accent-teal: "oklch(0.511 0.096 186.391)"
        secondary: "oklch(0.97 0.001 286.375)"
        secondary-foreground: "oklch(0.205 0.006 285.885)"
        muted: "oklch(0.97 0.001 286.375)"
        muted-foreground: "oklch(0.446 0.043 257.281)"
        border: "oklch(0.929 0.013 255.508)"
        input: "oklch(0.929 0.013 255.508)"
        ring: "oklch(0.708 0.005 286.286)"
      dark:
        background: "oklch(0.145 0.004 285.823)"
        foreground: "oklch(0.985 0 0)"
        card: "oklch(0.145 0.004 285.823)"
        card-foreground: "oklch(0.985 0 0)"
        popover: "oklch(0.145 0.004 285.823)"
        popover-foreground: "oklch(0.985 0 0)"
        primary: "oklch(0.985 0 0)"
        primary-foreground: "oklch(0.205 0.006 285.885)"
        secondary: "oklch(0.269 0.006 285.885)"
        secondary-foreground: "oklch(0.985 0 0)"
        muted: "oklch(0.269 0.006 285.885)"
        muted-foreground: "oklch(0.708 0.005 286.286)"
        accent: "oklch(0.269 0.006 285.885)"
        accent-foreground: "oklch(0.985 0 0)"
        destructive: "oklch(0.396 0.141 25.723)"
        destructive-foreground: "oklch(0.637 0.237 25.331)"
        border: "oklch(0.269 0.006 285.885)"
        input: "oklch(0.269 0.006 285.885)"
        ring: "oklch(0.439 0.01 286.375)"
  typography:
    font-family:
      sans: "'Inter', ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif"
    font-size:
      micro: "0.625rem" # 10px (Table Headers)
      xs: "0.75rem"
      sm: "0.875rem"
      base: "1rem"
      lg: "1.125rem"
      xl: "1.25rem"
    font-weight:
      medium: "500"
      semibold: "600"
      bold: "700"
  spacing:
    container-padding: "2rem" # p-8
    layout-gap: "2rem"      # gap-8
    grid-gap: "1.25rem"     # gap-5
    sidebar-width: "16rem"  # w-64
  radii:
    base: "0.625rem"
    sm: "0.375rem"
    md: "0.5rem"
    lg: "0.625rem"
    xl: "0.875rem"      # 14px (Sidebar items, buttons)
    "2xl": "1rem"
    "3xl": "1.5rem"
  shadows:
    sm: "0 1px 2px 0 rgb(0 0 0 / 0.05)"
    md: "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)"
  motion:
    duration:
      fast: "200ms"
      normal: "300ms"
    easing: "cubic-bezier(0.4, 0, 0.2, 1)"
---

# Design System: Cashbook

Cashbook is a personal finance management application designed with a focus on **clarity**, **trust**, and **efficiency**. The design system provides a cohesive visual language that balances professional financial tooling with an approachable, modern user interface.

## Design Intent

The primary goal of the Cashbook design system is to reduce the cognitive load of managing complex financial data. This is achieved through:

- **Clarity of Information**: High-contrast typography (Inter) and a generous use of whitespace ensure that transaction details and account balances are the focal point.
- **Visual Hierarchy**: A structured layout with a persistent sidebar separates navigation from content, allowing users to focus on data-intensive tasks without losing context.
- **Trust and Stability**: The use of a deep Slate and vibrant Teal palette evokes feelings of security and growth, essential for a financial application.
- **Modern Polish**: Subtle micro-interactions, such as scale transformations on interaction and soft elevation changes, provide a premium, tactile feel.

## Visual Identity

### Color & Texture
The system relies on a clean, light-filled environment (Light Mode) with a robust, high-contrast Dark Mode alternative. Surfaces use subtle borders (`oklch(0.929 0.013 255.508)`) and light shadows to create depth without clutter. The Teal accent color (`oklch(0.511 0.096 186.391)`) is used for primary branding and active navigational states.

### Form & Geometry
A primary corner radius of `14px` (`0.875rem`) is used for high-interaction components like sidebar items, buttons, and search inputs, creating a consistent "pill-like" or "rounded-rectangular" aesthetic. Larger components like empty state containers use even more aggressive rounding (`1.5rem`) to create a distinct, approachable look.

### Typography
Typography is anchored by the **Inter** typeface. A distinctive feature is the "Micro" typography (`10px`, bold, uppercase, tracking-wide) used for table headers and metadata labels, which maximizes data density while maintaining readability.

### Motion & Feedback
Transitions are snappy and purposeful. Navigational changes use a `300ms` fade-in, while interactive elements like cards use `200ms` transitions for hover states. Active feedback, such as the `active:scale-[0.98]` on cards, provides immediate physical reassurance of a user's action.

## Core Components

- **Sidebar**: A vertical navigation anchor that uses semi-transparent backgrounds and subtle `ring-1 ring-teal-100` highlights for the active route.
- **Cards**: The primary unit of information, featuring a unique accent bar that appears on hover, reinforcing the connection between the user and their data.
- **Dashboard Grid**: A responsive grid system with calibrated spacing (`1.25rem`) that adapts to various screen sizes while maintaining a consistent visual density.
