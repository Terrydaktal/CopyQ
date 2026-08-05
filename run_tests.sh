#!/bin/bash
export COPYQ_SESSION_NAME="test"
export COPYQ_SETTINGS_PATH="build/copyq-test-conf"
export COPYQ_ITEM_DATA_PATH="build/copyq-test-data"
export COPYQ_PLUGINS=""
export COPYQ_DEFAULT_ICON="1"
export COPYQ_SESSION_COLOR="#f90"
export COPYQ_THEME_PREFIX="$PWD/shared/themes"
export COPYQ_PASSWORD="TEST123"
export COPYQ_LOG_LEVEL="DEBUG"
export QT_LOGGING_RULES="*.debug=true;qt.*.debug=false"
export QT_QPA_PLATFORM="xcb"

mkdir -p "$COPYQ_SETTINGS_PATH" "$COPYQ_ITEM_DATA_PATH"

# Run Xvfb in background
Xvfb :99 -screen 0 1024x768x24 &
XVFB_PID=$!
export DISPLAY=:99

sleep 2

# Run openbox in background
openbox &
OPENBOX_PID=$!

sleep 2

# Run tests
build/copyq-tests "$@"
EXIT_CODE=$?

# Cleanup
kill $OPENBOX_PID
kill $XVFB_PID
wait $XVFB_PID 2>/dev/null

exit $EXIT_CODE
