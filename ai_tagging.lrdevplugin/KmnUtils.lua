--[[----------------------------------------------------------------------------

KmnUtils.lua
Various utility functions

--------------------------------------------------------------------------------

    Copyright 2016 Mike "KemoNine" Crosson
 
    This file is part of the LRCVT program.

    LRCVT is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.

    LRCVT is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with LRCVT.  If not, see <http://www.gnu.org/licenses/>.


------------------------------------------------------------------------------]]

local LrLogger = import 'LrLogger'
local LrPathUtils = import 'LrPathUtils'
local LrPrefs = import 'LrPrefs'
local PlugInfo = require 'Info'

-- Setup useful bits that are needed elsewhere
local prefs = LrPrefs.prefsForPlugin();
local logger = LrLogger(PlugInfo.LrToolkitIdentifier);

-- Functions / additions for dumping tables to strings
function table.val_to_str ( v )
  if "string" == type( v ) then
    v = string.gsub( v, "\n", "\\n" )
    if string.match( string.gsub(v,"[^'\"]",""), '^"+$' ) then
      return "'" .. v .. "'"
    end
    return '"' .. string.gsub(v,'"', '\\"' ) .. '"'
  else
    return "table" == type( v ) and table.tostring( v ) or
      tostring( v )
  end
end

function table.key_to_str ( k )
  if "string" == type( k ) and string.match( k, "^[_%a][_%a%d]*$" ) then
    return k
  else
    return "[" .. table.val_to_str( k ) .. "]"
  end
end

function table.tostring( tbl )
  local result, done = {}, {}
  for k, v in ipairs( tbl ) do
    table.insert( result, table.val_to_str( v ) )
    done[ k ] = true
  end
  for k, v in pairs( tbl ) do
    if not done[ k ] then
      table.insert( result,
        table.key_to_str( k ) .. "=" .. table.val_to_str( v ) )
    end
  end
  return "{" .. table.concat( result, "," ) .. "}"
end


-- Main KmN Utils definitions

KmnUtils = {}

KmnUtils.LogTrace = 'trace'
KmnUtils.LogDebug = 'debug'
KmnUtils.LogInfo = 'info'
KmnUtils.LogWarn = 'warn'
KmnUtils.LogError = 'error'
KmnUtils.LogFatal = 'fatal'

function KmnUtils.log(level, value)
  if prefs.debug == true then
    if level == 'fatal' then
      logger:fatal(value);
    elseif level == 'error' then
      logger:error(value)
    elseif level == 'warn' then
      logger:warn(value)
    elseif level == 'info' then
      logger:info(value)
    elseif level == 'debug' then
      logger:debug(value)
    else
      logger:trace(value)
    end
  end
end

function KmnUtils.enableDisableLogging() 
  -- Debugging bits
  if prefs ~= nil and prefs.debug == true then
    logger:enable( 'logfile' );
    KmnUtils.log(KmnUtils.LogInfo, 'Debug log enabled');
  else
    logger.disable();
  end
end

function KmnUtils.photoHasKeyword(photo, keyword)
  local keywords = photo:getRawMetadata('keywords');
  
  for _, k in ipairs(keywords) do
    if k:getName() == keyword then
      return true
    end
  end  
  
  return false;
end

return KmnUtils;
