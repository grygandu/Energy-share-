EnergyShare Smart Contract

**A Decentralized Energy Contribution and Reward Protocol on the Stacks Blockchain**

---

Overview

**EnergyShare** is a **Clarity smart contract** designed to enable transparent, trustless, and fair sharing of renewable energy credits using **STX tokens**.  
It allows users to contribute energy (represented by STX deposits), track their participation, and receive proportional rewards for their contributions — fostering a **green, community-driven energy ecosystem**.

---

Key Features

- **Energy Contribution Tracking** – Record and verify user energy inputs using on-chain transactions.  
- **Reward Distribution** – Automatically distribute STX rewards based on total contribution share.  
- **Transparency** – Every contribution and payout is fully verifiable on the blockchain.  
- **Sustainability-Focused** – Incentivizes renewable energy generation and responsible consumption.  
- **Secure Withdrawals** – Contributors can withdraw their earned rewards trustlessly.

---
Technical Summary

| Item | Description |
|------|--------------|
| **Contract Name** | `energy-share.clar` |
| **Language** | [Clarity](https://docs.stacks.co/write-smart-contracts/clarity-language) |
| **Network** | Stacks Blockchain |
| **Token Type** | STX (Stacks native token) |
| **Purpose** | Track and reward decentralized energy contributions |

---

Functions Overview

| Function | Type | Description |
|-----------|------|-------------|
| `contribute-energy (amount uint)` | Public | Allows users to contribute STX to the energy pool. |
| `distribute-rewards ()` | Public | Distributes rewards among contributors based on shares. |
| `withdraw-reward (user principal)` | Public | Enables users to withdraw their earned STX rewards. |
| `get-contributor-info (user principal)` | Read-only | Returns contribution and reward data for a user. |

---

How It Works

1. **Contribute STX** → Users deposit STX tokens as proof of renewable energy contribution.  
2. **Track Participation** → The contract logs contributions and maintains balances for all participants.  
3. **Distribute Rewards** → Rewards are distributed proportionally to each contributor’s share.  
4. **Withdraw Anytime** → Contributors can claim rewards after distribution is executed.

---
Testing

Use [Clarinet](https://github.com/hirosystems/clarinet) to test and simulate the contract locally.

```bash
# Clone this repository
git clone https://github.com/<your-username>/energy-share.git
cd energy-share

# Run tests
clarinet test
