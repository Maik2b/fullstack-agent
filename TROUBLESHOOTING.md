# Troubleshooting

This file covers only the problems that live BETWEEN the pieces. Each piece owns its own deeper guide: `backtalk/TROUBLESHOOTING.md`, `barehands/TROUBLESHOOTING.md`, `ai-visualizer/TROUBLESHOOTING.md`.

## The install command opened Claude Code, but it acts like nothing's there

Then the download step failed before Claude Code started, and the error is in your terminal scrollback, right above where Claude opened. Type `/exit`, scroll up, and read it. On a Mac, a "developer tools" dialog may be waiting for an Open/Install click (that installs git; click Install and paste the command again). On Windows the command downloads a zip and needs no git, so a failure there is usually network. Fix what the message says, then paste the install command again.

## The face sits at idle while the voice talks

The wiring between them is two lines of config. Check both:

1. `ai-visualizer/ai-visualizer.json` should have `"bus_dir"` pointing at your backtalk folder.
2. Restart the visualizer server after any config change (Ctrl-C the stack, run start.sh again).

While the agent speaks, the backtalk folder should contain fresh `.voice_state` and `.voice_waveform` files. If they are not appearing, the problem is on the voice side; work backtalk's own guide.

## The greeting doesn't speak on launch

The greeting line lives in `backtalk/backtalk.json` under `"greeting"`. If it is missing or empty, the launch is silent by configuration. The voice piece itself failing to start is a different problem; its terminal output says why, and its guide covers the classics.

## start.sh says a piece is starting but nothing appears

- The face opens a browser tab automatically. If no tab appears, open `http://127.0.0.1:8790/` yourself.
- The hands never open a tab automatically (the camera page should be opened deliberately): `http://127.0.0.1:8794/` in Chrome.
- Two stacks can't run at once. If a port is already busy from an earlier session, Ctrl-C the old terminal or close it, then start again.

## My agent forgot who it is

Your agent's identity lives in the `CLAUDE.md` in your HOME folder (the folder containing all the tool folders), and Claude Code only reads it when you open Claude Code IN that folder. Opening Claude Code inside one of the tool subfolders boots the tool's own instructions instead. Daily habit: work from the home folder.

## I moved my agent folder somewhere else

Everything is wired with paths, so a move breaks the wires. Open Claude Code in the new location and say: "read fullstack-agent/fullstack-agent.md and re-run the wiring phase." Rewiring takes a minute and touches only the config paths.

## Updates

`./fullstack-agent/update.sh` pulls every piece. Your files (your CLAUDE.md, your vault, your notes) are never inside the repos' tracked files, so updates cannot touch them. If git complains about a config file you edited (backtalk.json, ai-visualizer.json), your edit wins; keep your version.
