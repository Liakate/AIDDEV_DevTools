-- DevTools hardened bootstrap
if not AIDDEV_DevTools then AIDDEV_DevTools = {} end
local DT = AIDDEV_DevTools
if DT._deferred then return end

AIDDEV_DevTools = AIDDEV_DevTools or {}
if not AIDDEV_DevTools then return end
-- EncodingGuard.lua

local DevTools = _G.AIDDEV_DevTools

local function has_crlf(text)
    return text:find("\r\n", 1, true) ~= nil
end

local function EncodingGuard(project, env, report)
    local expectedLE = env.lineEndings or "LF"

    for filename, file in pairs(project.files or {}) do
        local content = file.content or ""

        if expectedLE == "LF" and has_crlf(content) then
            report:Add("error", "ENCODING_CRLF",
                "CRLF line endings detected in: " .. filename)
        end
    end

    return true, 0
end

DevTools:RegisterValidator("EncodingGuard", EncodingGuard)
