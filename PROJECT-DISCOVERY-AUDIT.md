# Rice2K GitHub Discoverability Audit

**Date:** October 27, 2026  
**Scope:** Public repositories belonging to @rice2k. Private repositories, account connections, stars, and existing archives were not changed.

## Audit summary

| Finding | Count |
| --- | ---: |
| Total accessible repositories | 77 |
| Public repositories | 62 |
| Private repositories (excluded from public Explorer) | 15 |
| Public repositories with no GitHub topics | 57 |
| Public repositories missing an About description | 6 |
| Public repositories with GitHub Pages enabled but no homepage link in About | 6 |

Repository **About description**, **Topics**, and **Website** are GitHub repository settings separate from README contents. Improving README text helps visitor understanding and some forms of discovery, but does **not** change these settings automatically.

## Priority 1: add missing About descriptions

In the public repository page, find the About panel and click its gear / Edit button.

| Repository | Suggested description | Suggested topics |
| --- | --- | --- |
| [Rice2k-Folder-Vault](https://github.com/rice2k/Rice2k-Folder-Vault) | Experimental Windows encrypted folder vault in C# with password-protected .rvault containers, authenticated encryption, and read-only Explorer mounting. Alpha software; runtime verification pending. | windows, csharp, encryption, file-vault, argon2id, dokannet, alpha |
| [Graal-Level-Viewer](https://github.com/rice2k/Graal-Level-Viewer) | Preserved C# Windows Forms GraalOnline level viewer fork, with build notes and upstream attribution. | graal, graalonline, level-viewer, csharp, windows-forms, preservation |
| [GraalOnline-ChatBot](https://github.com/rice2k/GraalOnline-ChatBot) | Review code and add a precise description of supported chat features and platform. | graalonline, chatbot (only if confirmed) |
| [GServer-v2](https://github.com/rice2k/GServer-v2) | Review the code and document the server implementation and supported protocol before publishing a description. | graalonline (only if confirmed) |
| [Graal-Char-View](https://github.com/rice2k/Graal-Char-View) | Review the code and document supported character-file formats and viewing features. | graalonline (only if confirmed) |
| [startpage](https://github.com/rice2k/startpage) | Describe its historical or third-party start-page purpose after checking the upstream project. | startpage, browser-homepage (only if confirmed) |

Avoid marketing unverified features or claiming ownership of upstream forks.

## Priority 2: add public project URLs and topics

Only attach website URLs that are genuinely public and working. GitHub Pages being enabled does not, by itself, prove the site is published successfully.

| Repository | Suggested GitHub About website | Suggested topics |
| --- | --- | --- |
| [rice2k-startdeck](https://github.com/rice2k/rice2k-startdeck) | https://rice2k.github.io/rice2k-startdeck/ | startpage, browser-dashboard, windows, bookmarks, productivity, github-pages |
| [old-free-online-resources](https://github.com/rice2k/old-free-online-resources) | https://rice2k.github.io/old-free-online-resources/ | retro-web, old-web, web-archive, internet-history, wayback-machine, link-directory |
| [Graalians-Discord-Server-Tool-Hub](https://github.com/rice2k/Graalians-Discord-Server-Tool-Hub) | https://rice2k.github.io/Graalians-Discord-Server-Tool-Hub/ | Existing GraalOnline topics are good; set the website and improve the short description |
| [Computer-Asset-System-Info](https://github.com/rice2k/Computer-Asset-System-Info) | Confirm that GitHub Pages is actually published before adding its URL | windows, it-support, computer-inventory, diagnostics, python, helpdesk |
| [rice2k-magic-tasks](https://github.com/rice2k/rice2k-magic-tasks) | Confirm the Pages build is public before adding its URL | Topics already extensive and descriptive |
| [Graal-Gmap-Generater-PHp](https://github.com/rice2k/Graal-Gmap-Generater-PHp) | Confirm the Pages build is public before adding its URL | graal, graalonline, gmap, php, level-editor |

## Priority 3: improve project-specific metadata

- **[Cyber-Tool-Atlas](https://github.com/rice2k/Cyber-Tool-Atlas)**: topics such as cybersecurity, security-tools, tool-directory, cybersecurity-resources, github-pages. Existing public homepage is configured.
- **[CoolKids-Archive-Website](https://github.com/rice2k/CoolKids-Archive-Website)**: topics such as web-preservation, retro-web, internet-history, coolkid, website-restoration. Do not advertise the owner-private hosted copy as a public demo.
- **[Rice2k-Macro-Studio](https://github.com/rice2k/Rice2k-Macro-Studio)**: topics such as windows, automation, macro-recorder, mouse-keyboard, desktop-app.
- **[rice2k-computer-cleaner](https://github.com/rice2k/rice2k-computer-cleaner)**: topics such as windows, pc-maintenance, system-cleaner, diagnostics, desktop-tool.
- **[BTK-Graal-Guild-site-Remake-Archive](https://github.com/rice2k/BTK-Graal-Guild-site-Remake-Archive)**: topics such as graalonline, guild, web-preservation, retro-web, wayback-machine.
- **[WiFi-Vault-Pro](https://github.com/rice2k/WiFi-Vault-Pro)**: topics such as windows, wifi, network-diagnostics, python. Replace the generic profile homepage only after confirming a project-specific public URL.
- **[NW2PNG2.0](https://github.com/rice2k/NW2PNG2.0)**: topics such as graalonline, level-editor, gmap, java, image-export.
- **[gs2-scripts](https://github.com/rice2k/gs2-scripts)**: topics such as graalonline, graalscript2, gs2, scripts, guild-system.
- **[AOL-Progz](https://github.com/rice2k/AOL-Progz)**: already has relevant preservation topics; retain the original attribution and historic context.

## Search and profile improvements

- Project Explorer: https://rice2k.github.io/rice2k-startdeck/projects/
- Main public profile: https://github.com/rice2k
- Explorer code and docs: https://github.com/rice2k/rice2k-startdeck/tree/main/projects
- The profile README includes featured projects, direct demos, category links, and searchable query links.
- The Explorer indexes only public metadata and publicly starred repositories. It cannot index private code or every file body.
- For source-code searching, use GitHub's code search. For site search engines, use distinct page titles, accurate descriptions, and natural project-specific wording.

## Recommended README template for active original work

1. One-sentence plain-English summary: what it does, who it helps, and the target platform.
2. Status and limitations, including alpha/experimental/archival warnings where relevant.
3. One clear button or link for live demo or release downloads, if they exist.
4. Screenshot, example output, and a small features table.
5. Quick start, dependencies, system requirements, and license/credit details.
6. Specific repository topics (in the GitHub About UI), then link the live site.
7. Keep fork/upstream attribution and don't rename third-party work as newly authored code.

## Publishing checklist

- Open each public repo's About edit control; set the description, website, and topics.
- Use relevant, distinct topic names. Do not keyword-stuff irrelevant subjects.
- Keep an accurate status for encrypted-vault alpha work and recovered web artifacts.
- Verify GitHub Pages links in a regular browser and ensure internal navigation/downloads work.
- Open the Project Explorer and use Refresh to see the updated metadata after the public API refreshes.
- Add the new Explorer and strongest matching original projects to the GitHub pinned section manually, if desired. Pinned selection is a separate profile setting.

This document is a settings-and-content audit, not evidence that missing GitHub About settings were already changed.
