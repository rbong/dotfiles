## Bindings


c.bindings.commands = {
  'normal': {
    'J': 'tab-prev',
    'K': 'tab-next',
  },
}


## Colorschemes


import colorschemes.gruvbox_dark
import colorschemes.gruvbox_light

colorschemes.gruvbox_dark.apply(c)


## Fonts


monospace_font = '10pt monospace'

c.fonts.monospace = 'Inconsolata for Powerline'

c.fonts.completion.category = monospace_font
c.fonts.completion.entry = monospace_font
c.fonts.debug_console = monospace_font
c.fonts.downloads = monospace_font
c.fonts.hints = monospace_font
c.fonts.keyhint = monospace_font
c.fonts.messages.error = monospace_font
c.fonts.messages.info = monospace_font
c.fonts.messages.warning = monospace_font
c.fonts.monospace = monospace_font
c.fonts.statusbar = monospace_font
c.fonts.tabs = monospace_font


## URLs


c.url.default_page = 'about:blank'
c.url.start_pages = 'about:blank'

c.url.searchengines = {
  'DEFAULT': 'https://www.startpage.com/do/dsearch?cat=web&pl=opensearch&query={}',
  'aw': 'https://wiki.archlinux.org/index.php?title=Special%3ASearch&go=Go&search={}',
  'aur': 'https://aur.archlinux.org/packages/?O=0&K={}',
  'oeis': 'https://oeis.org/search?language=english&go=Search&q={}',
  'm': 'https://www.openstreetmap.org/search?query={}',
  'sp': 'https://www.startpage.com/do/dsearch?cat=web&pl=opensearch&query={}',
  'w': 'https://en.wikipedia.org/w/index.php?search={}',
  'wa': 'https://www.wolframalpha.com/input/?i={}',
  'y': 'https://www.youtube.com/results?search_query={}',
}


## Misc.


c.editor.command = ['urxvt', '-e', 'zsh', '-ic', 'vim {file}']

c.statusbar.padding = { 'top': 1, 'bottom': 2, 'left': 0, 'right': 0 }
c.tabs.padding = { 'top': 2, 'bottom': 1, 'left': 0, 'right': 0 }
