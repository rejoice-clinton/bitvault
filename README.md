# BitVault Protocol

> Revolutionary multi-asset collateralized debt position system enabling Bitcoin and Stacks holders to unlock liquidity while maintaining asset exposure on Bitcoin's Layer 2.

[![Stacks](https://img.shields.io/badge/Built%20on-Stacks-663399?style=flat-square&logo=stacks)](https://stacks.co)
[![Bitcoin](https://img.shields.io/badge/Secured%20by-Bitcoin-F7931A?style=flat-square&logo=bitcoin)](https://bitcoin.org)
[![Clarity](https://img.shields.io/badge/Language-Clarity-4A90E2?style=flat-square)](https://clarity-lang.org)

## Overview

BitVault Protocol is a decentralized lending platform that allows users to mint USDx stablecoin by depositing STX and xBTC as collateral. Built on the Stacks blockchain and secured by Bitcoin, BitVault enables capital efficiency for Bitcoin holders without requiring them to sell their assets.

### Key Features

- **Multi-Asset Collateral**: Support for STX and xBTC collateral types
- **Overcollateralized Loans**: Minimum 200% collateralization ratio for new vaults
- **Automated Liquidation**: Trustless liquidation at 150% health factor
- **Real-time Oracle Integration**: Dynamic price feeds with staleness protection
- **Institutional Security**: Bitcoin-secured smart contracts with comprehensive risk management
- **SIP-010 Compliant**: USDx token follows Stacks token standard

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    BitVault Protocol                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────┐  │
│  │   Oracle    │  │    Vault    │  │    Liquidation      │  │
│  │   System    │  │  Management │  │      Engine         │  │
│  │             │  │             │  │                     │  │
│  │ • Price     │  │ • Create    │  │ • Health Factor     │  │
│  │   Feeds     │  │ • Collateral│  │   Monitoring        │  │
│  │ • Operators │  │ • Mint/Burn │  │ • Auto Liquidation  │  │
│  │ • Staleness │  │ • Withdraw  │  │ • Penalty System    │  │
│  └─────────────┘  └─────────────┘  └─────────────────────┘  │
│                                                             │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                USDx Token (SIP-010)                     │  │
│  │                                                         │  │
│  │ • Fungible Token Implementation                         │  │
│  │ • Mint on Collateral Deposit                           │  │
│  │ • Burn for Debt Repayment                              │  │
│  │ • Standard Transfer Functions                           │  │
│  └─────────────────────────────────────────────────────────┘  │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│                    Stacks Blockchain                        │
├─────────────────────────────────────────────────────────────┤
│                    Bitcoin Network                          │
└─────────────────────────────────────────────────────────────┘
```

## Contract Architecture

### Core Components

#### 1. Vault Management System

- **Vault Creation**: Users deposit STX/xBTC collateral to create vaults
- **Collateral Management**: Add/withdraw collateral with ratio validation
- **Debt Management**: Mint USDx against collateral, burn to reduce debt
- **Multi-User Support**: Each user can manage up to 10 vaults

#### 2. Oracle Price Feed System

- **Real-time Pricing**: Dynamic price updates for STX and xBTC
- **Authorized Operators**: Controlled access to price feed updates
- **Staleness Protection**: Maximum 1-hour price age validation
- **Confidence Scoring**: Price reliability metrics (1-100 scale)

#### 3. Liquidation Engine

- **Health Factor Calculation**: Real-time collateralization ratio monitoring
- **Automated Liquidation**: Triggered when health factor drops below 150%
- **Liquidation Incentives**: 10% penalty distributed to liquidators
- **Authorized Liquidators**: Permissioned liquidation system

#### 4. Risk Management Framework

- **Minimum Collateral Ratio**: 200% for new vault creation
- **Liquidation Threshold**: 150% health factor trigger
- **Maximum Price Age**: 1-hour staleness protection
- **Amount Validation**: Comprehensive input sanitization

## Data Flow

### Vault Creation Flow

```
User Request → Collateral Validation → Price Oracle Query → 
Ratio Calculation → STX Transfer → Vault Registration → 
Protocol Stats Update → Vault ID Return
```

### USDx Minting Flow

```
Mint Request → Vault Ownership Check → Current Price Fetch → 
Collateral Value Calculation → Ratio Validation → 
USDx Token Mint → Debt Update → Protocol Stats Update
```

### Liquidation Flow

```
Health Check → Ratio Calculation → Liquidation Trigger → 
Liquidator Authorization → USDx Burn → Collateral Transfer → 
Vault Deactivation → Protocol Stats Update
```

## Technical Specifications

### Protocol Parameters

- **Liquidation Ratio**: 150% (health factor threshold)
- **Minimum Collateral Ratio**: 200% (new vault requirement)
- **Liquidation Penalty**: 10% (liquidator incentive)
- **Stability Fee**: 2% annual (future implementation)
- **Max Price Age**: 3600 seconds (1 hour)

### Token Standards

- **USDx Token**: SIP-010 compliant fungible token
- **Decimals**: 6 (micro-units)
- **Supply**: Dynamic based on collateral deposits

### Error Handling

Comprehensive error code system with specific failure reasons:

- Authorization errors (1000)
- Vault management errors (1001-1004)
- Amount validation errors (1005)
- Oracle-related errors (1006)
- Collateral ratio violations (1007)
- Token operation failures (1008-1010)

## Security Features

### Access Control

- **Contract Owner**: Protocol parameter management
- **Oracle Operators**: Price feed update authorization
- **Authorized Liquidators**: Liquidation execution permissions
- **Vault Owners**: Exclusive vault management rights

### Risk Mitigation

- **Overcollateralization**: Minimum 200% collateral requirement
- **Price Staleness Protection**: Maximum 1-hour price age
- **Liquidation Automation**: Prevents undercollateralized positions
- **Input Validation**: Comprehensive parameter checking

### Bitcoin Security

- **Stacks Integration**: Inherits Bitcoin's security guarantees
- **Immutable Logic**: Smart contract execution on Bitcoin-secured network
- **Transparent Operations**: All transactions verifiable on-chain

## Integration Guide

### For Developers

```clarity
;; Create a new vault
(contract-call? .bitvault-protocol create-vault u1000000 u0)

;; Mint USDx against collateral
(contract-call? .bitvault-protocol mint-usdx u1 u500000)

;; Check vault health
(contract-call? .bitvault-protocol calculate-health-factor u1)
```

### For Liquidators

```clarity
;; Check if vault can be liquidated
(contract-call? .bitvault-protocol is-vault-safe u1)

;; Execute liquidation
(contract-call? .bitvault-protocol liquidate-vault u1)
```

### For Oracle Operators

```clarity
;; Update price feeds
(contract-call? .bitvault-protocol update-price "STX" u1200000 u95)
```

## Protocol Statistics

The contract maintains comprehensive protocol metrics:

- Total active vaults
- Total debt outstanding
- Total collateral locked (STX + xBTC)
- USDx token supply
- Liquidation pool reserves

## Governance & Administration

### Owner Functions

- Emergency protocol shutdown
- Liquidation ratio updates
- Oracle operator management
- Liquidator authorization

### Future Enhancements

- Governance token implementation
- Community parameter voting
- Multi-signature administrative controls
- Additional collateral asset support

## Risk Disclaimers

⚠️ **Important**: BitVault Protocol involves significant financial risks:

- Smart contract risk and potential bugs
- Market volatility affecting collateral values
- Liquidation risk during price fluctuations
- Oracle manipulation or failure risks

Always conduct thorough due diligence and never invest more than you can afford to lose.
