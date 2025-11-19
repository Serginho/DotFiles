return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    keys = {
      {
        "<leader>cpq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Quick chat",
      },
      {
        "<leader>cpq",
        function()
          local input = vim.fn.input("Query Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
          end
        end,
        mode = "x", -- Esto asegura que el mapeo solo funcione en modo visual
        desc = "CopilotChat - Chat with visual selection",
      },
      {
        "<leader>cpO",
        function()
          require("CopilotChat").open()
        end,
      },
            {
        "<leader>cpfd",
        function()
          local current_bufnr = vim.api.nvim_get_current_buf()
          local diagnostics = vim.diagnostic.get(current_bufnr)
          local default_query = "Por favor, ayúdame con el siguiente problema de diagnóstico en el código seleccionado y explica el fallo. Proporciona solo el código corregido en un bloque de código, sin explicaciones adicionales:"

          -- Intenta encontrar el diagnóstico más relevante en la línea actual
          local cursor_line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- Lua es 0-indexed, Vim es 1-indexed
          local relevant_diag_info = ""

          if #diagnostics > 0 then
            -- Filtrar diagnósticos para la línea actual
            local line_diagnostics = {}
            for _, diag in ipairs(diagnostics) do
              if diag.lnum == cursor_line then
                table.insert(line_diagnostics, diag)
              end
            end

            -- Si hay diagnósticos en la línea actual, toma el primero o más relevante
            if #line_diagnostics > 0 then
              local first_diag = line_diagnostics[1]
              relevant_diag_info = string.format(" Diagnóstico: %s (Severity: %s, Source: %s)",
                                                  first_diag.message,
                                                  vim.diagnostic.severity[first_diag.severity],
                                                  first_diag.source or "Unknown")
            else
              -- Si no hay diagnósticos en la línea actual, intenta tomar el primero del búfer
              local first_diag = diagnostics[1]
               relevant_diag_info = string.format(" Diagnóstico (primero en el archivo): %s (Severity: %s, Source: %s)",
                                                  first_diag.message,
                                                  vim.diagnostic.severity[first_diag.severity],
                                                  first_diag.source or "Unknown")
            end
          end

          -- Combina la consulta por defecto con la información del diagnóstico
          local input = default_query

          if input ~= "" then
            -- Usa la selección visual si está activa, de lo contrario, el búfer completo
            local current_selection = require("CopilotChat.select").buffer
            require("CopilotChat").ask(input, { selection = current_selection })
          end
        end,
        desc = "CopilotChat - Fix Diagnostic with context",
      },
    },
    opts = {
      debug = false, -- Enable debugging
      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN Escribe una explicación para la selección activa en párrafos de texto.",
          mapping = "<leader>cpe",
        },
        Review = {
          prompt = "/COPILOT_REVIEW Revisa el código seleccionado.",
          mapping = "<leader>cpr",
          callback = function(response, source)
            local ns = vim.api.nvim_create_namespace("copilot_review")
            local diagnostics = {}
            for line in response:gmatch("[^\r\n]+") do
              if line:find("^line=") then
                local start_line = nil
                local end_line = nil
                local message = nil
                local single_match, message_match = line:match("^line=(%d+): (.*)$")
                if not single_match then
                  local start_match, end_match, m_message_match = line:match("^line=(%d+)-(%d+): (.*)$")
                  if start_match and end_match then
                    start_line = tonumber(start_match)
                    end_line = tonumber(end_match)
                    message = m_message_match
                  end
                else
                  start_line = tonumber(single_match)
                  end_line = start_line
                  message = message_match
                end

                if start_line and end_line then
                  table.insert(diagnostics, {
                    lnum = start_line - 1,
                    end_lnum = end_line - 1,
                    col = 0,
                    message = message,
                    severity = vim.diagnostic.severity.WARN,
                    source = "Copilot Review",
                  })
                end
              end
            end
            vim.diagnostic.set(ns, source.bufnr, diagnostics)
          end,
        },
        Fix = {
          prompt = "/COPILOT_GENERATE Encuentra el problema en este código. Reescribe el código con el error corregido.",
          mapping = "<leader>cpf",
        },
        Optimize = {
          prompt = "/COPILOT_GENERATE Optimiza el código seleccionado para mejorar el rendimiento y la legibilidad.",
          mapping = "<leader>cpo",
        },
        Docs = {
          prompt = "/COPILOT_GENERATE Añade documentación al código seleccionado. No imprimas las líneas del código al inicio",
          mapping = "<leader>cpd",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE Genera pruebas para el código seleccionado.",
          mapping = "<leader>cpt",
        },
        InjectChunk = {
          prompt = "/COPILOT_GENERATE A partir del siguiente código, te voy a dar intrucciones a realizar:",
          mapping = "<leader>cpi",
        },
        -- FixDiagnostic = {
        --   prompt = "Por favor, ayudame con el siguiente problema de diagnóstico en el archivo:",
        --   selection = require("CopilotChat.select").diagnostics,
        --   mapping = "<leader>cpfd",
        -- },
        -- Commit = {
        --   prompt = "Escribe un mensaje de confirmación para el cambio con la convención de commitizen. Asegúrate de que el título tenga un máximo de 50 caracteres y el mensaje esté envuelto a 72 caracteres. Envuélvelo todo el mensaje en un bloque de código con el lenguaje gitcommit.",
        --   selection = require("CopilotChat.select").gitdiff,
        --   mapping = "<leader>cpc",
        -- },
      },
    },
  },
}
