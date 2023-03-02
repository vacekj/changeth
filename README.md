# change – Privacy-preserving Sybil-resistant petitions and fundraising

---

## The Stack

- Package-Manager: `pnpm`
- Monorepo Tooling: `turborepo`
- Smart Contract Development: `foundry`
  - Typescript-Types: `typechain`
- Frontend: `next`
  - Contract Interactions: `wagmi`, `rainbowkit`
  - Styling: `chakra`, `tailwindcss`, `twin.macro`, `emotion`
- Misc:
  - Linting & Formatting: `eslint`, `prettier`, `husky`, `lint-staged`

## Getting Started

```bash
# Install pnpm
npm i -g pnpm

# Install dependencies
pnpm install

# Copy & fill environments
# NOTE: Documentation of environment variables can be found in the according `.example` files
cp packages/frontend/.env.local.example packages/frontend/.env.local
cp packages/contracts/.env.example packages/contracts/.env
```

## Development

### Quickstart

```bash
# Generate contract-types, start local hardhat node, and start frontend with turborepo
pnpm dev

# Only start frontend (from root-dir)
# NOTE: Alternatively it can just be started via `pnpm dev` inside `packages/frontend`
pnpm frontend:dev
```

| Environment Variable          | Value                             |
| ----------------------------- | --------------------------------- |
| `NEXT_PUBLIC_PRODUCTION_MODE` | `true`                            |
| `NEXT_PUBLIC_URL`             | `https://your-repo.vercel.app`    |
| `NEXT_PUBLIC_DEFAULT_CHAIN`   | `5`                               |
| `NEXT_PUBLIC_DEFAULT_CHAIN`   | `[5]`                             |
| `NEXT_PUBLIC_RPC_1`           | `https://rpc.ankr.com/eth`        |
| `NEXT_PUBLIC_RPC_5`           | `https://rpc.ankr.com/eth_goerli` |
