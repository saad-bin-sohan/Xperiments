# Xperiments Cloud Functions

## Runtime

- Node 20
- TypeScript

## Exported functions

### Notifications
- `onCheckinCreate`
- `dailyNudgeCheck`

### User lifecycle
- `onUserDisabled`

### Stats triggers
- `onUserDocumentCreate`
- `onExperimentCreate`
- `onExperimentDelete`

### Admin callables (admin-only)
- `adminGetFeatureFlags`
- `adminSetPassFailFlag`
- `adminGetBasicStats`
- `adminBackfillStats`

## Local development

```bash
cd functions
npm install
npm run build
npm run lint
```

## Emulator

```bash
cd functions
npm run serve
```

## Deploy

From repo root (preferred):

```bash
firebase deploy --project dev --only functions
```

Or from `functions/`:

```bash
npm run deploy
```
