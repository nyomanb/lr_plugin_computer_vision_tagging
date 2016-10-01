--[[----------------------------------------------------------------------------

ClarifaiAPI.lua
Clarifai API implementation in pure lua

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

local LrPrefs = import 'LrPrefs'
local LrHttp = import 'LrHttp'
local LrTasks = import 'LrTasks'
local JSON = require 'JSON'
local KmnUtils = require 'KmnUtils'

local tokenAPIURL = 'https://api.clarifai.com/v1/token/'
local infoAPIURL = 'https://api.clarifai.com/v1/info/'
local tagAPIURL   = 'https://api.clarifai.com/v1/tag/'

local prefs = LrPrefs.prefsForPlugin();

ClarifaiAPI = {}

function ClarifaiAPI.getTokenUnsafe()
  local headers = {
    { field = 'Content-Type', value = 'application/x-www-form-urlencoded' },
  };

  local data = 'grant_type=client_credentials&client_id=' .. prefs.clarifai_clientid .. '&client_secret=' .. prefs.clarifai_clientsecret;
  local body, reshdrs = LrHttp.post(tokenAPIURL, data, headers);

  KmnUtils.log(KmnUtils.LogInfo, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogInfo, body);

  local json = JSON:decode(body);
  prefs.clarifai_accesstoken = json.access_token;
end

-- Main methods API consumers should call (everything is wrapped in tasks as appropriate)
function ClarifaiAPI.getToken()
  LrTasks.startAsyncTask(function()
    ClarifaiAPI.getTokenUnsafe();
  end, 'ClarifaiAPI.getToken');
end

function ClarifaiAPI.getInfo()
  -- FIXME: This block blows up with a "hidden" error if the API keys are incorrect in settings
  if prefs.clarifai_accesstoken == nil then
    ClarifaiAPI.getTokenUnsafe();
  end

  local headers = {
    { field = 'Authorization', value = 'Bearer ' .. prefs.clarifai_accesstoken }, 
  }
  
  local body, reshdrs = LrHttp.get(infoAPIURL, headers);
  
  KmnUtils.log(KmnUtils.LogInfo, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogInfo, body);

  -- FIXME: Handle 401 status error messages properly (invalid token is a case that needs to be properly addressed)

  if reshdrs.status == 401 then
    KmnUtils.log(KmnUtils.LogDebug, '401 status');
    return nil;
  end
  
  return JSON:decode(body);
end

return ClarifaiAPI;
