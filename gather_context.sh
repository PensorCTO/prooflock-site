#!/bin/bash
OUTPUT="prooflock_context.txt"
echo "generating context file at $OUTPUT..."

echo "--- PROJECT ROOT ---" > $OUTPUT
pwd >> $OUTPUT; echo "" >> $OUTPUT

echo "--- GIT STATUS ---" >> $OUTPUT
git status >> $OUTPUT; echo "" >> $OUTPUT

echo "--- FILE STRUCTURE ---" >> $OUTPUT
if command -v tree &> /dev/null; then
    tree -I 'node_modules|dist|build|.git|.next|coverage' >> $OUTPUT
else
    find . -maxdepth 3 -not -path '*/.*' -not -path './node_modules*' -not -path './dist*' -not -path './build*' >> $OUTPUT
fi
echo "" >> $OUTPUT

echo "--- CONFIGURATION FILES ---" >> $OUTPUT
for file in package.json tsconfig.json next.config.js vite.config.js webpack.config.js tailwind.config.js composer.json requirements.txt; do
    if [ -f "$file" ]; then
        echo "Found $file:" >> $OUTPUT
        echo "--------------------------------" >> $OUTPUT
        cat "$file" >> $OUTPUT
        echo -e "\n--------------------------------\n" >> $OUTPUT
    fi
done

echo "--- ENTRY POINTS ---" >> $OUTPUT
for file in src/index.js src/main.js src/index.tsx src/main.tsx pages/index.js pages/index.tsx index.html app/page.tsx; do
    if [ -f "$file" ]; then
        echo "Found Entry File $file (First 50 lines):" >> $OUTPUT
        echo "--------------------------------" >> $OUTPUT
        head -n 50 "$file" >> $OUTPUT
        echo -e "\n--------------------------------\n" >> $OUTPUT
    fi
done
