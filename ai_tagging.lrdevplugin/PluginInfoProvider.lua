--[[----------------------------------------------------------------------------

PluginInfoProvider.lua
Plugin settings / info UI

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
local LrBinding = import 'LrBinding'
local LrFunctionContext = import 'LrFunctionContext'
local LrView = import 'LrView'
local LrColor = import 'LrColor'
local PlugInfo = require 'Info'
local KmnUtils = require 'KmnUtils'
local ClarifaiAPI = require 'ClarifaiAPI'

local prefs = LrPrefs.prefsForPlugin();
local get_token_success = false;

-- Setup observer pattern so results of verification of API can be marked success/fail
local get_info_result;
LrFunctionContext.callWithContext("get_info_result_table", function( context )
  get_info_result = LrBinding.makePropertyTable( context );
  get_info_result.message = 'Success';
  get_info_result.color = LrColor('green');
  get_info_result.visible = false;
end)

local function sectionsForTopOfDialog(viewFactory, properties)
  -- Ensure debug checkbox is not showing the odd icon for default value
  -- TODO: Make sure this is actually doing something and having an affect; if not -- fix
  if prefs.debug == nil then
    prefs.debug = false;
  end
  
  local vf = viewFactory;
  local bind = LrView.bind;
  
  return {
    {
      title = LOC '$$$/ComputerVisionTagging/Preferences/Info=Computer Vision Tagging Plugin',
      vf:row {
        spacing = vf:control_spacing(),
        vf:static_text {
          title = LOC '$$$/ComputerVisionTagging/Preferences/Version=Version',
        },
        vf:edit_field {
          enabled = false,
          value = PlugInfo.VERSION.display,
        }
      },
    },
    {
      title = LOC '$$$/ComputerVisionTagging/Preferences/Global=Global',
      bind_to_object = prefs,
      vf:row {
        spacing = vf:control_spacing(),
        vf:checkbox {
          title = '',
          checked_value = true,
          unchecked_value = false,
          value = bind 'debug',
        },
        vf:static_text {
          title = LOC '$$$/ComputerVisionTagging/Preferences/Global/DebugLog=Enable Debug Log',
        },
      },
    },
    {
      title = LOC '$$$/ComputerVisionTagging/Preferences/ClarifaiSettings=Clarifai Settings',
      bind_to_object = prefs,
      vf:row {
        spacing = vf:control_spacing(),
        vf:static_text {
          title = LOC '$$$/ComputerVisionTagging/Preferences/ClarifaiSettings/ClientID=Client ID',
        },
        vf:edit_field {
          fill_horizonal = true,
          width_in_chars = 35,
          value = bind 'clarifai_clientid',
        },
      },
      vf:row {
        spacing = vf:control_spacing(),
        vf:static_text {
          title = LOC '$$$/ComputerVisionTagging/Preferences/ClarifaiSettings/ClientSecret=Client Secret',
        },
        vf:password_field {
          fill_horizontal = true,
          width_in_chars = 35,
          value = bind 'clarifai_clientsecret',
        },
      },
      vf:row {
        spacing = vf:control_spacing(),
        vf:static_text {
          title = LOC '$$$/ComputerVisionTagging/Preferences/ClarifaiSettings/AccessToken=Access Token',
        },
        vf:edit_field {
          enabled = false,
          fill_horizontal = true,
          width_in_chars = 35,
          value = bind 'clarifai_accesstoken',
        },
      },
      vf:row {
        spacing = vf:control_spacing(),
        vf:push_button {
          title = LOC '$$$/ComputerVisionTagging/Preferences/ClarifaiSettings/VerifySettings=Verify Settings',
          action = function(button)
                      LrFunctionContext.postAsyncTaskWithContext('ClarifaiSettings.VerifySettingsButton', function()
                        local clarifaiInfo = ClarifaiAPI.getInfo();
                        if clarifaiInfo ~= nil then
                          get_info_result.message = 'Success';
                          get_info_result.color = LrColor('green');
                        else
                          get_info_result.message = 'Failure';
                          get_info_result.color = LrColor('red');
                        end
                        get_info_result.visible = true;
                      end); 
                   end
        },
        vf:push_button {
          title = LOC '$$$/ComputerVisionTagging/Preferences/ClarifaiSettings/GenerateAccessToken=Generate New Access Token',
          action = function(button)
                      ClarifaiAPI.getToken()
                   end
        },
      },
      vf:row {
        spacing = vf:label_spacing(),
        vf:static_text {
          bind_to_object = get_info_result,
          title = bind 'message',
          text_color = bind 'color',
          visible = bind 'visible',
        },
      },
    },
  }
end

local function sectionsForBottomOfDialog(viewFactory, properties)
  local vf = viewFactory;
  
  return {
    {
      title = LOC '$$$/ComputerVisionTagging/Preferences/Acknowledgements=Acknowledgements',

      vf:static_text {
        title = LOC '$$$/ComputerVisionTagging/Preferences/SimpleJSON=Simple JSON',
      },
      vf:edit_field {
        width_in_chars = 80,
        height_in_lines = 9,
        enabled = false,
        value = 'Simple JSON encoding and decoding in pure Lua.\n\nCopyright 2010-2016 Jeffrey Friedl\nhttp://regex.info/blog/\n\nLatest version: http://regex.info/blog/lua/json\n\nThis code is released under a Creative Commons CC-BY "Attribution" License:\nhttp://creativecommons.org/licenses/by/3.0/deed.en_US\n'
      }
    }
  }
end

local function endDialog(properties)
  -- Ensure logging is turned on/off if pref changed
  KmnUtils.enableDisableLogging();
  
  -- Generate Clarifai access token if it's missing/empty
  if prefs.clarifai_accesstoken == nil or prefs.clarifai_accesstoken == '' then
    ClarifaiAPI.getToken();
   end
end


return {
  sectionsForTopOfDialog = sectionsForTopOfDialog,
  sectionsForBottomOfDialog = sectionsForBottomOfDialog,
  endDialog = endDialog,
}
