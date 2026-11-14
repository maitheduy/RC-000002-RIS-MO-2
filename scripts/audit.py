"""Reject proof holes and user-declared axioms in the RC source."""
from pathlib import Path
import re
root = Path(__file__).resolve().parents[1]
files = [root / 'RC000002.lean', *sorted((root / 'RC000002').glob('*.lean'))]
for p in files:
    text = p.read_text()
    # This source has no nested comments. Remove comments before token checks.
    text = re.sub(r'/\-.*?\-/', '', text, flags=re.S)
    text = re.sub(r'--[^\n]*', '', text)
    forbidden = re.findall(r'\b(?:sorry|admit|axiom|unsafe)\b|native_decide|implemented_by', text)
    if forbidden:
        raise SystemExit(f'{p.name}: forbidden tokens: {forbidden}')
print(f'PASS: {len(files)} Lean sources contain no proof holes, declared axioms, or native_decide.')
