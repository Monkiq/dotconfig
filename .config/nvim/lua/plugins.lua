-- 自动安装 Packer.nvim
-- 插件安装目录
-- ~/.local/share/nvim/site/pack/packer/
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify('正在安装Pakcer.nvim，请稍后...')
    paccker_bootstrap = fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        -- "https://gitcode.net/mirrors/wbthomason/packer.nvim",
        install_path,
    })
    local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
    if not string.find(vim.o.runtimepath, rtp_addition) then
        vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
    end
    vim.notify('Pakcer.nvim 安装完毕')
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    vim.notify('没有安装 packer.nvim')
    return
end

packer.startup({
    function(use)
        --Packer 可以管理自己本身
        use('wbthomason/packer.nvim')
        ----------------------------------ColorScheme--------------------------
        --tokyoninght
        use('folke/tokyonight.nvim')
        -- OceanicNext
        use('mhartington/oceanic-next')
        -- gruvbox
        use({ 'ellisonleao/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } })
        -- nord
        use('shaunsingh/nord.nvim')
        -- onedark
        use('ful1e5/onedark.nvim')
        -- nightfox
        use('EdenEast/nightfox.nvim')

        ----------------------------------plugins------------------------------
        -- nvim-notify
        use({
            'rcarriga/nvim-notify',
            config = function()
                require('plugin-config.nvim-notify')
            end,
        })
        -- nvim-tree
        use({
            'kyazdani42/nvim-tree.lua',
            requires = 'kyazdani42/nvim-web-devicons',
            config = function()
                require('plugin-config.nvim-tree')
            end,
        })

        -- bufferline
        use({
            'akinsho/bufferline.nvim',
            requires = { 'kyazdani42/nvim-web-devicons', 'moll/vim-bbye' },
            config = function()
                require('plugin-config.bufferline')
            end,
        })

        -- lualine
        use({
            'nvim-lualine/lualine.nvim',
            requires = { 'kyazdani42/nvim-web-devicons' },
            config = function()
                require('plugin-config.lualine')
            end,
        })

        -- telescope
        use({
            'nvim-telescope/telescope.nvim',
            -- opt = true,
            -- cmd = "Telescope",
            requires = {
                -- telescope extensions
                { 'LinArcX/telescope-env.nvim' },
                { 'nvim-telescope/telescope-ui-select.nvim' },
            },
            config = function()
                require('plugin-config.telescope')
            end,
        })

        -- dashboard-nvim
        use({
            'glepnir/dashboard-nvim',
            config = function()
                require('plugin-config.dashboard')
            end,
        })

        -- project
        use({
            'ahmedkhalf/project.nvim',
            config = function()
                require('plugin-config.project')
            end,
        })

        -- treesitter
        use({
            'nvim-treesitter/nvim-treesitter',
            run = function()
                -- require("nvim-treesitter.install").update({ with_sync = true })
            end,
            requires = {
                { 'p00f/nvim-ts-rainbow' },
                { 'JoosepAlviste/nvim-ts-context-commentstring' },
                { 'windwp/nvim-ts-autotag' },
                { 'nvim-treesitter/nvim-treesitter-refactor' },
                { 'nvim-treesitter/nvim-treesitter-textobjects' },
            },
            config = function()
                require('plugin-config.nvim-treesitter')
            end,
        })

        -- indent-blankline
        use({
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require('plugin-config.indent-blankline')
            end,
        })

        -- toggleterm
        use({
            'akinsho/toggleterm.nvim',
            config = function()
                require('plugin-config.toggleterm')
            end,
        })

        -- Comment
        use({
            'numToStr/Comment.nvim',
            config = function()
                require('plugin-config.comment')
            end,
        })

        ----------------------------------Editor-------------------------------
        -----------------------------自动补全----------------------------------
        -- installer
        use({ 'williamboman/mason.nvim' })
        use({ 'williamboman/mason-lspconfig.nvim' })
        -- Lspconfig
        use({ 'neovim/nvim-lspconfig' })
        -- 补全引擎
        use('hrsh7th/nvim-cmp')
        -- snippet 引擎
        use('L3MON4D3/LuaSnip')
        use('saadparwaiz1/cmp_luasnip')
        -- 补全源
        use('hrsh7th/cmp-vsnip')
        use('hrsh7th/cmp-nvim-lsp') -- { name = nvim_lsp }
        use('hrsh7th/cmp-buffer') -- { name = 'buffer' },
        use('hrsh7th/cmp-path') -- { name = 'path' }
        use('hrsh7th/cmp-cmdline') -- { name = 'cmdline' }
        use('hrsh7th/cmp-nvim-lsp-signature-help') -- { name = 'nvim_lsp_signature_help' }
        -- 常见编程语言代码段
        use('rafamadriz/friendly-snippets')
        -- UI 增强
        use('onsails/lspkind-nvim')
        use('tami5/lspsaga.nvim')
        -- 代码格式化
        use('mhartington/formatter.nvim')
        use({ 'jose-elias-alvarez/null-ls.nvim', requires = 'nvim-lua/plenary.nvim' })
        -- TypeScript 增强
        use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = 'nvim-lua/plenary.nvim' })
        use('jose-elias-alvarez/typescript.nvim')
        -- Lua 增强
        use('folke/neodev.nvim')
        -- JSON 增强
        use('b0o/schemastore.nvim')
        -- 括号补全
        use('windwp/nvim-autopairs')

        -- git
        use('lewis6991/gitsigns.nvim')

        if paccker_bootstrap then
            packer.sync()
        end
    end,

    config = {
        --并发数限制
        max_jobs = 16,
        git = {
            -- defalut_url_format = "https://hub.fastgit.xyz/%s"
        },
    },
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'single' })
        end,
    },
})
