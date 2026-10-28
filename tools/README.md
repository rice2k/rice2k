# Rice2K repository metadata maintenance

The **[Update-Repo-Metadata.ps1](Update-Repo-Metadata.ps1)** script can improve the search metadata that GitHub shows in the repository **About** section. It is a **local, manual GitHub CLI tool** rather than an automatically executed cloud workflow.

## What it can change

For 22 selected public repositories, the script can:
- merge useful GitHub topics into each repository's current topics without deleting any;
- fill empty descriptions and selectively refresh a few short/generic descriptions;
- attach known GitHub Pages homepage addresses for specified sites;
- leave existing homepage values untouched where no verified public URL was supplied.

It **never** changes repository visibility, deletes files, creates paid resources, stars or unstars anything, or attempts to edit private/archived/forked repositories. It checks the GitHub account login is exactly **rice2k** before proceeding.

## How to use it on Windows 11

1. Install the free official [GitHub CLI](https://cli.github.com/) if it isn't already installed.
2. Open PowerShell or Windows Terminal.
3. Authenticate using: `gh auth login`. Use your own GitHub account. Do not paste authentication tokens into ChatGPT or commit them to the repository.
4. Download or clone the `rice2k/rice2k` repository using your usual GitHub workflow.
5. In its root directory, preview the plan with:

   ```powershell
.\tools\Update-Repo-Metadata.ps1
```

6. Review the changes listed in preview output. The preview makes **no changes**.
7. If they look right, apply them with:

   ```powershell
.\tools\Update-Repo-Metadata.ps1 -Apply
```

8. Refresh the public [Project Explorer](https://rice2k.github.io/rice2k-startdeck/projects/) to read the new metadata.

If your PowerShell execution policy blocks running your own script, inspect the source before using a **process-scoped** execution policy setting. Do not permanently disable Windows security protections.

## Safety and API behavior

- This script authenticates through GitHub CLI, **not** by storing access tokens in a script.
- Changes use the official GitHub REST API for repository settings and topic names.
- **GitHub must authorize your authenticated account to edit each repository's settings.** If API calls fail, the script reports an error instead of claiming success.
- It performs independent checks for private, archived, forked and non-owner repositories before updating metadata.
- Topic changes preserve existing entries (unless GitHub's limit would be exceeded, in which case the topic write is skipped).
- Running the script twice should cause no additional changes when repository settings already match.
- The script changes repository **About settings only**; it does not alter the profile's native pinned repository selection.

## Other site improvements

- [Public Project Explorer](https://rice2k.github.io/rice2k-startdeck/projects/)
- [Static index of all public repositories](https://rice2k.github.io/rice2k-startdeck/projects/all-projects.html)
- [Full public-repository audit](../PROJECT-DISCOVERY-AUDIT.md)

**Important:** Committing this script does **not** apply the proposed settings. They are only changed after it is run with `-Apply` under your authenticated GitHub account.
