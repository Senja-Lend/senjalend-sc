# Senja Lend

**The first permissionless crosschain lending and borrowing protocol built on the Base ecosystem.**

Senja is a decentralized lending protocol that enables users to supply liquidity, borrow assets, and manage collateralized positions across multiple blockchains through LayerZero's cross-chain infrastructure.

## 🌟 Features

### Core Functionality
- **Permissionless Lending & Borrowing**: Create lending pools for any supported token pair
- **Cross-Chain Operations**: Seamless asset transfers across different blockchains via LayerZero
- **Dynamic Interest Rates**: Adaptive interest rate models based on utilization
- **Flexible Collateral Management**: Support for multiple collateral types
- **Automated Liquidation**: MEV-friendly liquidation mechanisms with incentives
- **Position Management**: Individual position contracts for each user

### Advanced Features
- **Token Swapping**: Built-in DEX integration with Uniswap for position management
- **Oracle Integration**: Real-time price feeds for accurate asset valuations
- **Base Buyback System**: 95% of revenue automatically buys Base to increase ecosystem TVL (Coming Soon)
- **Protocol Fee Management**: Automated fee collection and revenue distribution
- **Upgradeable Architecture**: UUPS proxy pattern for seamless upgrades
- **Access Control**: Role-based permissions for protocol management
- **Ecosystem Growth**: Self-sustaining mechanism that strengthens Base ecosystem

## 🏗️ Architecture

### Core Contracts

#### LendingPoolFactory
- **Purpose**: Main factory contract for creating and managing lending pools
- **Features**: Pool creation, operator management, token data stream configuration
- **Upgradeable**: Yes (UUPS pattern)

#### LendingPool
- **Purpose**: Individual lending pool for specific token pairs
- **Features**: Supply/withdraw liquidity, borrow/repay assets, cross-chain transfers
- **Integration**: LayerZero for cross-chain operations

#### Position
- **Purpose**: Individual user position management
- **Features**: Collateral management, token swapping, repayment flexibility
- **Security**: Reentrancy protection, access control

#### Protocol
- **Purpose**: Protocol-level fee management and Base ecosystem buyback operations
- **Features**: Fee collection, automated Base buybacks (Coming Soon), revenue distribution
- **Integration**: Uniswap for token swaps, 95% revenue → Base buyback (Coming Soon)
- **Ecosystem Impact**: Increases Base TVL and creates sustainable growth

### Supporting Contracts

- **IsHealthy**: Health check system for position validation
- **Liquidator**: Automated liquidation mechanisms
- **Oracle**: Price feed integration
- **LendingPoolRouter**: Interest rate calculations and pool management
- **PositionDeployer**: Factory for creating user positions

## 🚀 Getting Started

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)
- Node.js and pnpm
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/your-org/senja-contract.git
cd senja-contract

# Install dependencies
forge install

# Install Node.js dependencies
pnpm install
```

### Build

```bash
forge build
```

### Test

```bash
# Run all tests
forge test

# Run specific test file
forge test --match-contract SenjaTest -vvv

# Run with gas reporting
forge test --gas-report
```

## 📋 Usage

### Creating a Lending Pool

```solidity
// Deploy a new lending pool
address lendingPool = lendingPoolFactory.createLendingPool(
    collateralToken,  // Address of collateral token
    borrowToken,      // Address of borrow token  
    ltv              // Loan-to-Value ratio (in basis points)
);
```

### Supplying Liquidity

```solidity
// Supply liquidity to earn interest
lendingPool.supplyLiquidity{value: amount}(user, amount);
```

### Borrowing Assets

```solidity
// Borrow assets (can be cross-chain)
lendingPool.borrowDebt{value: fee}(
    amount,                    // Amount to borrow
    destinationChainId,        // Target chain ID
    dstEid,                   // LayerZero endpoint ID
    addExecutorLzReceiveOption // Execution options
);
```

### Managing Positions

```solidity
// Supply collateral
lendingPool.supplyCollateral{value: amount}(amount, user);

// Withdraw collateral
lendingPool.withdrawCollateral(amount);

// Repay with selected token
lendingPool.repayWithSelectedToken(
    shares,           // Borrow shares to repay
    token,           // Token to use for repayment
    fromPosition,    // Use position tokens
    user,            // User address
    slippageTolerance // Slippage protection
);
```

## 🔧 Configuration

### Supported Networks

- **Base Mainnet**: Primary deployment network
- **Arbitrum One**: Cross-chain support
- **Ethereum Mainnet**: Coming Soon
- **Optimism**: ComingSoon
- **HyperEVM**: Coming Soon

### Token Support

- **Native Base**: Wrapped as WETH for protocol operations
- **ERC-20 Tokens**: Any standard ERC-20 token
- **Cross-Chain Tokens**: LayerZero OFT tokens

### Oracle Integration

The protocol integrates with oracle providers:
- **Chainlink**: Primary price feed provider

## 🛡️ Security

### Audit Status
- **Internal Review**: Completed
- **External Audit**: Pending
- **Bug Bounty**: Coming soon

### Security Features
- **Reentrancy Protection**: All critical functions protected
- **Access Control**: Role-based permissions
- **Slippage Protection**: Built-in slippage controls
- **Health Checks**: Automated position validation
- **Upgrade Safety**: UUPS pattern with proper authorization

## 📊 Protocol Economics

### Fee Structure
- **Protocol Fee**: 0.1% of borrow amount
- **Liquidation Incentive**: 5-10% (configurable)
- **Cross-Chain Fee**: LayerZero messaging fees

### Revenue Distribution & Base Buyback Mechanism
- **Base Buyback (Coming Soon)**: 95% of protocol revenue is used to buy Base tokens
- **Developer Fund**: 5% allocated for development and operational expenses

### Base Ecosystem Growth Strategy

The Senja protocol implements a unique buyback mechanism designed to strengthen the Base ecosystem:

#### Buyback Purpose
- **TVL Growth**: 95% of protocol revenue is used to purchase Base tokens (Coming Soon), increasing the total value locked (TVL) in the Base ecosystem
- **Token Scarcity**: Regular buybacks create upward pressure on Base token price
- **Ecosystem Sustainability**: Reinvesting revenue back into the native token creates a sustainable growth cycle
- **Community Value**: Long-term holders benefit from the protocol's success through increased Base value

#### Buyback Mechanism (Coming Soon)
1. **Revenue Collection**: Protocol fees are collected in various tokens
2. **Token Swapping**: Collected tokens are swapped to Base via Uniswap
3. **Distribution**: 
   - 95% of Base is locked in the protocol treasury (increasing ecosystem TVL)
   - 5% of Base is available for developer operations
4. **Transparency**: All buyback transactions are recorded on-chain and publicly verifiable

#### Benefits for Base Ecosystem
- **Increased Demand**: Regular Base purchases create consistent demand
- **Reduced Supply**: Locked Base tokens reduce circulating supply
- **Ecosystem Value**: Higher Base value attracts more developers and users
- **Sustainable Growth**: Self-reinforcing mechanism that grows with protocol adoption

## 🔄 Cross-Chain Operations

Senja leverages LayerZero's infrastructure for seamless cross-chain operations:

### Supported Chains
- Base (Primary)
- Arbitrum
- Ethereum Mainnet (Coming Soon)
- Optimism (Coming Soon)
- HyperEVM (Coming Soon)

### Cross-Chain Features
- **Borrow on Any Chain**: Borrow assets on any supported network
- **Collateral Management**: Manage collateral across chains
- **Liquidation**: Cross-chain liquidation capabilities

## 🧪 Testing

### Test Coverage
- **Unit Tests**: Core functionality testing
- **Integration Tests**: Cross-contract interaction testing
- **Fuzz Testing**: Edge case validation
- **Gas Optimization**: Gas usage analysis

### Running Tests

```bash
# Run all tests
forge test

# Run with detailed output
forge test -vvv

# Run specific test
forge test --match-test testSupplyLiquidity

# Run with gas reporting
forge test --gas-report
```

## 📈 Monitoring

### Events
The protocol emits comprehensive events for monitoring:
- `SupplyLiquidity`: When users supply liquidity
- `WithdrawLiquidity`: When users withdraw liquidity
- `BorrowDebtCrosschain`: When users borrow assets
- `RepayByPosition`: When users repay loans
- `Liquidate`: When positions are liquidated

### Analytics
- **TVL Tracking**: Total Value Locked monitoring
- **Utilization Rates**: Pool utilization analytics
- **Interest Rates**: Dynamic rate tracking
- **Liquidation Events**: Liquidation monitoring

### Development Setup

```bash
# Install dependencies
forge install
pnpm install

# Run tests
forge test

# Format code
forge fmt

# Lint code
forge lint
```

## 🔗 Links

- **Website**: https://base.senja.finance/
- **Farcaster Mini App**: https://farcaster.xyz/miniapps/loZN-y-IJM1t/senja
- **Dune Analytics**: https://dune.com/danu_/senja-base
- **GitHub Repo**: https://github.com/Senja-Lend
- **X (Twitter)**: https://x.com/senjalend
- **Docs**: https://senja-lend.gitbook.io/senja-lend-docs/
- **Demo Video**: https://youtu.be/H5bxlXstzEg

## 📞 Support

For support and questions:
- **Email**: ghoza60@gmail.com (Smart Contract Engineer)

---

**Built with 💙 for the Base ecosystem**
