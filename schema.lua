-- schema.lua

local typedefs = require "kong.db.schema.typedefs"

return {
  name = "custom-logging-plugin",
  fields = {
    { config = {
        type = "record",
        fields = {},
      },
    },
  },
}
