local Rules = require("AIDDEV_DevTools.Rules.BronzebeardRules")
local Guard = require("AIDDEV_DevTools.Util.InspectorGuard")
local Compliance = {}
function Compliance.Run(context)
  if Guard.IsInspectorAddon(context) then return nil end
  local hard, soft = 0, 0
  local violations = {}
  for ruleId, rule in pairs(Rules.Map) do
    for _, fid in ipairs(rule.findings) do
      if context:HasFinding(fid) then
        violations[ruleId] = rule
        if rule.severity == "HARD" then hard = hard + 1 else soft = soft + 1 end
        break
      end
    end
  end
  return { addonId=context.addonId, hard=hard, soft=soft, violations=violations, status=hard>0 and "BLOCKED" or "COMPATIBLE" }
end
return Compliance
