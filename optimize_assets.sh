#!/bin/bash
# ASSET SHRINK RAY (MacOS Native)
# Role: Performance Optimization
# Dependencies: sips (Standard on macOS)

ASSET_DIR="./public/assets"
BACKUP_DIR="./public/assets_backup_$(date +%s)"

echo "--- 📉 INITIALIZING ASSET SHRINK RAY ---"
mkdir -p "$BACKUP_DIR"
echo "✅ Backup created at $BACKUP_DIR"

# Helper function to resize if file exists
optimize_image() {
    local file="$1"
    local max_width="$2"
    
    if [ -f "$ASSET_DIR/$file" ]; then
        echo "Processing $file ..."
        # Copy to backup first
        cp "$ASSET_DIR/$file" "$BACKUP_DIR/"
        
        # Resize and resample
        sips --resampleWidth "$max_width" "$ASSET_DIR/$file" --out "$ASSET_DIR/$file" > /dev/null
        
        # Get new size
        local size=$(ls -lh "$ASSET_DIR/$file" | awk '{print $5}')
        echo "   ↳ Optimized to: $size (Max Width: ${max_width}px)"
    else
        echo "⚠️  File $file not found, skipping."
    fi
}

# 1. CRITICAL: The "Heavy Hitters" (Currently ~5-6MB each)
# Reduced to 1000px width - sufficient for guides
optimize_image "GuideToUnlockingProof.png" 1000
optimize_image "GuideToUnlockingCrypto.png" 1000
optimize_image "four_pillars_diagramback.png" 1000
optimize_image "vault-bg.jpg" 1600  # Background needs slightly more detail

# 2. THE LOGO (Currently 4.5MB!)
# Reduced to 512px - more than enough for Retina displays
optimize_image "chip_icon.png" 512

# 3. OTHER ASSETS
optimize_image "guide_courier.png" 800
optimize_image "guide_invisible.png" 800

echo "--- 🏁 OPTIMIZATION COMPLETE ---"
echo "Run './gather_context.sh' again to verify the new file sizes."