-- DevTools hardened bootstrap
if not AIDDEV_DevTools then AIDDEV_DevTools = {} end
local DT = AIDDEV_DevTools
if DT._deferred then return end

AIDDEV_DevTools = AIDDEV_DevTools or {}
if not AIDDEV_DevTools then return end
-- TOCGuard.lua

local DevTools = _G.AIDDEV_DevTools

local function TOCGuard(project, env, report)
    if not env.clientBuild or env.clientBuild <= 0 then
        report:Add("fatal", "TOC_ENV_INVALID_BUILD",
            "Client build is invalid or unsupported.")
    end

    return true, 0
end

DevTools:RegisterValidator("TOCGuard", TOCGuard)
