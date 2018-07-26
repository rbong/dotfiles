# vim-vixen-dracula

This is the dracula style for vim-vixen with the Inconsolata font.
This is for my personal use and might not work for you

## Prerequisites

- Inconsolata or powerline fonts for the font to appear correctly
- a Unix-like system
- npm and node
- a system that can compile node-sass

## Installation

```bash
npm install
```

## Usage

Build and install into `userContent.css`:

```bash
FIREFOX_PROFILE=<profile> ./install.sh
```

if you don't know your profile you can find it with this command:

```bash
ls ~/.mozilla/firefox
```

if you just want to build the styles and add it manually:

```bash
npm run build
```

## Customizing

Feel free to fork and change colors.
