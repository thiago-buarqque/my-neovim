require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

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
        -- Check for build files
        if vim.fn.filereadable(full_path .. "/build.gradle") == 1 or vim.fn.filereadable(full_path .. "/bnd.bnd") == 1 then
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

local home = vim.fn.getenv("HOME")
local mason_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

lspconfig.jdtls.setup {
    cmd = {

    -- 💀
    '/opt/java/jdk21/bin/java', -- or '/path/to/java21_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx8g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', mason_path .. "/plugins/org.eclipse.equinox.launcher_1.6.900.v20240613-2009.jar",
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    '-configuration', mason_path .. "/config_linux",
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir
  },
  -- cmd = {
  --   mason_path .. "/bin/jdtls",
  --   "-data", workspace_dir,
  -- },
  cmd_env = {
    GRADLE_HOME = "/home/me/dev/projects/liferay-portal/.gradle/",
  },
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    java = {
      home = "/opt/java/jdk21",
      eclipse = {
				downloadSources = true,
			},
      configuration = {
        runtimes = {
          {
            name = "Java OpenJDK 21",
            path = "/usr/lib/jvm/jre-openjdk",
          },
        },
        updateBuildConfiguration = "interactive",
        update = {
          automatic = true,
        },
      },
      import = {
        gradle = {
          enabled = true
        },
        maven = {
          enabled = false
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archetype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**",
          "/**/dist/**",
          "/**/build/**"
        }
      }
    },
    connection = {
      gradle = {
        distribution = "GRADLE_DISTRIBUTION(VERSION(8.5))"
      }
    }
  },
  root_dir = function(fname)
    local current_dir = vim.fn.fnamemodify(fname, ":p:h")

    while current_dir ~= "/" do
      if vim.fn.filereadable(current_dir .. "/build.gradle") == 1 or vim.fn.filereadable(current_dir .. "/build.gradle.kts") == 1 then
        return current_dir -- Found build.gradle, this is the root of the *module*
      end
      -- Check for the presence of a settings.gradle or settings.gradle.kts file to identify root of the liferay project.
      if vim.fn.filereadable(current_dir .. "/settings.gradle") == 1 or vim.fn.filereadable(current_dir .. "/settings.gradle.kts") == 1 then
        return current_dir
      end
      current_dir = vim.fn.fnamemodify(current_dir, ":h") -- Go up one directory
    end

    -- If no build.gradle is found, return the current directory or a suitable default
    -- This might be the case for a standalone gradle project.
    return vim.fn.fnamemodify(fname, ":p:h")
  end,

  on_attach = function(client, bufnr)
    on_attachh(client, bufnr) -- Call the general on_attach

    if not client.name == "jdtls" then
      return
    end

    local liferay_home = os.getenv("LIFERAY_HOME")

    if not liferay_home then
      print("LIFERAY_HOME environment variable not set!")
      return;
    end

    client.config.init_options.vmargs = {
      "-Xmx10g", -- Example: 4 Gigabytes of RAM
      "-Xms2g",  -- Example: 2 Gigabytes of RAM initial heap size
    }

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
  end,
}
