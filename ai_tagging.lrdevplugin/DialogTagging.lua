--[[----------------------------------------------------------------------------

DialogTagging.lua
Builds the tagging dialog that is shown at the end of export

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

local LrApplication = import 'LrApplication'
local LrView = import 'LrView'
local LrBinding = import 'LrBinding'
local LrDialogs = import 'LrDialogs'
local LrFunctionContext = import 'LrFunctionContext'
local LrPathUtils = import 'LrPathUtils'
local LrPrefs = import 'LrPrefs'
local LrTasks = import 'LrTasks'
local KmnUtils = require 'KmnUtils'
local ClarifaiAPI = require 'ClarifaiAPI'

local prefs = LrPrefs.prefsForPlugin();

local vf = LrView.osFactory();
local bind = LrView.bind;
local share = LrView.share

local DialogTagging = {};

function DialogTagging.buildTagGroup(photo, tags, propertyTable)
  local tagRows = {};
  
  KmnUtils.log(KmnUtils.LogTrace, prefs.sort);
  
  if prefs.sort == KmnUtils.SortProb then
    table.sort(tags, function(a, b) 
                        if (a.probability > b.probability) then
                          return true;
                        end
                        return false;
                     end
    );
  elseif prefs.sort == KmnUtils.SortAlpha then
    table.sort(tags, function(a, b) 
                        if (a.tag < b.tag) then
                          return true;
                        end
                        return false;
                     end
    );
  end
  
  for i=1, #tags do
    local tagName = tags[i]['tag'];
    local fontString = '<system>';
    local tagRow = {};
    
    propertyTable[tagName] = false;
    
    if KmnUtils.photoHasKeyword(photo, tagName) then
      if prefs.bold_existing_tags then
        fontString = '<system/bold>'
      end
      propertyTable[tagName] = true;
    end
    
    tagRow[#tagRow + 1] = vf:checkbox {
      bind_to_object = propertyTable,
      title = tagName,
      font = fontString,
      checked_value = true,
      unchecked_value = false,
      value = bind(tagName),
    };
    
    if prefs.tag_window_show_probabilities then 
      tagRow[#tagRow + 1] = vf:static_text {
        title = string.format('(%2.1f)', tags[i]['probability'] * 100),
      };
    end
    
    tagRows[#tagRows + 1] = vf:row(tagRow);
  end
  
  tagRows['title'] = 'Tags/Probabilities';
  
  return vf:group_box(tagRows);
end

function DialogTagging.buildColumn(context, exportParams, properties, photo, tags, processedTags)
  local contents = {};
  
  local photoTitle = photo:getFormattedMetadata 'title';
  if ( not photoTitle or #photoTitle == 0 ) then
    photoTitle = LrPathUtils.leafName( photo.path );
  end
  
  contents[#contents + 1] = vf:row {
    vf:static_text {
      title = photoTitle,
      font = '<system/bold>',
    }
  };
  
  contents[#contents + 1] = vf:row {
    vf:catalog_photo {
      photo = photo,
      width = prefs.thumbnail_size,
      height = prefs.thumbnail_size,
    }
  };
  
  contents[#contents + 1] = vf:row {
    vf:group_box {
      title = 'API Settings',
      vf:row {
        vf:static_text {
          title = 'Model',
          font = '<system/bold>'
        },
        vf:static_text {
          title = tags.meta.tag.model
        }
      },
      vf:row {
        vf:static_text {
          title = 'Language',
          font = '<system/bold>'
        },
        vf:static_text {
          title = exportParams.clarifai_language
        },
      },
    }
  };
  
  local imageProperties = LrBinding.makePropertyTable(context);
  properties[photo] = imageProperties;
  
  contents[#contents + 1] = DialogTagging.buildTagGroup(photo, processedTags, imageProperties);
  
  contents['height'] = prefs.tag_window_height - 50;
  contents['horizontal_scroller'] = false;
  contents['vertical_scroller'] = true;
  return vf:column {
    vf:scrolled_view(contents)
  };
end

function DialogTagging.buildDialog(photosToTag, exportParams)
  LrFunctionContext.callWithContext('DialogTagger', function(context)
    local properties = {};
    local columns = {};
    
    local processedTags = {};
    
    for photo,tags in pairs(photosToTag) do
      local photoProcessedTags = ClarifaiAPI.processTagsProbibilities(tags);
      processedTags[photo] = photoProcessedTags;
      columns[#columns + 1] = DialogTagging.buildColumn(context, exportParams, properties, photo, tags, photoProcessedTags);
    end
  
    local contents = vf:scrolled_view {
        width = prefs.tag_window_width,
        height = prefs.tag_window_height,
        horizontal_scroller = true,
        vertical_scroller = false,
        vf:row(columns)
    };
    
    local result = LrDialogs.presentModalDialog({
      title = 'Computer Vission Tagging',
      contents = contents,
      resizeable = true,
    });
    
    if result == 'ok' then
      for photo, tagvalues in pairs(properties) do
        for _, taginfo in ipairs(processedTags[photo]) do
          local catalog = LrApplication.activeCatalog();
          local catalogKeywords = catalog:getKeywords();
          local newKeywords = {};
          
          catalog:withWriteAccessDo('writePhotosKeywords', function(context)
            if tagvalues[taginfo.tag] ~= KmnUtils.photoHasKeyword(photo, taginfo.tag) then
              local keyword = catalog:createKeyword(taginfo.tag, {}, false, nil, true);
              if keyword == false then -- This keyword was created in the current withWriteAccessDo block, so we can't get by using `returnExisting`.
                keyword = newKeywords[taginfo.tag];
              else
                newKeywords[taginfo.tag] = keyword;
              end
              
              if tagvalues[taginfo.tag] then
                photo:addKeyword(keyword);
              else
                photo:removeKeyword(keyword);
              end
            end
          end);
        end
      end
    end
  end);
end

return DialogTagging;
