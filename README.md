# changeth – Privacy-preserving Sybil-resistant petitions and fundraising

Imagine Change.org but all your signatures are private, you can donate money to the cause without revealing your address and all the signatories are real humans (not bots).

Sybil resistance:
- World ID
- Gitcoin Passport
- any other Sybil-resistance mechanism

Private - don’t reveal people who have signed the petition or contributed financially
- BUT optionally reveal when the cause owner has withdrawn the funds
- BUT reveal your identity selectively for potential rewards or as a public show of support

Private donations using https://www.zkbob.com/

can also be used as a private Kickstarter - fundraising program

# Contracts

- permissionless contract that verifies the VC based on trusted issuers and adds the identity to the group. 
- multisig-owned governance of trusted issuers


# Roadmap
1. Implement creation of petitions, storage on IPFS and management of petitions
2. Enable signatures without sybil resistance
3. Integrate World ID for simple proof-of-humanity verification
4. Implement Gitcoin Passport for soft sybil resistance
5. Integrate zkBob for private donations

Petition operators will be able to choose which sybil resistance mechanisms they want to gate their petition with, and whether they want to be able to accept donations.

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
cp packages/semaphore/.env.example packages/semaphore/.env
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
