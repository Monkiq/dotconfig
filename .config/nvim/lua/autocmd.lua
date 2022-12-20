local myAutoGroup = vim.api.nvim_create_augroup('myAutoGroup', {
    clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- 进入Terminal 自动进入插入模式
autocmd('TermOpen', {
    group = myAutoGroup,
    command = 'startinsert',
})

-- 保存时自动格式化
autocmd('BufWritePre', {
    group = myAutoGroup,
    pattern = { '*.lua', '*.py', '*.sh', '.cpp', '.c' },
    callback = function()
        vim.lsp.buf.format({ async = true })
    end,
})

-- 修改lua/plugins.lua 自动更新插件
autocmd('BufWritePost', {
    group = myAutoGroup,
    -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
    callback = function()
        if vim.fn.expand('<afile>') == 'lua/plugins.lua' then
            vim.api.nvim_command('source lua/plugins.lua')
            vim.api.nvim_command('PackerSync')
        end
    end,
})

-- 用o换行不要延续注释
autocmd('BufEnter', {
    group = myAutoGroup,
    pattern = '*',
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            - 'o' -- O and o, don't continue comments
            + 'r' -- But do continue when pressing enter.
    end,
})

-- c/c++ 文件编译并运行
autocmd('FileType', {
    pattern = 'cpp',
    callback = function()
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<F8>',
            '<ESC>:w<CR>:split<CR>:te clang++ -o %:t:r %  && ./%:t:r <CR>',
            { silent = true, noremap = true }
        )
    end,
})
-- c/c++文件编译
autocmd('FileType', {
    pattern = 'cpp',
    callback = function()
        vim.api.nvim_buf_set_keymap(
            0,
            'n',
            '<F7>',
            '<ESC>:w<CR> :te clang++ -o %:t:r % <CR> ',
            { silent = true, noremap = true }
        )
    end,
})
