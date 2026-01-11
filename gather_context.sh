#!/bin/bash
# --- MASTER CONTEXT GENERATOR v2.0 (Architect Edition) ---
# Purpose: Generate a comprehensive audit of project state, assets, and Supabase dependencies.

REPORT_FILE="prooflock_context.txt"
TIMESTAMP=$(date)

echo "--- MASTER CONTEXT REPORT ---" > $REPORT_FILE
echo "Generated: $TIMESTAMP" >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- PROJECT ROOT ---" >> $REPORT_FILE
pwd >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- GIT STATUS ---" >> $REPORT_FILE
git status >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- FILE STRUCTURE ---" >> $REPORT_FILE
find . -maxdepth 3 -not -path '*/.*' >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- ASSET SIZES (MB/KB) ---" >> $REPORT_FILE
ls -lh public/assets >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "--- SUPABASE & SCHEMA AUDIT ---" >> $REPORT_FILE
echo "[Checking frontend for DB dependencies]" >> $REPORT_FILE
grep -rnE "from\('|select\('|rpc\(" ./public >> $REPORT_FILE
echo "" >> $REPORT_FILE

echo "[Auditing RLS & Schema Definitions in Migrations]" >> $REPORT_FILE
if [ -d "./supabase/migrations" ]; then
    grep -rnE "CREATE POLICY|ALTER TABLE|ENABLE ROW LEVEL SECURITY" ./supabase/migrations >> $REPORT_FILE
else
    echo "No local migrations found; direct DB check required." >> $REPORT_FILE
fi
echo "" >> $REPORT_FILE

echo "--- CONFIGURATION FILES ---" >> $REPORT_FILE
for f in wrangler.json package.json; do
    if [ -f "$f" ]; then
        echo "[FILE]: $f" >> $REPORT_FILE
        cat "$f" >> $REPORT_FILE
        echo "[END OF FILE: $f]" >> $REPORT_FILE
    fi
done

echo "--- CRITICAL SOURCE FILES ---" >> $REPORT_FILE
# Adding key logic files for LLM context
FILES_TO_INCLUDE=("public/index.html" "public/verify.html" "public/support.html" "public/decrypt.html")
for f in "${FILES_TO_INCLUDE[@]}"; do
    if [ -f "$f" ]; then
        echo "[FILE]: $f" >> $REPORT_FILE
        cat "$f" >> $REPORT_FILE
        echo "[END OF FILE: $f]" >> $REPORT_FILE
    fi
done

echo "Context Report Updated: $REPORT_FILE"