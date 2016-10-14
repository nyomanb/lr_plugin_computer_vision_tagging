--[[----------------------------------------------------------------------------

InitPlugin.lua
What to do when plugin is loaded?

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

local KmnUtils = require 'KmnUtils'
KmnUtils.enableDisableLogging()

local prefs = import 'LrPrefs'.prefsForPlugin(_PLUGIN.id)
-- Provide initial default values for plugin preferences.

local defaultPrefValues = {
   
   clarifai_clientsecret = '',
   clarifai_clientid = '',
   log_level = KmnUtils.LogError,
   KmnUtils.SortProb,
   thumbnail_size = 256,
   tag_window_width = 1024,
   tag_window_height = 768,
   tag_window_show_probabilities = true,
   bold_existing_tags = true,
   -- auto_select_probability_level = 85,
   -- ignore_keyword_branches = '',
   -- auto_select_existing_keywords = true,
}

for k,v in pairs(defaultPrefValues) do
   if prefs[k] == nil then prefs[k] = v end
end

