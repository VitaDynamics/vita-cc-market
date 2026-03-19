#!/usr/bin/env python3
"""
Detects solution confirmation phrases in user prompts and injects a compound-docs
trigger instruction so Claude automatically documents the fix.

Hook event: UserPromptSubmit
"""
import json
import re
import sys

CONFIRMATION_PATTERNS = [
    r'\bthat worked\b',
    r"\bit'?s fixed\b",
    r'\bworking now\b',
    r'\bproblem solved\b',
    r'\bthat did it\b',
    r'\bfixed it\b',
    r'\bsolved it\b',
    r'\bresolved it\b',
    r'\ball (good|working)\b',
    r'\bperfect(ly)?\b.*\bwork',
]

data = json.load(sys.stdin)
prompt = data.get('prompt', '').lower()

if any(re.search(pattern, prompt) for pattern in CONFIRMATION_PATTERNS):
    print(json.dumps({
        "context": (
            "The user has just confirmed that a problem was solved or something is now working. "
            "Before responding, invoke the compound-docs skill to capture this solution as "
            "institutional knowledge. Only skip documentation if the fix was trivially obvious "
            "(e.g., a one-character typo)."
        )
    }))
