---
description: Relationship between eDAO resource contracts and resources
---

# eDAO Entity Structure

Goal is to define relationships between company, resources, invoices etc within the eDAO structure. Following are key assumptions;

1. resources are managed by resource manager
2. resource manager is managed by eDAO

### Class Diagram

```mermaid
classDiagram
    governance-token --|> sip-10-trait
    governance-token --|> gov-token-trait
    governance-token --|> extension-trait
    dev-fund --|> extension-trait
    proposal-submission --|> extension-trait
    proposal-voting --|> extension-trait
    resource-manager --|> extension-trait
    resource-manager --|> resource-mgmt-trait
    resource-manager --|> invoice-trait
    class gov-token-trait{
        <<interface>>
    }
    class sip-10-trait{
        <<interface>>
    }
    class extension-trait{
        <<interface>>
        +callback()
    }
    class resource-mgmt-trait{
        <<interface>>
        +set-payment-address()
        +add-resource()
        +toggle-resource()
        +toggle-resource-by-name()
    }
    class invoice-trait{
        <<interface>>
        +pay-invoice()
        +pay-invoice-by-resource-name()
    }
    class executor-dao{
      +map executed-proposals
      +map extensions
      +construct()
      +execute()
      +request-extension-callback()
      +set-extension()
      +set-extensions()
      -is-self-or-extension()
    }
    class governance-token{
      +ft edg-token
      +ft edg-token-locked
      +ft token-name
      -is-dao-or-extension()
      +edg-transafer()
      +edg-lock()
      +edg-unlock()
      +edg-mint()
      +edg-burn()
    }
    class resource-manager{
      +var payment-address
      +var total-revenue
      +var invoice-count
      +var user-count
      +map UserData
      +map UserIndexes
      +map ResourceIndexes
      +map ResourceData
      +map InvoiceData
      +map RecentPayments
      +is-dao-or-extension()
      +set-payment-address()
      +add-resource()
      +toggle-resource()
      +toggle-resource-by-name()
      +pay-invoice()
      +pay-invoice-by-resource-name()
      +callback()
    }
    class proposal-voting{
      +var governance-token-principal
      +map proposals
      +map member-total-votes
      +vote()
      +conclude()
    }    
    class proposal-submission{
      +var governance-token-principal
      +map parameters
      +propose()
      +callback()
    }
```

