-- DevTools hardened bootstrap
if not AIDDEV_DevTools then AIDDEV_DevTools = {} end
local DT = AIDDEV_DevTools
if DT._deferred then return end

AIDDEV_DevTools = AIDDEV_DevTools or {}
if not AIDDEV_DevTools then return end
-- AIDDEV_DevTools/Core/DevTools.lua
-- Pre-flight validation suite that runs before AIDDEV consumes any project.

local Companion = _G.AIDDEV_Companion
local Loader    = _G.AIDDEV_Loader

local DevTools = {}
AIDDEV_DevTools = DevTools

DevTools.validators = {}

---------------------------------------------------------------------
-- Registration
---------------------------------------------------------------------
function DevTools:RegisterValidator(id, fn)
    -- fn(project, env, report) -> ok, errorCount
    self.validators[id] = fn
end

---------------------------------------------------------------------
-- Report sink
---------------------------------------------------------------------
local function make_report()
    local report = {
        entries      = {},
        fatalCount   = 0,
        errorCount   = 0,
        warningCount = 0,
    }

    function report:Add(severity, ruleId, message, extra)
        table.insert(self.entries, {
            severity = severity,   -- "fatal", "error", "warning", "info"
            ruleId   = ruleId,
            message  = message,
            extra    = extra,
        })

        if severity == "fatal" then
            self.fatalCount = self.fatalCount + 1
        elseif severity == "error" then
            self.errorCount = self.errorCount + 1
        elseif severity == "warning" then
            self.warningCount = self.warningCount + 1
        end
    end

    return report
end

---------------------------------------------------------------------
-- Run all validators
---------------------------------------------------------------------
function DevTools:RunAll()
    if not Companion or not Companion.GetCurrentProject then
        print("|cffff0000AIDDEV DevTools:|r No Companion available")
        return nil, "NO_COMPANION"
    end

    local project = Companion:GetCurrentProject()
    if not project then
        print("|cffff0000AIDDEV DevTools:|r No project loaded in Companion")
        return nil, "NO_PROJECT"
    end

    local env = Companion:GetEnvironment and Companion:GetEnvironment() or {}
    local report = make_report()

    for id, fn in pairs(self.validators) do
        local ok, errCount = fn(project, env, report)
    end

    -- Fatal errors stop everything
    if report.fatalCount > 0 then
        print("|cffff0000AIDDEV DevTools: FATAL ERRORS — project rejected.|r")
        AIDDEV_DevTools_ShowReport(report)
        return nil, "FATAL", report
    end

    -- Non-fatal errors still block loading
    if report.errorCount > 0 then
        print("|cffff0000AIDDEV DevTools: ERRORS — project not loaded.|r")
        AIDDEV_DevTools_ShowReport(report)
        return nil, "ERRORS", report
    end

    -- Otherwise load into AIDDEV
    if Loader and Loader.SetCurrentProject then
        Loader:SetCurrentProject(project)
    end

    print(string.format("|cff00ff00AIDDEV DevTools:|r Validation OK (%d warning(s)). Project loaded into AIDDEV.",
        report.warningCount))
    AIDDEV_DevTools_ShowReport(report)

    return true, nil, report
end

---------------------------------------------------------------------
-- Slash command
---------------------------------------------------------------------
SLASH_AIDDEVTOOLS1 = "/aiddevtools"
SlashCmdList["AIDDEVTOOLS"] = function(msg)
    AIDDEV_DevTools_RunAndShow()
end

function AIDDEV_DevTools_RunAndShow()
    local ok = DevTools:RunAll()
    AIDDEV_DevTools_ToggleFrame()
end

return DevTools
