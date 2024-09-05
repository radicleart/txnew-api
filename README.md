# aiflow

## Introduction

AI Flow supports tasks in the CrewAI + DAO + Resource Contracts application space;

See also;

- [stxeco-launcher](https://github.com/radicleart/stxeco-launcher)
- [ai-flow](https://github.com/radicleart/ai-flow)
- [bitcoin-dao](https://github.com/radicleart/bitcoin-dao)

Note: this is experimental code - use at your own risk

### 1 DAO Launcher

The script runs in same directory as the calling code.

```rest
POST /dao-launcher/v1/launch  # body = template:DaoTemplate
```

### 2 Datasets

AI Flow hooks onto to a Stacks (or Bitcoin) full, pulls any or all blocks of transaction data and flattens the data into classification formatted jsonl files (one per block).

```rest
GET /datasets/v1/transactions/:block  # flattens given block
GET /datasets/v1/transactions/latest  # flattens new blocks since last run
GET /datasets/v1/transactions         # flattens new blocks (skips previously flattened blocks)
```

The classification data has the format;

```ts
interface FlattenedStacksTransaction {
  transaction_id: string;
  sender_address:string;
  nonce:number;
  sponsored:boolean;
  fee_rate:number;
  status: string;
  type: string;
  index: number;
  burn_block_time: number;
  parent_burn_block_time: number;
  block_time: number;
  block_height:number;
  post_condition_mode: string;

  recipient_address?: string;
  
  token_transfer_amount?: number;
  token_transfer_memo?: string;

  coinbase_alt_recipient?: string;
  coinbase_data?: string;

  contract_address?: string;
  contract_name?: string;
  function_name?: string;
  function_signature?: string;
  function_args_repr?: string;
  function_args_type?: string;

  smart_contract_clarity_version?:string;
  smart_contract_contract_address?:string;
  smart_contract_contract_name?:string;
  smart_contract_source_code?:string;
}
```

## Development

Services can be run either via rest or cli.

### Build

```bash
npm install
npm run build
```

### Develop

```bash
npm install
npm run dev
```

### Command Line

Note: this isn't yet fully supported but here for future flexibility

```bash
npm install
npm run cli -- datasets transactions latest // from current tip height to last saved block
npm run cli -- datasets transactions n // block n
npm run cli -- datasets transactions all // all (skips already flattened blocks)
```

### Mongo

Connects to Mongo Cloud development db instance using environment variables see Environment secton.

Local IP address has to be added to Mongo Cloud allowed network - contact system administrator.

## Test

Tests outstanding,

```bash
npm run test
```

## Deploy

run deploy script to build / push docker image then on target server run following;

```bash
# stag
docker rm -f aiflow_api_production
docker run -d -t -i --network host --name aiflow_api_production -p 6060:6060 -e NODE_ENV='linode-production' mijoco/aiflow_api
```
