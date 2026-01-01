#!/usr/bin/env bash

OUTPUT="README.md"

# Remove the previous file
rm -rf "$OUTPUT"

IMAGES=(wall-*.jpg wall-*.png)
COLS=3
WIDTH=300

cat >"$OUTPUT" <<EOF
# Wallpapers

<table>
EOF

count=0

for img in "${IMAGES[@]}"; do
  [ -f "$img" ] || continue

  if ((count % COLS == 0)); then
    echo "  <tr>" >>"$OUTPUT"
  fi

  cat >>"$OUTPUT" <<EOF
    <td align="center">
      <a href="$img">
        <img src="$img" width="$WIDTH">
      </a>
    </td>
EOF

  ((count++))

  if ((count % COLS == 0)); then
    echo "  </tr>" >>"$OUTPUT"
  fi
done

# Close last row if needed
if ((count % COLS != 0)); then
  echo "  </tr>" >>"$OUTPUT"
fi

echo "</table>" >>"$OUTPUT"
echo "# NOTE" >>"$OUTPUT"
echo "- These are not my creation by any means" >>"$OUTPUT"

echo "README.md gallery generated ✔"
