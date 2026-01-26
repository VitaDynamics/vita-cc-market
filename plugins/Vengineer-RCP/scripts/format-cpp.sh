#!/bin/bash

# Get the file path from the tool input
file_path=$(echo "$1" | jq -r '.tool_input.file_path // empty')

# Check if the file is a C++ file
if [[ "$file_path" =~ \.(hpp|cpp)$ ]]; then
    echo "Formatting C++ files..."
    find . \( -name '*.hpp' -o -name '*.cpp' \) -exec clang-format -i {} \;
    echo "C++ formatting complete"
else
    echo "Not a C++ file, skipping formatting"
fi