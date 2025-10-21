---
description: Add a New Context Key to the Function State Machine. Specify the context key name and description.
---

User Input: #$ARGUMENTS to acknowledge you.

## Overview
Work in `src/application/function_statemachine` to add new context keys following the established workflow.

## Documentation References
- **Complete Workflow Guide**: See @src/application/function_statemachine/docs/function_developer/add_context.md
- **Test and Build Guide**: See @src/application/function_statemachine/docs/how_to_test.md

## Required Information (Ask User First)

Before proceeding, clarify the following with the user:

1. **Context Key Name**: What is the name of the context key? (e.g., `vehicle_speed`, `battery_level`)
2. **Context Key Description**: Provide a clear description of what this context key represents and its purpose in the system
3. **Identify the Key Type**: What is the type of the context key?
   - **Function**: Keys related to specific function execution and state
   - **DAG**: Keys related to directed acyclic graph workflow management
   - **System**: Keys related to system-level information and resources
   
   **Important**: Each key can belong to only ONE type. Choose the most appropriate category.

4. **Data Type**: What is the underlying data type? (e.g., `float`, `int32_t`, `bool`, `std::string`, custom struct)
5. **Default Value**: What should be the initial/default value for this context key?
6. **Update Frequency**: How often will this key be updated? (e.g., every cycle, on-demand, event-driven)

## Implementation Checklist

Adding new context keys involves the following steps:

[] Message file has been updated
[] Enum value has been correctly defined in context_keys.h
[] Setter has been registered in corresponding registration file
[] Use safeconv::to<T>() for type conversion
[] Documentation has been updated
[] Compilation test passes in the context part of the Robot Context Protocol (FSM) component

Adding a new module
[] Create *Status.msg file
[] Add module reference in FunctionStatus.msg
[] Add all field enums in context_keys.h
[] Create *_context_registration.{h,cpp} file
[] Include and register call in context_registrations.h
[] Add module state member in state_aggregator.h
[] Compilation test passes in the fsm part of the Robot Context Protocol (FSM) component

### 6. Rebuild Context System


## Key Principles

- **Compile-time type safety**: Enum-based keys prevent runtime string errors
- **Zero-overhead publishing**: Direct struct access without serialization overhead
- **Modular registration**: Each module self-contained with clear boundaries
- **Thread-safe by design**: Mutex protection in ContextManager for all operations
- **Clear separation of concerns**: Storage (messages) vs. registration (lambdas) vs. API (manager)
- **Documentation first**: Always document the purpose and usage of new context keys

## Common Pitfalls to Avoid

- ❌ Forgetting to rebuild messages after `.msg` changes
- ❌ Mismatched data types between message definition and lambda casting
- ❌ Missing mutex locks in custom getter/setter implementations
- ❌ Adding keys without proper documentation
- ❌ Placing keys in wrong type category (Function/DAG/System)

Following this guide ensures your new context keys integrate seamlessly with the existing system architecture while maintaining performance, safety, and maintainability.