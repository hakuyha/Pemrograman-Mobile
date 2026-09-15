---
name: anti-slop
description: >-
  Enforces anti-slop standards across code, responses, and designs. Eliminates AI boilerplate, placeholder comments, redundant explanations, and low-quality code patterns.
---

# Anti-Slop Skill

Apply rigorous quality filters to all AI-generated code, text, and architectural decisions.

## Execution Checklist

1. **Review Code Density & Completeness**:
   - Check that all implementations are concrete and fully functioning.
   - Remove any lazy placeholders (`// TODO: implement later`, empty handlers).
   - Strip redundant comments that merely mirror code operations.

2. **Refine Architecture**:
   - Keep solutions simple and idiomatic; do not add unnecessary layers of abstraction.
   - Match existing project architecture, conventions, and style guides.

3. **Validate & Test**:
   - Run static analysis or compiler checks to ensure zero new lints or errors.
   - Test edge cases and handle failure modes explicitly.

4. **Streamline Communication**:
   - Provide concise, fact-based answers with minimal overhead.
