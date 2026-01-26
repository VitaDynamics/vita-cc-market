#!/usr/bin/env bash
# Hook script to detect changes to context_keys.h in function_statemachine.
# When detected, reminds the developer to use the context-reviewer subagent.
# This runs as a Stop hook, checking git status for modified files.

set -euo pipefail

# Check git status for modified files
# Look for context_keys.h in function_statemachine among modified files
if git status --short 2>/dev/null | grep -q "function_statemachine.*context_keys.h\|context_keys.h.*function_statemachine"; then
    cat <<'EOF'
╔═══════════════════════════════════════════════════════════════╗
║  REMINDER: context_keys.h modified                            ║
╠═══════════════════════════════════════════════════════════════╣
║  You've modified context_keys.h in function_statemachine.     ║
║  If you are adding a new context key, consider to review it.  ║
║  Consider using the context-reviewer subagent to verify:      ║
║  - Proper enum definition and category placement              ║
║  - Setter/getter registration in correct file                 ║
║  - Type safety with safeconv::to<T>()                         ║
║  - Thread-safe implementation                                 ║
║                                                               ║
║  To invoke the reviewer:                                      ║
║  Use Task tool with subagent_type="context-reviewer"          ║
╚═══════════════════════════════════════════════════════════════╝
EOF
fi

exit 0
