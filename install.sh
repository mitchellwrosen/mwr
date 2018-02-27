#!/usr/bin/env sh

GIT_PATH="$(git rev-parse --show-toplevel)"
GIT_PATH="$(cd $GIT_PATH && pwd -P)"
GIT_REPO="$(git config --local remote.origin.url | sed -E 's/.*[:/](.*)\.git/\1/')"
FLAGS="$1"
LN_FLAGS=""
case "$FLAGS" in
  "")
    LN_FLAGS="-s"
    ;;
  "--force"|"-f")
    LN_FLAGS="-fs"
    ;;
  "--help"|"-h"|*)
    echo "./install.sh"
    echo ""
    echo "Symlink the mwr files to your ~/.local/bin/ folder."
    echo ""
    echo "OPTIONS:"
    echo "  -f --force    Create symlink with 'ln -fs' (otherwise 'ln -s')"
    echo "  -h --help     Show this text"
    ;;
esac

if [[ "$GIT_PATH" != "$(pwd -P)" ]] || [[ "$GIT_REPO" != "mwr" ]]; then
  echo "can't install symlink when not in the root directory of the mwr project"
  exit 1
else
  ln $LN_FLAGS $PWD/mwr       $HOME/.local/bin/mwr
  ln $LN_FLAGS $PWD/mwr-stack $HOME/.local/bin/mwr-stack
  ln $LN_FLAGS $PWD/mwr-cabal $HOME/.local/bin/mwr-cabal
  exit 0
fi

