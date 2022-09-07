hook global BufCreate .*\.kbd %{
  set-option buffer filetype kbd
}

hook -group kmonad-highlight global WinSetOption filetype=kbd %{
  require-module kmonad

  add-highlighter window/kmonad ref kmonad
  set-option buffer extra_word_chars '_' '+' '-' '*' '/' '@' '$' '%' '^' '&' '_' '=' '<' '>' '~' '.'

  hook -always -once window WinSetOption filetype=.* %{ remove-highlighter window/kmonad }
}

provide-module kmonad %{
  add-highlighter shared/kmonad regions
  add-highlighter shared/kmonad/code default-region group

  add-highlighter shared/kmonad/code/ regex "\(|\)" 0:builtin
  add-highlighter shared/kmonad/code/ regex "\b(defsrc|defalias|deflayer|defcfg|cmd-button|tap-next|tap-hold|tap-hold-next|tap-hold-next-release|layer-toggle|layer-switch|around|around-next|multi-tap|sticky-key)" 0:keyword
  add-highlighter shared/kmonad/code/ regex "\s(input|output|fallthrough|allow-cmd|cmp-seq|cmp-seq-delay)" 0:identifier
  # add-highlighter shared/kmonad/code/ regex \s@[\w!$%&*+./:<=>?@^_~-]+ 0:identifier # distracts from other potential re-mappings

  add-highlighter shared/kmonad/comment region ';;' '$' fill comment
  add-highlighter shared/kmonad/comment-block region '#\|' '\|#' fill comment
}
