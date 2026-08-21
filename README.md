# CashBook (Bank Manager)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![.NET](https://img.shields.io/badge/.NET-10.0-purple.svg)](https://dotnet.microsoft.com/)
[![React](https://img.shields.io/badge/React-19.0-61dafb.svg)](https://react.dev/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.7-blue.svg)](https://www.typescriptlang.org/)
[![Tailwind CSS](https://img.shields.io/badge/Tailwind_CSS-v4.0-38bdf8.svg)](https://tailwindcss.com/)
[![Electron](https://img.shields.io/badge/Electron-33.2-47848F.svg)](https://www.electronjs.org/)
[![SQLite](https://img.shields.io/badge/SQLite-3.0-003B57.svg)](https://www.sqlite.org/)

A modern, high-performance cross-platform desktop application for personal and small business financial management. CashBook is built with an N-tier architecture combining an **Electron** desktop shell, a responsive **React 19** frontend, and a high-performance **ASP.NET Core (.NET 10.0)** backend powered by a local **SQLite** database.

---

## Table of Contents

- [Overview & Architecture](#overview--architecture)
- [Key Features](#key-features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [1. Installation](#1-installation)
  - [2. Running in Development](#2-running-in-development)
  - [3. Individual Component Scripts](#3-individual-component-scripts)
- [Running Automated Tests](#running-automated-tests)
- [Building & Distribution](#building--distribution)
  - [Windows Build](#windows-build)
  - [macOS Build](#macos-build)
- [Auto-Update System](#auto-update-system)
- [License](#license)

---

## Overview & Architecture

CashBook runs as a unified desktop application where the Electron shell orchestrates both the frontend user interface and the local ASP.NET Core backend API as a native subprocess.

```
┌─────────────────────────────────────────────────────────────┐
│                      CashBook Desktop                       │
│                                                             │
│  ┌────────────────────────┐     IPC     ┌────────────────┐  │
│  │     React Frontend     │ ◄─────────► │ Electron Shell │  │
│  │ (React 19 + Tailwind4) │             │  (Electron 33) │  │
│  └───────────┬────────────┘             └───────┬────────┘  │
│              │ HTTP REST                        │ Process   │
│              │ (port 5050)                      │ Lifecycle │
│              ▼                                  ▼           │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                 ASP.NET Core Web API                  │  │
│  │          (.NET 10.0 + EF Core + Clean Arch)           │  │
│  └───────────────────────────┬───────────────────────────┘  │
│                              │ SQLite Driver                │
│                              ▼                              │
│                 ┌─────────────────────────┐                 │
│                 │   Local SQLite Database │                 │
│                 │      (cashbook.db)      │                 │
│                 └─────────────────────────┘                 │
└─────────────────────────────────────────────────────────────┘
```

- **Frontend (UI)**: Built with React 19, TypeScript, Tailwind CSS v4, Radix UI, TanStack Table, and Zustand.
- **Backend (API & Business Logic)**: Built with ASP.NET Core (.NET 10.0), Entity Framework Core, FluentValidation, and ClosedXML.
- **Desktop Shell**: Electron 33 manages native windowing, auto-updates via GitHub Releases, and backend subprocess lifecycle.
- **Data Storage**: Fully offline, high-speed SQLite embedded database.

---

## Key Features

- **📊 Comprehensive Financial Dashboard**: Real-time totals for income, expenses, net balance, and month-over-month summaries.
- **💳 Multi-Account Management**: Create and track multiple accounts (Bank, Cash, Savings, Credit) with live balance recalculation.
- **📝 High-Performance Transaction Ledger**: TanStack Table data grid supporting custom sorting, multi-column search, date filtering, pagination, and inline edits.
- **⚡ Smart Description Autocomplete**: Dynamic description suggestions for swift and consistent transaction entry.
- **💾 Database Management & Tools**: Create point-in-time database backups, restore previous states, seed demo data, and view storage statistics.
- **📁 Excel Import & Export**: Import transactions from external spreadsheets and export accounting records to Excel using ClosedXML.
- **🚀 Portable & Installer Modes**: Support for standard Windows NSIS installers and zero-install portable execution with automatic local database path detection.
- **🔄 Seamless Auto-Updates**: Over-the-air updates distributed via GitHub Releases using `electron-updater`.

---

## Tech Stack

| Layer | Technologies |
|---|---|
| **Desktop Shell** | Electron 33, Electron Builder 25, Electron Updater 6 |
| **Frontend** | React 19, TypeScript 5.7, Vite 6, Tailwind CSS 4, TanStack React Table 8, Zustand 5, Radix UI, Lucide React, Sonner |
| **Backend API** | ASP.NET Core 10.0, C# 13, Entity Framework Core 10.0 (SQLite), FluentValidation 11, ClosedXML, Swagger / OpenAPI |
| **Testing** | xUnit 2.9, Moq 4.20, Microsoft.NET.Test.Sdk, Coverlet, ESLint |
| **Packaging & CI** | PowerShell (`build.ps1`), Bash (`build.sh`), NSIS, macOS DMG/ZIP |

---

## Project Structure

```text
CashBook/
├── .agent/workflows/       # Automated workflows (e.g., auto-update release guide)
├── backend/                # ASP.NET Core solution
│   ├── backend/            # Web API project (Controllers, Middleware, Program.cs)
│   ├── backend.service/    # Business services, Unit of Work, Repository implementations
│   ├── backend.model/      # EF Core DbContext, entity models, DTOs, migrations
│   ├── backend.common/     # Shared configuration, query extensions, custom exceptions
│   ├── backend.tests/      # Unit & integration test suite (120+ tests)
│   └── backend.slnx        # Visual Studio solution file
├── electron/               # Electron main process, preload script, packaging config
│   ├── assets/             # Application icons (.ico, .icns, .png)
│   ├── main.js             # Electron main process & backend lifecycle manager
│   ├── preload.js          # Secure context bridge IPC interface
│   └── package.json        # Electron build & updater configuration
├── frontend/               # React Vite Single Page Application
│   ├── src/                # Components, pages, hooks, state store, API clients
│   ├── public/             # Static web assets & application icons
│   ├── index.html          # HTML entry point
│   ├── vite.config.ts      # Vite bundler configuration
│   └── package.json        # Frontend scripts and dependencies
├── build.ps1               # Windows production build script (NSIS + Portable)
├── build.sh                # macOS & cross-platform production build script
├── package.json            # Root workspace scripts & concurrency tools
└── README.md               # Monorepo documentation
```

---

## Prerequisites

Ensure you have the following installed on your development machine:

- **[Node.js](https://nodejs.org/)**: `v20.x` or higher (`LTS` recommended)
- **[.NET SDK](https://dotnet.microsoft.com/download/dotnet/10.0)**: `v10.0` or higher
- **npm**: `v10.x` or higher (bundled with Node.js)
- **PowerShell** (for Windows build script) or **Bash** (for macOS build script)

---

## Getting Started

### 1. Installation

Install dependencies across the root, frontend, and electron packages in one command:

```bash
npm run install:all
```

### 2. Running in Development

Start the Backend API, Vite Dev Server, and Electron Shell concurrently with health checks:

```bash
npm run dev
```

- **Backend API**: Starts at `http://localhost:5050`
- **Swagger Documentation**: Available at `http://localhost:5050/swagger`
- **Frontend Dev Server**: Starts at `http://localhost:5173`
- **Electron Shell**: Launches automatically once both API and Frontend servers are ready.

### 3. Individual Component Scripts

You can also run components independently:

| Command | Action |
|---|---|
| `npm run dev:backend` | Runs the ASP.NET Core API at `http://localhost:5050` |
| `npm run dev:frontend` | Runs the React Vite frontend at `http://localhost:5173` |
| `npm run dev:electron` | Launches Electron (expects backend and frontend already running) |
| `npm run dev:start` | Starts frontend and launches Electron concurrently |

---

## Running Automated Tests

### Backend Test Suite

Run the full xUnit test suite (covering controllers, services, repositories, validators, and migrations):

```bash
dotnet test backend/backend.slnx
```

### Frontend Type Check & Linting

Run TypeScript type check and ESLint analysis:

```bash
cd frontend
npm run typecheck
npm run lint
```

---

## Building & Distribution

Production builds compile the React frontend into static assets, publish a self-contained single-file .NET backend, and package the application using `electron-builder`.

### Windows Build

Execute the PowerShell build script:

```powershell
npm run build-windows
```
*or directly run:*
```powershell
powershell -ExecutionPolicy Bypass -File ./build.ps1
```

**Outputs generated in `electron/dist/`:**
- `CashBook Setup <version>.exe` (NSIS Installer)
- `CashBook <version>.exe` (Portable Executable)
- `latest.yml` & `*.blockmap` (Auto-update metadata)

### macOS Build

Execute the Unix build script:

```bash
npm run build-mac
```
*or directly run:*
```bash
./build.sh
```

**Outputs generated in `electron/dist/`:**
- `CashBook-<version>.dmg` (macOS disk image installer)
- `CashBook-<version>-mac.zip` (macOS archive)
- `latest-mac.yml` (Auto-update metadata)

---

## Auto-Update System

CashBook includes integrated auto-updating powered by `electron-updater` and GitHub Releases.

1. Bump the `"version"` field in `electron/package.json`.
2. Run the production build script (`build.ps1` or `build.sh`).
3. Create a new GitHub Release tagged with `v<version>`.
4. Upload all files from `electron/dist/` (installers + metadata `.yml` files).
5. Existing installations will automatically detect and install the update on launch.

For detailed release steps, refer to [.agent/workflows/auto-update.md](file:///.agent/workflows/auto-update.md).

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
