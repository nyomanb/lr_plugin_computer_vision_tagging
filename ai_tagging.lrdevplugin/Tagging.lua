--[[----------------------------------------------------------------------------

Tagging.lua
Various tagging functionality / features

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
-- local Require = require 'Require'.path("../../debugscript.lrdevplugin")
-- local Debug = require 'Debug'.init()
-- require 'strict'

local LrApplication = import 'LrApplication'
local LrProgressScope = import 'LrProgressScope'
local KmnUtils = require 'KmnUtils'
local KwUtils = require 'KwUtils'
local LUTILS = require 'LUTILS'

local prefs = import 'LrPrefs'.prefsForPlugin(_PLUGIN.id)

Tagging = {}

function Tagging.tagPhotos(tagsByPhoto, tagSelectionsByPhoto, parentProgress)
  KmnUtils.log(KmnUtils.LogTrace, 'Tagging.tagPhotos(tagsByPhoto, tagSelectionsByPhoto, parentProgress)');
  -- KmnUtils.log(KmnUtils.LogTrace, table.tostring(tagsByPhoto));
  -- KmnUtils.log(KmnUtils.LogTrace, table.tostring(tagSelectionsByPhoto));

  local taggingProgress = LrProgressScope({ title = 'Tagging photo(s)', parent = parentProgress });
  local numPhotosToProcess = 0;
  local photosProcessed = 0;
  
  -- For some reason #tagsByPhoto doesn't work, count the total the hard way
  for _, __ in pairs(tagsByPhoto) do
    numPhotosToProcess = numPhotosToProcess + 1;
  end
  
  KmnUtils.log(KmnUtils.LogDebug, '# images to tag: ' .. numPhotosToProcess);
  
  local catalog = LrApplication.activeCatalog();
  local newKeywords = {};
  
  catalog:withWriteAccessDo('writePhotosKeywords', function(context)
    local parent_keyword = nil
    if prefs.parent_tag ~= '' then
      KmnUtils.log(KmnUtils.LogDebug, 'Parent tag: ' .. prefs.parent_tag)
      parent_keyword = catalog:createKeyword(prefs.parent_tag, {}, false, nil, true);
    end
  
    for photo, tags in pairs(tagsByPhoto) do
      if taggingProgress:isCanceled() then
        break;
      end

      local existingPhotoKeywordString = photo:getFormattedMetadata('keywordTags');
      local existingPhotoKeywordNames = LUTILS.split(existingPhotoKeywordString, ', ');
      local existingPhotoKeywordNamesLower = LUTILS.split(string.lower(existingPhotoKeywordString), ', ');
    
      taggingProgress:setPortionComplete( photosProcessed, numPhotosToProcess );
      parentProgress:setCaption('Tagging ' .. photo:getFormattedMetadata( 'fileName' ));
    
      KmnUtils.log(KmnUtils.LogDebug, 'Tagging ' .. photo:getFormattedMetadata( 'fileName' ));
    
      for tag, taginfo in pairs(tags) do
        local tagName = taginfo.tag;
        local tagLower = string.lower(tagName)
        local keywordsByName = _G.AllKeys[tagLower]
        local numKeysByName = keywordsByName ~= nil and #keywordsByName or 0
        -- First deal with the issue of adding a keyword that was not in the Lightroom library before:
        if numKeysByName == 0 then
          local checkboxState = tagSelectionsByPhoto[photo][tagName][1];
          if checkboxState == true then
            -- catalog:createKeyword( keywordName, synonyms, includeOnExport, parent, returnExisting )
            local keyword = catalog:createKeyword(tagName, {}, true, parent_keyword, true);
            if keyword == false then -- This keyword was created in the current withWriteAccessDo block, so we can't get by using `returnExisting`.
              keyword = newKeywords[tagName];
            else
              newKeywords[tagName] = keyword;
            end
            photo:addKeyword(keyword)
          end
        else
          for i=1, numKeysByName do
            local checkboxState = tagSelectionsByPhoto[photo][tagName][i];
            local keyword = _G.AllKeys[tagLower][i];
            if numKeysByName == 1 and (checkboxState ~= LUTILS.inTable(tagLower, existingPhotoKeywordNamesLower)) then
				if prefs.tag_add_keyword_parents then KwUtils.addOrRemoveKeyword(photo, keyword, checkboxState)
				else KwUtils.addOrRemoveKeywordWithoutParents(photo, keyword, checkboxState) end
			elseif numKeysByName > 1 then
            -- We need to use more accurate (less performant) means to verify the actual keyword
            -- is (or is not) already associated with the photo.
              if checkboxState ~= KwUtils.hasKeywordById(photo, keyword) then
                if prefs.tag_add_keyword_parents then KwUtils.addOrRemoveKeyword(photo, keyword, checkboxState)
				else KwUtils.addOrRemoveKeywordWithoutParents(photo, keyword, checkboxState) end
              end
            end
          end
        end
      end
      photosProcessed = photosProcessed + 1;
    end
  end);
  taggingProgress:done();
end

return Tagging;
