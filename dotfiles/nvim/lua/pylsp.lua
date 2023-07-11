local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig.pylsp.setup({ -- pkgs python-lsp-server, python-rope, yapf
    capabilities = capabilites,
    settings = {
        pylsp = {
            plugins = {
                ruff = { -- pkgs ruff, python-lsp-ruff (AUR)
                    enabled = true,
                    extendSelect = {"ALL"},
                    extendIgnore = {"D", "ANN201", "I", "T20"},
                    format = {}, -- Disable automatic formatting
                    severities = {
                        SIM105 = "H",
                    }
                },
                pylint = { --pkg python-pylint
                    enabled = true,
                    executable = "pylint",
                    args = {"-d C0114,C0115,C0116,R0913"},
                },
                pylsp_mypy = { -- pkg python-pylsp-mypy (AUR)
                    enabled = true,
                    overrides = {"--ignore-missing-imports", true}
                },
                pycodestyle = {enabled = true}, --pkg python-pycodestyle
            }
        }
    }
})
