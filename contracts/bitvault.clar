;; Title: BitVault Protocol - Multi-Asset Collateralized Debt Position System
;;
;; Summary: Revolutionary decentralized lending protocol enabling users to mint 
;; stable USDx tokens by collateralizing STX and xBTC assets with automated 
;; liquidation protection and dynamic risk management on Bitcoin's Layer 2.
;;
;; Description: BitVault Protocol transforms Bitcoin and Stacks ecosystem 
;; liquidity by creating a trustless, over-collateralized lending platform. 
;; Users deposit STX and xBTC as collateral to mint USDx stablecoin, maintaining 
;; exposure to Bitcoin's value while accessing immediate liquidity. Features 
;; include real-time oracle price feeds, automated liquidation engine, 
;; multi-collateral support, and comprehensive risk management. Built for 
;; institutional-grade security with community governance and transparent 
;; protocol metrics. Empowers Bitcoin HODLers to unlock capital efficiency 
;; without selling their precious sats.

;; CONSTANTS AND CONFIGURATION

(define-constant CONTRACT-OWNER tx-sender)

;; Error Code Definitions
(define-constant ERR-NOT-AUTHORIZED (err u1000))
(define-constant ERR-VAULT-NOT-FOUND (err u1001))
(define-constant ERR-INSUFFICIENT-COLLATERAL (err u1002))
(define-constant ERR-VAULT-UNDERCOLLATERALIZED (err u1003))
(define-constant ERR-LIQUIDATION-NOT-ALLOWED (err u1004))
(define-constant ERR-INVALID-AMOUNT (err u1005))
(define-constant ERR-ORACLE-PRICE-STALE (err u1006))
(define-constant ERR-MINIMUM-COLLATERAL-RATIO (err u1007))
(define-constant ERR-VAULT-ALREADY-EXISTS (err u1008))
(define-constant ERR-INSUFFICIENT-USDX-BALANCE (err u1009))
(define-constant ERR-TRANSFER-FAILED (err u1010))

;; Protocol Risk Parameters
(define-constant LIQUIDATION-RATIO u150) ;; 150% - liquidation threshold
(define-constant MINIMUM-COLLATERAL-RATIO u200) ;; 200% - minimum for new vaults
(define-constant LIQUIDATION-PENALTY u110) ;; 10% liquidation penalty
(define-constant STABILITY-FEE-RATE u2) ;; 2% annual stability fee
(define-constant MAX-PRICE-AGE u3600) ;; 1 hour max price age (in seconds)

;; DATA STRUCTURES AND MAPPINGS

;; Core Vault Data Structure
(define-map vaults
  { vault-id: uint }
  {
    owner: principal,
    stx-collateral: uint,
    xbtc-collateral: uint,
    debt: uint,
    last-update: uint,
    is-active: bool,
  }
)

;; User Vault Registry
(define-map user-vaults
  { user: principal }
  { vault-ids: (list 10 uint) }
)

;; Oracle Price Feed Registry
(define-map price-feeds
  { asset: (string-ascii 10) }
  {
    price: uint,
    timestamp: uint,
    confidence: uint,
  }
)

;; Protocol Global State Variables
(define-data-var total-vaults uint u0)
(define-data-var total-debt uint u0)
(define-data-var total-stx-collateral uint u0)
(define-data-var total-xbtc-collateral uint u0)
(define-data-var liquidation-pool uint u0)

;; Authorization Registries
(define-map authorized-liquidators
  principal
  bool
)
(define-map oracle-operators
  principal
  bool
)