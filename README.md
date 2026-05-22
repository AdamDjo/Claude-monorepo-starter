# monorepo-starter

[![Use this template](https://img.shields.io/badge/-Use%20this%20template-2ea44f?style=for-the-badge)](https://github.com/AdamDjo/monorepo-starter/generate)
[![CI](https://github.com/AdamDjo/monorepo-starter/actions/workflows/ci.yml/badge.svg)](https://github.com/AdamDjo/monorepo-starter/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)

Production-ready monorepo template with a guided setup powered by Claude Code.

Clone it, run one command, answer Claude's questions — your project is configured and ready to develop.

---

## How it works

```
you                    Claude Code
 │                         │
 ├─ clone + setup.sh       │
 ├─ go new-project ───────►│
 │                         ├─ "What's the name of your project?"
 ├─ MyApp ────────────────►│
 │                         ├─ "Short description?"
 ├─ A SaaS for... ────────►│
 │                         ├─ "Frontend: Next.js 15 or something else?"
 ├─ Next.js ──────────────►│
 │                         ├─ "Backend: Express or NestJS/FastAPI/Hono/...?"
 ├─ Express ──────────────►│
 │                         ├─ "Database: Supabase, Prisma, MongoDB, ...?"
 ├─ Supabase ─────────────►│
 │                         ├─ "AI integration? Which providers?"
 ├─ Claude + OpenAI ──────►│
 │                         ├─ "GitHub username/repo?"
 ├─ myname/myapp ─────────►│
 │                         │
 │                         ├─ generates docs/PRODUCT_DESIGN.md
 │                         ├─ generates docs/ARCHITECTURE.md
 │                         ├─ renames @starter/* → @myapp/*
 │                         ├─ creates GitHub milestones + Phase 1 issues
 │                         └─ creates develop branch
 │
 └─ /feature auth  ───────► creates issue + branch, ready to code
```

---

## Prerequisites

- [Node 20+](https://nodejs.org)
- [pnpm 9+](https://pnpm.io/installation)
- [Claude Code](https://claude.ai/code) — the CLI or VS Code extension
- [GitHub CLI](https://cli.github.com) (`gh`)

---

## Step 1 — Get the template

**Option A — GitHub template** (recommended)

Click **"Use this template"** at the top of this page, create your repo, then clone it:

```bash
git clone https://github.com/<you>/<your-project>.git
cd <your-project>
```

**Option B — Clone directly**

```bash
git clone https://github.com/AdamDjo/monorepo-starter.git <your-project>
cd <your-project>
```

---

## Step 2 — Install dependencies

```bash
bash scripts/setup.sh
```

This installs dependencies, copies `.env.example` files, and sets up Git hooks.

---

## Step 3 — Configure GitHub

This creates all labels (type, priority, domain, phase, status) and milestones (Phase 1 / 2 / 3) on your repo:

```bash
GITHUB_TOKEN=<your-token> GITHUB_REPOSITORY=<you>/<repo> bash .github/setup-github.sh
```

To generate a token: GitHub → Settings → Developer settings → Personal access tokens → scopes: `repo`.

---

## Step 4 — Launch the guided setup

Open Claude Code in the project folder.

**In the terminal:**

```bash
claude
```

**In VS Code:** open the command palette → `Claude Code: Open`

Then type:

```
go new-project
```

Claude will ask you questions one by one:

| Question               | Example answer                                                    |
| ---------------------- | ----------------------------------------------------------------- |
| Project name           | `MyApp`                                                           |
| Short description      | `A SaaS for managing invoices`                                    |
| Main feature / purpose | `Let freelancers send invoices and get paid online`               |
| Frontend stack         | `Next.js 15` (default) or `React+Vite`, `Remix`, `SvelteKit`...   |
| Backend stack          | `Express` (default) or `NestJS`, `FastAPI`, `Hono`, `tRPC`...     |
| Database               | `Supabase` (default) or `Postgres+Prisma`, `MongoDB`, `SQLite`... |
| AI integration         | `Claude + OpenAI` or `none`                                       |
| GitHub username/repo   | `myname/myapp`                                                    |
| npm scope              | `@myapp` (replaces `@starter` everywhere)                         |

After you answer, Claude automatically:

- Generates `docs/PRODUCT_DESIGN.md` with your vision, features, and user stories
- Generates `docs/ARCHITECTURE.md` with your tech choices, data model, and API design
- Updates `docs/MEMORY.md` so every future Claude session has context
- Renames `@starter/*` → `@<your-scope>/*` in all `package.json`, `tsconfig.json`, and config files
- Creates GitHub milestones: Phase 1 — Foundation, Phase 2 — MVP, Phase 3 — Polish
- Creates your first Phase 1 issues on GitHub
- Creates and pushes the `develop` branch

At the end you get a confirmation summary and you're ready to code.

---

## Day-to-day workflow

All commands are typed inside Claude Code (terminal or VS Code extension).

### Start a new feature

```
/feature <name>
```

Claude creates a GitHub issue, adds it to the Scrum Board, and creates a `feature/<issue>-<name>` branch from `develop`.

```
/feature user-authentication
```

### Fix a bug

```
/bug <name>
```

Creates an issue + `fix/<issue>-<name>` branch from `develop`.

### Open a pull request

```
/pr
```

Pushes your branch, opens a PR with the correct labels and milestone, and links it to the issue.

### Create a release

```
/release 1.0.0
```

Creates `release/1.0.0`, triggers CI, creates the GitHub Release and tag automatically.

### Other commands

| Command                    | What it does                                             |
| -------------------------- | -------------------------------------------------------- |
| `/hotfix <name>`           | Urgent fix from `main`                                   |
| `/sync`                    | Sync `develop` with `main` after hotfix/release          |
| `/implement <description>` | Full implementation workflow (plan → code → verify)      |
| `/status`                  | Show current phase, next tasks, recent commits           |
| `/check`                   | Run type-check + lint across the whole monorepo          |
| `/docs`                    | Update `MEMORY.md` + `ARCHITECTURE.md` from current code |

---

## Project structure

```
<your-project>/
├── apps/
│   ├── frontend/          # Next.js 15 (App Router + TypeScript + Tailwind CSS 4)
│   └── backend/           # Express API (TypeScript + Zod + Supabase)
├── packages/
│   ├── shared/            # Shared TypeScript types (imported by both apps)
│   ├── eslint-config/     # Shared ESLint rules (base, next, backend)
│   └── prettier-config/   # Shared Prettier config
├── docs/
│   ├── MEMORY.md          # Persistent project state — Claude reads this every session
│   ├── PRODUCT_DESIGN.md  # Generated by go new-project
│   └── ARCHITECTURE.md    # Generated by go new-project
├── .github/
│   ├── workflows/         # CI, PR automation, release, CodeQL
│   ├── ISSUE_TEMPLATE/    # Bug, feature, chore templates
│   └── setup-github.sh    # Creates labels + milestones on your repo
├── .claude/
│   ├── agents/            # Specialized agents (frontend, backend, reviewer, project-setup)
│   └── skills/            # Commands: /feature, /bug, /pr, /release, /sync...
└── scripts/
    └── setup.sh           # First-time setup script
```

---

## Monorepo commands

```bash
bash scripts/setup.sh       # First-time setup

pnpm dev                    # Start all apps (frontend + backend)
pnpm dev --filter frontend  # Start frontend only
pnpm dev --filter backend   # Start backend only
pnpm build                  # Build everything
pnpm lint                   # Lint all workspaces
pnpm type-check             # TypeScript check all workspaces
pnpm test                   # Run all unit tests
pnpm knip                   # Find unused exports and dead code
```

---

## What's included

| Category        | Tool                                 | Why                                                           |
| --------------- | ------------------------------------ | ------------------------------------------------------------- |
| Monorepo        | Turborepo + pnpm                     | Fast builds, workspace management                             |
| Frontend        | Next.js 15, React 19, Tailwind CSS 4 | App Router, SSR, TypeScript                                   |
| Backend         | Express, Zod                         | Lightweight, typed, validated                                 |
| Database        | Supabase                             | PostgreSQL + Auth + Storage out of the box                    |
| Linting         | ESLint v9 + Prettier                 | Shared flat configs across all workspaces                     |
| Testing         | Vitest + Cypress                     | Unit + E2E, coverage reports                                  |
| Git hooks       | Husky + commitlint                   | Enforces conventional commits, blocks `Co-Authored-By Claude` |
| CI              | GitHub Actions                       | Lint, type-check, test, build on every PR                     |
| PR automation   | labeler + milestone workflow         | Auto-assigns labels and milestones by branch name             |
| Releases        | release.yml                          | Creates tag + GitHub Release from `release/*` branches        |
| Security        | CodeQL                               | Weekly static analysis                                        |
| Deps            | Renovate                             | Auto-merges patch/minor, groups by domain                     |
| Docker          | Multi-stage builds                   | Optimized images for frontend (standalone) and backend        |
| AI-assisted dev | Claude Code agents + skills          | Speeds up the entire development cycle                        |

---

## MCP setup (optional but recommended)

MCP gives Claude access to your GitHub repo and Supabase project directly, enabling the `/feature`, `/pr`, and `/create-issues` skills.

```bash
cp .mcp.json.example .mcp.json
# Fill in your tokens
```

---

## npm scope

The default scope is `@starter/*`. Running `go new-project` renames it everywhere to `@<your-scope>/*`. If you want to rename it manually:

```bash
# Files to update: package.json (×5), tsconfig.json (×2), eslint.config.js (×2)
grep -r "@starter/" --include="*.json" --include="*.js" --include="*.ts" -l
```

---

## License

MIT
