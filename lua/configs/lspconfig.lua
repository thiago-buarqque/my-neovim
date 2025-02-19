require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "lua_ls", "rust_analyzer", "cssls", "html", "eslint", "jsonls", "marksman", "ts_ls" }
local nvlsp = require "nvchad.configs.lspconfig"

local map = vim.keymap.set

local function find_module_projects(base_dir)
  local projects = {}

  local function traverse(dir)
    local entries = vim.fn.readdir(dir)
    for _, entry in ipairs(entries) do
      local full_path = dir .. "/" .. entry
      if vim.fn.isdirectory(full_path) == 1 then
        -- Check for build files (adjust as needed for your project type)
        if vim.fn.filereadable(full_path .. "/build.gradle") == 1 or vim.fn.filereadable(full_path .. "/pom.xml") == 1 then
          table.insert(projects, full_path)
        end
        traverse(full_path) -- Recursively search subdirectories
      end
    end
  end

  traverse(base_dir)
  return projects
end

local on_attachh = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "<M-r>", vim.lsp.buf.references, opts "Show references")

  map('n', 'K', vim.lsp.buf.hover, opts "Hover")
  map('n', '<F2>', vim.lsp.buf.rename, opts "Rename")

end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attachh,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.jdtls.setup {
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    java = {
      home = "/opt/java/jdk21",
      configuration = {
        update = {
          automatic = true,
        },
      },
    },
  },
  root_dir = function(fname)
    local project_root = vim.fn.getcwd()

    while project_root ~= "/" do
      if vim.fn.filereadable(project_root .. "/build.gradle") == 1 or vim.fn.filereadable(project_root .. "/pom.xml") == 1 then
        return project_root
      end
      project_root = vim.fn.fnamemodify(project_root, ":h")
    end
    return vim.fn.getcwd()
  end,

  on_attach = function(client, bufnr)
    on_attachh(client, bufnr) -- Call the general on_attach

    if client.name == "jdtls" then  -- Only for jdtls
      client.config.init_options.vmargs = {
        "-Xmx16g",  -- Example: 4 Gigabytes of RAM
        "-Xms2g",  -- Example: 2 Gigabytes of RAM initial heap size
        -- other JVM options if needed
      }

      local liferay_home = os.getenv("LIFERAY_HOME")

      if liferay_home then
        local workspace_folders = {} -- Keep track of added folders

        local add_folder = function(folder)
          if vim.fn.isdirectory(folder) == 1 then -- Check if it's a directory
            vim.lsp.buf.add_workspace_folder(folder)
            table.insert(workspace_folders, folder)
          else
             print("Folder not found " .. folder)
          end
        end


        add_folder(liferay_home .. "/modules")
        add_folder(liferay_home .. "/modules/apps")
        add_folder(liferay_home .. "/portal-kernel")
        add_folder(liferay_home .. "/portal-web")

        local apps_dir = liferay_home .. "/modules/apps"
        if vim.fn.isdirectory(apps_dir) == 1 then
          local app_projects = find_module_projects(apps_dir)
          for _, project in ipairs(app_projects) do
             add_folder(project)
          end
        end

        -- print("JDTLS Workspace Folders:")
        -- for _, folder in ipairs(workspace_folders) do
        --     print(folder)
        -- end

      else
        print("LIFERAY_HOME environment variable not set!")
      end
    end
  end,
}
