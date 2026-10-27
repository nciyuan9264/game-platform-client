#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSPACE="$(cd "$ROOT/.." && pwd)"
PAM_IDL_ROOT="${PAM_IDL_ROOT:-$WORKSPACE/pam-idl}"
KITEX_BIN="${KITEX_BIN:-$WORKSPACE/.tools/bin/kitex}"

if [[ ! -x "$KITEX_BIN" ]]; then
  echo "kitex binary not found: $KITEX_BIN" >&2
  exit 1
fi

idl="$PAM_IDL_ROOT/idl/game_platform/v1/service.thrift"
if [[ ! -f "$idl" ]]; then
  echo "PAM IDL not found: $idl" >&2
  exit 1
fi

cd "$ROOT"
"$KITEX_BIN" \
  -module github.com/nciyuan9264/game-platform-client \
  -I "$PAM_IDL_ROOT/idl" \
  "$idl"

sed -i '/"ServiceFilePath":/d' \
  kitex_gen/pam/game/platform/v1/gameplatformservice/gameplatformservice.go
find kitex_gen/pam/game/platform/v1 -name '*-reflection.go' -exec \
  sed -i -E 's#^// IDL Path: .*/idl/#// IDL Path: #' {} +
gofmt -w kitex_gen/pam/game/platform/v1
go mod tidy
