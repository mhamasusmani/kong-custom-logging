-- handler.lua

local BasePlugin = require "kong.plugins.base_plugin"
local CustomLoggingHandler = BasePlugin:extend()

CustomLoggingHandler.VERSION = "1.0.0"
CustomLoggingHandler.PRIORITY = 10

function CustomLoggingHandler:new()
  CustomLoggingHandler.super.new(self, "custom-logging-plugin")
end

-- Log incoming requests
function CustomLoggingHandler:access(conf)
  CustomLoggingHandler.super.access(self)
  
  -- Log incoming request with memory usage
  kong.log.debug("<-- Incoming request: " .. ngx.var.request_uri .. 
                 " [Memory usage: " .. collectgarbage("count") .. " KB]")
end

-- Log outgoing requests
function CustomLoggingHandler:log(conf)
  CustomLoggingHandler.super.log(self)
  
  -- Log outgoing response with memory usage
  kong.log.debug("--> Outgoing response: " .. ngx.var.upstream_uri .. 
                 " [Memory usage: " .. collectgarbage("count") .. " KB]")
end

return CustomLoggingHandler
