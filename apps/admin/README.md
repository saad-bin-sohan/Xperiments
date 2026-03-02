# Xperiments Admin

React + Vite + TypeScript admin panel hosted on Firebase Hosting.

## Features

- Admin-only authentication (Email/Password + Firestore `isAdmin` gate)
- Dashboard stats from aggregated counters
- Gallery manager (create/edit/delete/feature templates)
- User manager (view users, deactivate accounts)
- Feature flags panel (Remote Config `pass_fail_enabled` via callable functions)

## Setup

1. Create env file:

```bash
cp .env.example .env.local
```

2. Fill Firebase web app config values in `.env.local`.
3. Install and run:

```bash
npm install
npm run dev
```

## Build

```bash
npm run build
```

## Deploy (from repo root)

```bash
firebase deploy --project dev --only hosting:admin
firebase deploy --project prod --only hosting:admin
```

## First admin account

Set `users/{uid}.isAdmin = true` for the initial admin user in Firestore.
