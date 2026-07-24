# Example: Design Gate card

## Design Gate

**Goal:** Add CSV export for the orders table  
**Success looks like:** User clicks Export and receives a CSV with the visible columns  
**Constraints / non-goals:** No Excel, no email delivery

### Approaches
1. Client-side CSV from current grid — fast, no pagination completeness  
2. Server endpoint streaming full filtered set — correct, more work  
3. Reuse existing report job — heavy ops coupling  

**Recommendation:** 2 for correctness if filters can exceed one page  

### Proposed design
- Scope: GET /orders/export.csv respecting current filters  
- Touch points: orders handler, query builder, UI button  
- Risks: large exports / timeouts  

Approve this design?
