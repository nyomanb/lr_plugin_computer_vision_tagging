--[[----------------------------------------------------------------------------

ExportServiceProvider.lua
Define the export process for submitting photos to APIs

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
local LrView = import 'LrView'
local LrBinding = import 'LrBinding'
local LrPathUtils = import 'LrPathUtils'
local LrFileUtils = import 'LrFileUtils'
local KmnUtils = require 'KmnUtils'

local prefs = LrPrefs.prefsForPlugin();

local exportServiceProvider = {}
-- FIXME: Add 'exportLocation' to hideSections
exportServiceProvider.hideSections = { 'fileNaming', 'fileSettings', 'imageSettings', 'video' }
exportServiceProvider.hidePrintResolution = true
exportServiceProvider.canExportToTemporaryLocation = true
exportServiceProvider.canExportVideo = false
exportServiceProvider.exportPresetFields = {
  { key = 'global_size_mpx', default = 2 },
  { key = 'global_jpeg_quality', default = 50 },
  { key = 'clarifai_model', default = 'general-v1.3' },
  { key = 'clarifai_language', default = 'en' },
}

function exportServiceProvider.sectionsForTopOfDialog( vf, propertyTable )
  local bind = LrView.bind;
  
  return {
    {
      title = LOC '$$$/ComputerVisionTagging/ExportDialog/Global=Global Settings',
      vf:row {
        vf:static_text {
          title = 'Size (Mpx)',
          tooltip = 'Size of the image to send in megapixels',
        },
        vf:edit_field {
          value = bind 'global_size_mpx',
          width_in_digits = 3,
          tooltip = 'Size of the image to send in megapixels',
        },
      },
      vf:row {
        vf:static_text {
          title = 'JPEG Quality',
          tooltip = 'Quality of the JPEG to send'
        },
        vf:slider {
          value = bind 'global_jpeg_quality',
          min = 15,
          max = 100,
          integral = true,
          tooltip = 'Quality of the JPEG to send'
        },
        vf:static_text {
          title = bind 'global_jpeg_quality',
          tooltip = 'Quality of the JPEG to send'
        }
      },
    },
    {
      title = LOC "$$$/ComputerVisionTagging/ExportDialog/Clarifai=Clarifai Settings",
      vf:row {
        vf:static_text {
          title = 'Model',
          tooltip = 'The Clarifai model to use for submissions'
        },
        vf:popup_menu {
          value = bind 'clarifai_model',
          tooltip = 'The Clarifai model to use for submissions',
          items = {
            { value = 'general-v1.3', title = 'General' },
            { value = 'nsfw-v1.0', title = 'NSFW' },
            { value = 'weddings-v1.0', title = 'Weddings' },
            { value = 'travel-v1.0', title = 'Travel' },
            { value = 'food-items-v1.0', title = 'Food Items' },
          },
        },
      },
      vf:row {
        vf:static_text {
          title = 'Language',
          tooltip = 'The language to use for Clarifai responses',
        },
        vf:popup_menu {
          value = bind 'clarifai_language',
          tooltip = 'The language to use for Clarifai responses',
          items = {
            { value = 'en', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/English=English (en)' },
            { value = 'zh', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/ChineseSimplified=Chinese Simplified (zh)' },
            { value = 'it', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Italian=Italian (it)' },
            { value = 'ar', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Arabic=Arabic (ar)' },
            { value = 'es', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Spanish=Spanish (es)' },
            { value = 'ru', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Russian=Russian (ru)' },
            { value = 'nl', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Dutch=Dutch (nl)' },
            { value = 'pt', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Portuguese=Portuguese (pt)' },
            { value = 'no', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Norwegian=Norwegian (no)' },
            { value = 'tr', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Turkish=Turkish (tr)' },
            { value = 'pa', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Punjabi=Punjabi (pa)' },
            { value = 'pl', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Polish=Polish (pl)' },
            { value = 'fr', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/French=French (fr)' },
            { value = 'bn', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Bengali=Bengali (bn)' },
            { value = 'de', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/German=German (de)' },
            { value = 'da', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Danish=Danish (da)' },
            { value = 'hi', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Hindi=Hindi (hi)' },
            { value = 'fi', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Finnish=Finnish (fi)' },
            { value = 'hu', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Hungarian=Hungarian (hu)' },
            { value = 'ja', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Japanese=Japanese (ja)' },
            { value = 'zh-TW', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/ChineseTraditional=Chinese Traditional (zh-TW)' },
            { value = 'ko', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Korean=Korean (ko)' },
            { value = 'sv', title = LOC '$$$/ComputerVisionTagging/ExportDialog/ClarifaiLanguage/Swedish=Swedish (sv)' },
          },
        },
      },
    }
  }
end

function exportServiceProvider.updateExportSettings( exportSettings )
  -- Ensure these files never get saved
  --exportSettings.LR_export_destinationType = 'tempFolder';
  -- APIs use JPEGs, ensure sending the right type
  exportSettings.LR_format = 'JPEG';
  -- Ensure image is resized down (if necessary)
  exportSettings.LR_size_doConstrain = true;
  --LR_size_maxHeight / LR_size_maxWidth not necessary, use megapixel resize option built into LightRoom
  exportSettings.LR_size_megapixels = exportSettings.global_size_mpx;
  exportSettings.LR_size_resizeType = 'megapixels';
  -- Ensure image quality is set properly
  exportSettings.LR_jpeg_quality = exportSettings.global_jpeg_quality / 100.0;
  -- We don't want to scale an image up in size, override defaults
  exportSettings.LR_size_doNotEnlarge = true;
end

function exportServiceProvider.processRenderedPhotos( functionContext, exportContext )
  local exportSession = exportContext.exportSession;
  local exportParams = exportContext.propertyTable;
  
  local clarifai_model = exportParams.clarifai_model;
  local clarifai_language = exportParams.clarifai_language;
    
  local nPhotos = exportSession:countRenditions();
  
  local progressScope = exportContext:configureProgress {
            title = nPhotos > 1
                 and LOC( "$$$/ComputerVisionTagging/Upload/Progress=Uploading ^1 photos for computer vision", nPhotos )
                 or LOC "$$$/ComputerVisionTagging/Upload/Progress/One=Uploading one photo for computer vision",
          };
  
  local failures = {};
  
  for _, rendition in exportContext:renditions{ stopIfCanceled = true } do
    local success, pathOrMessage = rendition:waitForRender()
    
    if progressScope:isCanceled() then break end
    
    if success then
      local success = true; -- FIXME: Upload to API's goes here
      
      if not success then
        table.insert( failures, filename );
      end
      
      -- When done with photo, delete temp file. There is a cleanup step that happens later,
      -- but this will help manage space in the event of a large upload.
      LrFileUtils.delete( pathOrMessage );
    end
  end
  
  if #failures > 0 then
    local message
    if #failures == 1 then
      message = LOC "$$$/ComputerVisionTagging/Upload/Errors/OneFileFailed=1 file failed to upload correctly.";
    else
      message = LOC ( "$$$/ComputerVisionTagging/Upload/Errors/SomeFileFailed=^1 files failed to upload correctly.", #failures );
    end
    LrDialogs.message( message, table.concat( failures, "\n" ) );
  end
end

return exportServiceProvider
