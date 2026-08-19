#!/bin/bash
# fullstack-agent: give your AI a full stack — memory, voice, face, hands.
# Copyright (C) 2026 Jared Rhodenizer
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
# SPDX-License-Identifier: AGPL-3.0-or-later

# Pulls the newest version of every installed piece, and of this repo.
# Your own files (your CLAUDE.md, your vault, your configs) live outside
# the repos' tracked files, so updates never touch them. If git reports
# a conflict on a config you edited, your edit wins; keep your version.

HERE="$(cd "$(dirname "$0")" && pwd)"
HOME_DIR="$(dirname "$HERE")"

for repo in fullstack-agent ai-memory-vault backtalk barehands ai-visualizer; do
  if [ -d "$HOME_DIR/$repo/.git" ]; then
    echo "== $repo"
    # show what is arriving BEFORE applying it, so "what changed?"
    # answers itself on every update
    git -C "$HOME_DIR/$repo" fetch -q origin 2>/dev/null
    git -C "$HOME_DIR/$repo" log --oneline "..@{u}" 2>/dev/null | sed "s/^/   new: /"
    git -C "$HOME_DIR/$repo" pull --ff-only || \
      echo "   (couldn't fast-forward; your local edits win. See the note at the top of this script.)"
  fi
done
echo "update complete."
