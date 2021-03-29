#!/bin/sh
echo "Starting Octant docker container"

server=https://kubernetes.default.svc:443

OCTANT_HTTP_PORT=${OCTANT_HTTP_PORT:-8000}
OCTANT_PLUGINS_DIR=${OCTANT_PLUGINS_DIR%/}
OCTANT_PLUGINS_DIR=${OCTANT_PLUGINS_DIR:-/home/octant/.config/octant/plugins}

if [[ "${OCTANT_PLUGINS_DIR}" != "${HOME}/.config/octant/plugins" ]]; then
  echo "Adding ${OCTANT_PLUGINS_DIR} to plugins dir because it is different than ${HOME}/.config/octant/plugins"
  ADDITIONAL_OCTANT_ARGUMENT="--plugin-path ${OCTANT_PLUGINS_DIR}"
fi

echo "Launching the Octant process (as $(whoami) user):"
exec /opt/octant $ADDITIONAL_OCTANT_ARGUMENT --disable-open-browser --listener-addr 0.0.0.0:${OCTANT_HTTP_PORT}
