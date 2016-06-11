" based on jellybeans.vim
" Color palette
let s:gui00 = "#2a2a2a"
let s:gui01 = "#ff2a94"
let s:gui02 = "#94ff2a"
let s:gui03 = "#ff942a"
let s:gui04 = "#2a94ff"
let s:gui05 = "#942aff"
let s:gui06 = "#2aff94"
let s:gui07 = "#cccccc"
let s:gui08 = "#3a3a3a"
let s:gui09 = "#ff99cc"
let s:gui0A = "#ccff99"
let s:gui0B = "#ffcc99"
let s:gui0C = "#99ccff"
let s:gui0D = "#cc99FF"
let s:gui0E = "#99ffcc"
let s:gui0F = "#ffffff"

let s:cterm00 = "0"
let s:cterm01 = "1"
let s:cterm02 = "2"
let s:cterm03 = "3"
let s:cterm04 = "4"
let s:cterm05 = "5"
let s:cterm06 = "6"
let s:cterm07 = "8"
let s:cterm08 = "7"
let s:cterm09 = "9"
let s:cterm0A = "10"
let s:cterm0B = "11"
let s:cterm0C = "12"
let s:cterm0D = "13"
let s:cterm0E = "14"
let s:cterm0F = "15"

let s:guiWhite = "#ffffff"
let s:ctermWhite = "15"

let g:airline#themes#jellybeans#palette = {}

" Normal mode
let s:N1 = [ s:gui00 , s:gui0D , s:cterm00 , s:cterm0D  ]
let s:N2 = [ s:guiWhite , s:gui05 , s:ctermWhite , s:cterm05  ]
let s:N3 = [ s:gui02 , s:gui07 , s:cterm02 , s:cterm07  ]
let g:airline#themes#jellybeans#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Insert mode
let s:I1 = [ s:gui00 , s:gui0C , s:cterm00 , s:cterm0C  ]
let s:I2 = [ s:guiWhite , s:gui04 , s:ctermWhite , s:cterm04  ]
let s:I3 = [ s:guiWhite , s:gui07 , s:ctermWhite , s:cterm07  ]
let g:airline#themes#jellybeans#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)

" Visual mode
let s:V1 = [ s:gui00 , s:gui0A , s:cterm00 , s:cterm0A  ]
let s:V2 = [ s:gui00 , s:gui02 , s:cterm00 , s:cterm02 ]
let s:V3 = [ s:guiWhite , s:gui07 , s:ctermWhite , s:cterm07  ]
let g:airline#themes#jellybeans#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)

" Replace mode
let s:R1 = [ s:gui00 , s:gui0E , s:cterm00 , s:cterm0E  ]
let s:R2 = [ s:gui00 , s:gui06 , s:cterm00, s:cterm06 ]
let s:R3 = [ s:guiWhite , s:gui07 , s:ctermWhite , s:cterm07  ]
let g:airline#themes#jellybeans#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)

" Inactive mode
let s:IN1 = [ s:gui02 , s:gui07 , s:cterm02 , s:cterm07 ]
let s:IN2 = [ s:gui07 , s:gui05 , s:cterm07 , s:cterm05 ]
let s:IN3 = [ s:gui02 , s:gui07 , s:cterm02 , s:cterm07 ]
let g:airline#themes#jellybeans#palette.inactive = airline#themes#generate_color_map(s:IN1, s:IN2, s:IN3)

" CtrlP
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif

let s:CP1 = [ s:guiWhite , s:gui05 , s:ctermWhite , s:cterm05  ]
let s:CP2 = [ s:guiWhite , s:gui05 , s:ctermWhite , s:cterm05  ]
let s:CP3 = [ s:guiWhite , s:gui0D , s:ctermWhite , s:cterm0D  ]

let g:airline#themes#jellybeans#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(s:CP1, s:CP2, s:CP3)
