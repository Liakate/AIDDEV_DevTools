-- DevTools hardened bootstrap
if not AIDDEV_DevTools then AIDDEV_DevTools = {} end
local DT = AIDDEV_DevTools
if DT._deferred then return end

AIDDEV_DevTools = AIDDEV_DevTools or {}
if not AIDDEV_DevTools then return end
-- SyntaxGuard.lua

local DevTools = _G.AIDDEV_DevTools

local function SyntaxGuard(project, env, report)
    for filename, file in pairs(project.files or {}) do
        local content = file.content or ""
        if content == "" then
            report:Add("warning", "SYNTAX_EMPTY_FILE",
                "File is empty: " .. filename)
        end
    end
    return true, 0
end

DevTools:RegisterValidator("SyntaxGuard", SyntaxGuard)
