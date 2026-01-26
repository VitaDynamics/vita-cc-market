#!/usr/bin/env bash
# Hook script to detect changes to traits.h in function_statemachine.
# When detected, reminds the developer to use the function-reviewer and test-case-writer subagents.
# This runs as a Stop hook, checking git status for modified files.

set -euo pipefail

# Check git status for modified files
# Look for traits.h in function_statemachine among modified files
if git status --short 2>/dev/null | grep -q "function_statemachine.*traits.h\|traits.h.*function_statemachine"; then
    cat <<'EOF'
╔═══════════════════════════════════════════════════════════════╗
║  REMINDER: traits.h modified                                  ║
╠═══════════════════════════════════════════════════════════════╣
║  You've modified traits.h in function_statemachine.           ║
║  If you are adding a new function, consider to review it.     ║
║                                                                ║
║  1️⃣  Use function-reviewer subagent to verify implementation: ║
║     - Parameter header properly included                      ║
║     - Include path is correct                                 ║
║     - No include guard conflicts                              ║
║     - Function catalog entry exists                           ║
║     - Rule configuration is complete                          ║
║     - Compilation successful                                  ║
║                                                                ║
║     To invoke: Task tool with subagent_type="function-reviewer"
║                                                                ║
║  2️⃣  Use function-test-case-writer to create tests:           ║
║     - Update mock function node                               ║
║     - Write test cases                                        ║
║     - Guide interactive testing                               ║
║                                                                ║
║     To invoke: Task tool with subagent_type="function-test-case-writer"
╚═══════════════════════════════════════════════════════════════╝
EOF
fi

exit 0
