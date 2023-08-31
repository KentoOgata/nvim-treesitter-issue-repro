const s:packpath = expand('<script>:p:h')
let &packpath = s:packpath
const s:ToPackPath = { name -> s:packpath .. '/pack/github.com/opt/' .. name }

function s:PackAdd(ghrepo, rev = v:null) abort
  const plugin = #{
        \ path: s:ToPackPath(a:ghrepo),
        \ repo: $'https://github.com/{a:ghrepo}.git',
        \ name: a:ghrepo,
        \ }
  if !isdirectory(plugin.path)
    call system(['git', 'clone', plugin.repo, plugin.path])
  endif
  if a:rev isnot v:null
    call system(['git', '-C', plugin.path, 'checkout', a:rev])
  endif
  exec 'packadd' plugin.name
endfunction

call s:PackAdd('nvim-treesitter/nvim-treesitter', '920b37260ebc720b0399bd12954fd2bf8bd18242')

lua << EOF
local parser_dir = ('%s/treesitter'):format(vim.fn.stdpath 'data')
vim.opt.runtimepath:append(parser_dir)
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    'bash',
    'vimdoc',
    'vim',
    'lua',
  },
  auto_install = true,
  parser_install_dir = parser_dir,
  highlight = {
    enable = true,
    -- disable = { 'vimdoc' },
  },
}
EOF
