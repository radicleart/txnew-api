---
description: Relationship between eDAO resource contracts and resources
---

# eDAO Sequence Diagrams

Defines the flows (at contract level) which enact the use cases.

### Manage Resources

````mermaid
# Sequence Diagram 1

```mermaid
sequenceDiagram
    resource manager->>resources: add-resource
    resources-->>resource manager: response
```
````

#### Add resource

```mermaid
sequenceDiagram
    resource manager->>resources: add-resource
    resources-->>resource manager: response
```

#### Toggle resource

```mermaid
sequenceDiagram
    resource manager->>resources: toggle-resource
    resources-->>resource manager: response

```

### Make Payments

#### Purchase governance token

````mermaid
```mermaid
sequenceDiagram
    user->>resources: pay invoice
    resources-->>treasury1: transfer(25%)
    resources-->>treasury2: transfer(75%)
    resources-->>user: governance-token 
```
````

#### Claim dividend

```mermaid
sequenceDiagram
    user->>treasury2: claim
    treasury2-->>user: dividend
```







