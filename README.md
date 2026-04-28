# lose_law

> ***Software engineering has laws. Most teams relearn them the hard way.***

`lose_law` is a tiny terminal command that prints one random Law of Software Engineering. The laws come from [lawsofsoftwareengineering.com](https://lawsofsoftwareengineering.com/), a collection of principles and patterns that shape systems, teams, and decisions.

![demo](media/out.png)

## Install

Needs `jq`. `curl` is used for install and on the first run.

```bash
mkdir -p "$HOME/.local/bin" && curl -fsSL https://raw.githubusercontent.com/theElandor/lose_law/main/bin/lose.sh -o "$HOME/.local/bin/lose_law" && chmod +x "$HOME/.local/bin/lose_law"
```

Run it manually with:

```bash
lose_law
```

If you want a random law every time you open a new shell, add one of these snippets to your shell startup file.

## Show On Shell Startup

### Bash

```bash
printf '\nexport PATH="$HOME/.local/bin:$PATH"\ncommand -v lose_law >/dev/null 2>&1 && lose_law\n' >> "$HOME/.bashrc" && . "$HOME/.bashrc"
```

### Zsh

```zsh
printf '\nexport PATH="$HOME/.local/bin:$PATH"\ncommand -v lose_law >/dev/null 2>&1 && lose_law\n' >> "$HOME/.zshrc" && . "$HOME/.zshrc"
```

### Fish

```fish
printf '\nfish_add_path "$HOME/.local/bin"\ncommand -q lose_law; and lose_law\n' >> "$HOME/.config/fish/config.fish"; source "$HOME/.config/fish/config.fish"
```

### Other POSIX Shells

```sh
printf '\nexport PATH="$HOME/.local/bin:$PATH"\ncommand -v lose_law >/dev/null 2>&1 && lose_law\n' >> "$HOME/.profile" && . "$HOME/.profile"
```

## What Happens

On first run, `lose_law` downloads the JSON feed to `~/.config/lose/laws.json`. After that, each run prints one random law.

## Credit

Special thanks to [Laws of Software Engineering](https://lawsofsoftwareengineering.com/).
