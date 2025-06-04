local dotfile_config_consts = require('configs.consts')
local string = require('string')
local M = {}

function string:split(delimiter)
  local result = {}
  local from  = 1
  local delim_from, delim_to = string.find(self, delimiter, from)

  while delim_from do
    table.insert(result, string.sub(self, from, delim_from - 1))
    from = delim_to + 1
    delim_from, delim_to = string.find(self, delimiter, from)
  end

  table.insert(result, string.sub(self, from))

  return result
end

function M.construct_plugin_default_spec(short_url, spec_arguments)
  local spec = {}

  if dotfile_config_consts.online_mode then
    spec[1] = short_url
  else
    local split_result = string.split(short_url, '/')

    spec['dir'] = dotfile_config_consts.plugins_directory .. split_result[#split_result]
  end

  if 'table' == type(spec_arguments) then
    for k, v in pairs(spec_arguments) do
      spec[k] = v
    end
  end

  return spec
end

return M
