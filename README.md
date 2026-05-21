# monorepo-starter

[![Use this template](https://img.shields.io/badge/-Use%20this%20template-2ea44f?style=for-the-badge)](https://github.com/AdamDjo/monorepo-starter/generate)
[![CI](https://github.com/AdamDjo/monorepo-starter/actions/workflows/ci.yml/badge.svg)](https://github.com/AdamDjo/monorepo-starter/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

Production-ready monorepo template — Next.js 15 + Express + TypeScript + Turborepo + Claude Code.

**Never configure a monorepo from scratch again.** Clone, run setup, open Claude Code, type `go new-project` — done.

## What's included

| Tool | Purpose |
|---|---|
| **Turborepo** | Monorepo build orchestration |
| **pnpm workspaces** | Package manager |
| **Next.js 15** | Frontend (App Router, TypeScript, Tailwind CSS 4) |
| **Express** | Backend API (TypeScript, Zod validation) |
| **Supabase** | Database + Auth (swappable) |
| **ESLint + Prettier** | Shared configs across all apps |
| **Vitest** | Unit testing (frontend + backend) |
| **Cypress** | E2E testing |
| **Husky + commitlint** | Git hooks + conventional commits |
| **GitHub Actions** | CI, PR automation, releases, CodeQL |
| **Renovate** | Automated dependency updates |
| **Docker** | Multi-stage builds for both apps |
| **Claude Code** | AI-assisted development (agents + skills) |

## Prerequisites

- Node 20+
- pnpm 9+
- Git
- GitHub CLI (`gh`)
- Claude Code (optional but recommended)

## Quick start

```bash
# 1. Use this template (GitHub UI) or clone
git clone https://github.com/AdamDjo/monorepo-starter.git my-project
cd my-project

# 2. First-time setup
bash scripts/setup.sh

# 3. Configure GitHub labels + milestones
GITHUB_TOKEN=xxx bash .github/setup-github.sh

# 4. Open Claude Code and initialize your project
# Type: go new-project
```

## Project structure

```
monorepo-starter/
├── apps/
│   ├── frontend/          # Next.js 15 (App Router)
│   └── backend/           # Express API
├── packages/
│   ├── shared/            # Shared TypeScript types
│   ├── eslint-config/     # Shared ESLint configs
│   └── prettier-config/   # Shared Prettier config
├── docs/                  # Project documentation
├── .github/               # GitHub Actions, issue templates, labeler
├── .claude/               # Claude Code agents & skills
└── scripts/               # Setup scripts
```

## Available commands

```bash
pnpm dev             # Start all apps
pnpm build           # Build all
pnpm lint            # Lint all
pnpm type-check      # TypeScript check all
pnpm test            # Run unit tests
pnpm knip            # Find dead code
```

## Start a new project

Open Claude Code in this repo and type:

```
go new-project
```

Claude will ask you about your project (name, description, stack preferences) and automatically:
- Generate `docs/PRODUCT_DESIGN.md` and `docs/ARCHITECTURE.md`
- Create GitHub milestones and Phase 1 issues
- Rename the `@starter/*` npm scope to your project scope
- Set up the `develop` branch

## Claude Code skills

| Skill | Usage |
|---|---|
| `/feature <name>` | Create issue + branch from develop |
| `/bug <name>` | Create bug issue + branch |
| `/hotfix <name>` | Create hotfix from main |
| `/pr` | Push branch + open PR |
| `/release <version>` | Create release branch |
| `/sync` | Sync develop with main |
| `/implement <feature>` | Full implementation workflow |
| `/status` | Show project progress |
| `/check` | Run lint + type-check |

## Configure MCP (optional)

Copy `.mcp.json.example` to `.mcp.json` and fill in your credentials:

```bash
cp .mcp.json.example .mcp.json
```

## npm scope

Default scope is `@starter/*`. After running `go new-project`, Claude will rename it to `@<your-scope>/*` everywhere.

## License

MIT
