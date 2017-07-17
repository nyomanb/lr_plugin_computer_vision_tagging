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

local LrDialogs = import 'LrDialogs'
local LrHttp = import 'LrHttp'
local LrTasks = import 'LrTasks'
local LrPathUtils = import 'LrPathUtils'
local LrRecursionGuard = import 'LrRecursionGuard'
local JSON = require 'JSON'
local KmnUtils = require 'KmnUtils'

local infoAPIURL = 'https://api.clarifai.com/v2/info/'
local usageAPIURL = 'https://api.clarifai.com/v2/usage/'
local tagAPIURLPrefix   = 'https://api.clarifai.com/v2/models/'
local tagAPIURLPostfix = '/outputs'

local prefs = import 'LrPrefs'.prefsForPlugin(_PLUGIN.id)
local getInfoGuard =  LrRecursionGuard('getInfoguard')

ClarifaiAPI = {}

function ClarifaiAPI.getInfo()
  KmnUtils.log(KmnUtils.LogTrace, 'ClarifaiAPI.getInfo()');
  local headers = {
    { field = 'Authorization', value = 'Key ' .. prefs.clarifai_apikey }, 
  }
  
  local body, reshdrs = LrHttp.get(infoAPIURL, headers);
  
  KmnUtils.log(KmnUtils.LogInfo, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogInfo, body);

  return JSON:decode(body);
end

function ClarifaiAPI.getUsage()
  local headers = {
    { field = 'Authorization', value = 'Key ' .. prefs.clarifai_apikey }, 
  }
  
  local body, reshdrs = LrHttp.get(usageAPIURL, headers);
  
  KmnUtils.log(KmnUtils.LogInfo, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogInfo, body);

  return JSON:decode(body);
end

function ClarifaiAPI.getTags(photoPath, model, language)
  KmnUtils.log(KmnUtils.LogTrace, 'ClarifaiAPI.getTags(photoPath, model, language)');
  
  local tagAPIURL = tagAPIURLPrefix .. model .. tagAPIURLPostfix;
  
  local fileName = LrPathUtils.leafName(photoPath);

  local headers = {
    { field = 'Authorization', value = 'Key ' .. prefs.clarifai_apikey },
    { field = 'Content-Type', value = 'application/json'},
  };
  
  local f = io.open(photoPath, "rb");
  local content = f:read("*all");
  f:close();
  local b64enc = require('Base64').encode(content);
  KmnUtils.log(KmnUtils.LogTrace, b64enc);
  
  local body = {}
  body['inputs'] = {}
  local index = #body['inputs']+1
  body['inputs'][index] = {}
  body['inputs'][index]['data'] = {}
  body['inputs'][index]['data']['image'] = {}
  body['inputs'][index]['data']['image']['base64'] = b64enc
  
  body['model'] = {}
  body['model']['output_info'] = {}
  body['model']['output_info']['output_config'] = {}
  body['model']['output_info']['output_config']['language'] = language
  
  local jsonlib = require 'JSON'
  local jsonBody = jsonlib:encode(body)
 
  KmnUtils.log(KmnUtils.LogTrace, jsonBody)
 
  local body, reshdrs = LrHttp.post(tagAPIURL, jsonBody, headers)
  
  KmnUtils.log(KmnUtils.LogInfo, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogInfo, body);
  
  return JSON:decode(body);
end

function ClarifaiAPI.processTagsProbabilities(response)
  KmnUtils.log(KmnUtils.LogTrace, 'ClarifaiAPI.processTagsProbabilities(response)');
  -- Don't crash if we receive an empty response
  -- #response will always return 0, do the check the hard way
  local hasResponseValues = false;
  for _, tag in pairs(response) do
    hasResponseValues = true;
    break;
  end
  if not hasResponseValues then
    return {};
  end
  
  local processedTagsProbabilities = {}
  local tagNames = {}
  KmnUtils.log(KmnUtils.LogDebug, table.tostring(response))
  if response['status']['description'] ~= 'Ok' then
    LrDialogs.showError('Error processing tag probabilities. Please check your settings and try again. (' .. response['status'] .. ')');
  end
  for i, tag in ipairs(response['outputs'][1]['data']['concepts']) do
    KmnUtils.log(KmnUtils.LogTrace, table.tostring(tag))
    processedTagsProbabilities[#processedTagsProbabilities + 1] = { tag = tag['name'], probability = tag['value'], service = KmnUtils.SrvClarifai };
    tagNames[#tagNames + 1] = string.lower(tag['name']); -- Already in lower case for our use case
  end
  
  return processedTagsProbabilities, tagNames;
end

return ClarifaiAPI;
