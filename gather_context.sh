#!/bin/bash

# ==========================================
# MASTER CONTEXT GENERATOR
# Role: Application Architect Utility
# Purpose: Generate a complete state report of the codebase for AI auditing.
# ==========================================

OUTPUT_FILE="prooflock_context.txt"

# 1. Initialize and clean
echo "--- MASTER CONTEXT REPORT ---" > "$OUTPUT_FILE"
echo "Generated: $(date)" >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Function to append file content with a visual delimiter
append_file() {
    local filepath="$1"
    if [ -f "$filepath" ]; then
        echo "Processing: $filepath"
        echo "--------------------------------------------------" >> "$OUTPUT_FILE"
        echo "[FILE]: $filepath" >> "$OUTPUT_FILE"
        echo "--------------------------------------------------" >> "$OUTPUT_FILE"
        cat "$filepath" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
        echo "[END OF FILE: $filepath]" >> "$OUTPUT_FILE"
        echo "" >> "$OUTPUT_FILE"
    else
        echo "Warning: File $filepath not found (skipping)."
    fi
}

# 2. Project Root & Git Status
echo "Gathering System Status..."
echo "--- PROJECT ROOT ---" >> "$OUTPUT_FILE"
pwd >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

echo "--- GIT STATUS ---" >> "$OUTPUT_FILE"
git status >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 3. File Structure (Excluding noise)
echo "Mapping File Structure..."
echo "--- FILE STRUCTURE ---" >> "$OUTPUT_FILE"
# Find all files, excluding .git, node_modules, and DS_Store
find . -type f -not -path '*/.*' -not -path '*/node_modules/*' | sort >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# 4. Asset Analysis (Crucial for Mobile/Performance Audit)
echo "Analyzing Asset Weights..."
echo "--- ASSET SIZES (MB/KB) ---" >> "$OUTPUT_FILE"
# List file sizes in human readable format for assets folder
if [ -d "public/assets" ]; then
    ls -lh public/assets >> "$OUTPUT_FILE"
else
    echo "No assets directory found." >> "$OUTPUT_FILE"
fi
echo "" >> "$OUTPUT_FILE"

# 5. Configuration Files (The Backbone)
echo "Capturing Configuration..."
append_file "wrangler.json"
append_file "package.json"
append_file "tsconfig.json"
append_file "supabase/config.toml" # If exists

# 6. Frontend Source Code (The "Face")
echo "Capturing Frontend Code..."
# Loop through all HTML files in public
for f in public/*.html; do
    [ -e "$f" ] && append_file "$f"
done

# Loop through CSS/JS if they exist
for f in public/*.css; do
    [ -e "$f" ] && append_file "$f"
done
for f in public/*.js; do
    [ -e "$f" ] && append_file "$f"
done

# 7. Backend Logic (The "Brain")
echo "Capturing Backend Functions..."
# Capture the main logic of the send-certificate function
append_file "supabase/functions/send-certificate/index.ts"
# Capture any other TS files in functions
find supabase/functions -name "*.ts" -not -name "index.ts" | while read file; do
    append_file "$file"
done

echo "Context generation complete. Data saved to $OUTPUT_FILE"