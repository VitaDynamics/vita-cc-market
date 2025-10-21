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

### 1. Update ROS2 Message Definition
- Edit the appropriate `.msg` file in `src/application/function_statemachine/msg/`
- Add new field with correct data type and descriptive comment

### 2. Rebuild Messages
```bash
build_msgs
```

### 3. Add Enum Key
- Update `context_keys.h` with new enum entry in appropriate section (Function/DAG/System)
- Follow naming convention: `CONTEXT_KEY_<MODULE>_<NAME>`

### 4. Register Lambda Function
- Edit appropriate `*_registration.cpp` file based on key type
- Implement getter/setter lambda with proper type casting
- Ensure thread-safe access to underlying data structure

### 5. Update Aggregation (if new module)
- If adding first key from new module, update `context_registrations.h`
- Include new registration header and call registration function

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