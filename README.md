# Cashbook (Bank Manager)

A comprehensive desktop application for financial management, built with a modern N-tier architecture.

## Overview

Cashbook is a cross-platform desktop application that combines the power of Electron, React, and ASP.NET Core with a local SQLite database.

### Architecture

- **Frontend**: [React](frontend/README.md) - A responsive user interface built with React, Vite, and Tailwind CSS.
- **Backend API**: [ASP.NET Core](backend/README.md) - A robust C# backend providing RESTful services and SQLite database management.
- **Shell**: [Electron](electron/README.md) - The desktop environment that integrates the frontend and interacts with the operating system.

## Project Structure

```text
/backend          - ASP.NET Core solution (API, Services, Models)
/electron         - Electron main process and preload scripts
/frontend         - React Vite application
/build.sh         - Unix build script
/build.ps1        - Windows PowerShell build script
/package.json     - Root development scripts
```

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v16+)
- [.NET SDK](https://dotnet.microsoft.com/download) (v10.0+)
- [npm](https://www.npmjs.com/)

### Installation

Install dependencies for all components:

```bash
npm run install:all
```

### Development

To run all parts of the application concurrently (Backend, Frontend, and Electron):

```bash
npm run dev
```

The application will start the backend at `http://localhost:5050` and the frontend at `http://localhost:5173`. Electron will launch once both services are ready.

#### Individual Development Scripts

- **Backend**: `npm run dev:backend`
- **Frontend**: `npm run dev:frontend`
- **Electron**: `npm run dev:electron`

## Building for Production

To create a production build of the application:

```bash
npm run build
```

The build process is managed by `build.sh` (Mac/Linux) or `build.ps1` (Windows), which handles frontend bundling, backend publishing, and Electron packaging.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
