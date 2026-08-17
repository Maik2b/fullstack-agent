@echo off
rem fullstack-agent: give your AI a full stack — memory, voice, face, hands.
rem Copyright (C) 2026 Jared Rhodenizer
rem
rem This program is free software: you can redistribute it and/or modify
rem it under the terms of the GNU Affero General Public License as published
rem by the Free Software Foundation, either version 3 of the License, or
rem (at your option) any later version.
rem
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
rem GNU Affero General Public License for more details.
rem
rem You should have received a copy of the GNU Affero General Public License
rem along with this program. If not, see <https://www.gnu.org/licenses/>.
rem
rem SPDX-License-Identifier: AGPL-3.0-or-later

rem Pulls the newest version of every installed piece, and of this repo.
rem Your files live outside the repos, so updates never touch them. If git
rem reports a conflict on a config you edited, your edit wins.

cd /d "%~dp0.."
for %%r in (fullstack-agent ai-memory-vault backtalk barehands ai-visualizer) do (
  if exist "%%r\.git\" (
    echo == %%r
    git -C "%%r" pull --ff-only
  )
)
echo update complete.
