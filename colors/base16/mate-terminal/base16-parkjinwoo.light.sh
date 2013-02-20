#!/usr/bin/env bash
# Base16 Parkjinwoo - Mate Terminal color scheme install script
# Park Jinwoo (https://github.com/parkjinwoo)

[[ -z "$PROFILE_NAME" ]] && PROFILE_NAME="Base 16 Parkjinwoo Light"
[[ -z "$PROFILE_SLUG" ]] && PROFILE_SLUG="base-16-parkjinwoo-light"
[[ -z "$DCONFTOOL" ]] && DCONFTOOL=dconf
[[ -z "$BASE_KEY" ]] && BASE_KEY=/org/mate/terminal/profiles

PROFILE_KEY="$BASE_KEY/$PROFILE_SLUG"

dset() {
  local key="$1"; shift
  local val="$1"; shift

  "$DCONFTOOL" write "$PROFILE_KEY/$key" "$val"
}

# Because gconftool doesn't have "append"
glist_append() {
  local key="$1"; shift
  local val="$1"; shift

  local entries="$(
    {
      "$DCONFTOOL" read "$key" | tr -d '[]' | tr , "\n" | fgrep -v "$val"
      echo "'$val'"
    } | head -c-1 | tr "\n" ,
  )"

  "$DCONFTOOL" write "$key" "[$entries]"
}

# Append the Base16 profile to the profile list
glist_append /org/mate/terminal/global/profile-list "$PROFILE_SLUG"

dset visible-name "'$PROFILE_NAME'"
dset palette "'#f8f8f8:#ba1820:#6fac24:#ffac30:#188cb5:#ac40a8:#40e894:#d0d0d0:#606060:#ba1820:#6fac24:#ffac30:#188cb5:#ac40a8:#40e894:#0d0d0d'"
dset background-color "'#f8f8f8'"
dset foreground-color "'#303030'"
dset bold-color "'#303030'"
dset bold-color-same-as-fg "true"
dset use-theme-colors "false"
dset use-theme-background "false"
