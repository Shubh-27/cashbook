---
description: How to release an internet-based auto-update
---

Follow these steps to release a new version of CashBook with auto-update support:

1.  **Update Version Number**:
    - Open [electron/package.json](file:///Users/shubh/Documents/Code/cashbook/electron/package.json).
    - Increment the `"version"` field (e.g., from `"1.0.0"` to `"1.0.1"`).

2.  **Commit and Push Changes**:
    - Commit all your code changes (including the version bump).
    - Push the commits to the main branch on GitHub.

3.  **Run Build Script**:
    - On macOS, run: `./build.sh`.
    - On Windows, run: `./build.ps1`.
    - This will generate the distribution artifacts (DMG, Exe, and metadata YML files) in the `electron/dist/` folder.

4.  **Create GitHub Release**:
    - Go to the [CashBook GitHub Repository](https://github.com/Shubh-27/cashbook).
    - Navigate to **Releases** and click **Draft a new release**.
    - Set the **Tag version** to match your `package.json` version (e.g., `v1.0.1`).
    - Set the **Release title** (e.g., `CashBook v1.0.1`).

5.  **Upload Artifacts**:
    - Upload the files generated in `electron/dist/`:
        - **macOS**: `.dmg`, `.zip`, and `latest-mac.yml`.
        - **Windows**: `.exe`, `.blockmap`, and `latest.yml`.
    - **Note**: The `.yml` files are critical; `electron-updater` uses them to detect the new version.

6.  **Publish Release**:
    - Click **Publish release**.
    - Existing installations of the app will now automatically detect, download, and prompt to install the new version.

> [!IMPORTANT]
> For auto-updates to work on macOS, the application must be **code-signed** with an Apple Developer ID certificate. Without signing, the `autoUpdater` will detect the update but the OS will block its installation for security reasons.
