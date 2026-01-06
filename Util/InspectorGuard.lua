local Guard = {}
function Guard.IsInspectorAddon(context)
  if not context or not context.addonId then return true end
  return context.addonId == "AIDDEV" or context.addonId == "AIDDEV_DevTools"
end
return Guard
