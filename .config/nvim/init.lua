require("utils.global")
-- 基础配置
require('basic')
-- Packer插件管理
require('plugins')
-- 快捷键映射
require('keybindings')
-- 主题设置
require('colorscheme')
-- 内置LSP
require('lsp.setup')

require('cmp.setup')

require('format.setup')

-- tools
require('utils.fix-yank')

require('autocmd')
