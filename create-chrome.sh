#!/bin/bash

PROFILE_NAME=$1

if [ -z $PROFILE_NAME ]; then
  >&2 echo "Must provide profile name as argument."
  exit
fi

mkdir -p "/Applications/Google Chrome $1.app/Contents/MacOS"

# F="/Applications/Google Chrome $1.app/Contents/MacOS/Google Chrome $1"
F="$HOME/Applications/Google Chrome $1"

cat > "$F" <<EOF
#!/bin/bash

#
# Google Chrome for Mac with additional profile.
#

# Name your profile:
EOF

echo "PROFILE_NAME='$PROFILE_NAME'\n" >> "$F"

cat >> "$F" <<EOF
# Store the profile here:
PROFILE_DIR="/Users/$USER/Library/Application Support/Google/Chrome/${PROFILE_NAME}"

# Find the Google Chrome binary:
CHROME_BIN="/Users/$USER/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
if [[ ! -e "\$CHROME_BIN" ]]; then
  CHROME_BIN="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
else
  echo "ERROR: Can not find Google Chrome.  Exiting."
  exit -1
fi

echo "PROFILE_DIR=\$PROFILE_DIR"

# Start me up!
exec "\$CHROME_BIN" --enable-udd-profiles --user-data-dir="\$PROFILE_DIR" &
EOF

sudo chmod +x "$F"
