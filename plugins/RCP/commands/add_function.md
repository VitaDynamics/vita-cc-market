---
description: Add a New Function Or Service. You should mention the message/service interface you have. You Context Keys Needed to Cumtomize and Registration Needed to Customized. 
---

User Input: #$ARGUMENTS to acknowledge you.

# Add Function or Service to Function State Machine

## Overview
Work in `src/application/function_statemachine` to add new functions following the established workflow.

## Documentation References
- **Complete Workflow Guide**: See @src/application/function_statemachine/docs/function_developer/add_function.md
- **Context Add**: See @src/application/function_statemachine/docs/function_developer/add_context.md'
- **Testing Guide**: See @src/application/function_statemachine/docs/how_to_test.md

## Required Information (Ask User First)

Before proceeding, clarify the following with the user:

1. **Context Keys**: What special context keys are required for this functionality?
2. **Serialization**: Does this require custom `ToJson`, `FromJson`, and `Validation` methods, or can it use automatic macro implementation?
3. **Blocking Configuration**: Does this need dynamic blocking configuration?
4. **Interface Details**: What is the exact message/service interface (topic name, message type, request/response types)?

## Implementation Checklist

After completing the workflow, verify all steps:

- [ ] **Step 1**: Create parameter structure in `parameters/<name>.h`
- [ ] **Step 2**: Add context keys to `context/context_keys.h`
- [ ] **Step 3**: Add directory entry to `function_catalog.def`
- [ ] **Step 4**: Include parameter header file in `traits.h`
- [ ] **Step 5**: Create rule YAML in `config/rules/<name>.yaml`
- [ ] **Step 6**: Add function configuration to `config/nodes/function_statemachine.yaml`
- [ ] **Step 7**: Verify compilation successful (X-macros generate code correctly)

## Notes
- Ensure all context keys are properly registered before use
- Follow existing naming conventions in the codebase
- Test thoroughly using the testing guide after implementation
