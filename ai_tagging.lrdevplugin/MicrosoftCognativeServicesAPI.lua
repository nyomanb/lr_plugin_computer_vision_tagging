--[[----------------------------------------------------------------------------

MicrosoftCognativeServices.lua
Microsoft Cognative Services API implementation(s)

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

local LrHttp = import 'LrHttp'
local LrTasks = import 'LrTasks'
local LrPathUtils = import 'LrPathUtils'
local LrStringUtils = import 'LrStringUtils'
local LrDialogs = import 'LrDialogs'
local JSON = require 'JSON'
local KmnUtils = require 'KmnUtils'

local computerVisionAPIURL = 'https://api.projectoxford.ai/vision/v1.0/analyze'
local emotionAPIURL = 'https://api.projectoxford.ai/emotion/v1.0/recognize'
local faceAPIURL = 'https://api.projectoxford.ai/face/v1.0/detect'

local prefs = import 'LrPrefs'.prefsForPlugin(_PLUGIN.id)

MicrosoftCognativeServicesAPI = {}

function MicrosoftCognativeServicesAPI.detectEmotion(photoPath)
  KmnUtils.log(KmnUtils.LogTrace, 'MicrosoftCognativeServicesAPI.detectEmotion(photoPath)');

  local fileName = LrPathUtils.leafName(photoPath);
  local file = io.open(photoPath, 'rb'); -- binary read mode
  local fileData = file:read("*all");
  file:close();

  local headers = {
    { field = 'Content-Type', value = 'application/octet-stream' },
    { field = 'Ocp-Apim-Subscription-Key', value = prefs.ms_key_emotion },
  };
  
  local body, reshdrs = LrHttp.post(emotionAPIURL, fileData, headers);
  
  KmnUtils.log(KmnUtils.LogTrace, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogTrace, body);
  
  return JSON:decode(body);
end

function MicrosoftCognativeServicesAPI.computerVision(photoPath, enableCategories, enableTags, enableDescription, enableFaces, enableImageType, enableColor, enableAdult, enableCelebs)
  KmnUtils.log(KmnUtils.LogTrace, 'MicrosoftCognativeServicesAPI.computerVision(photoPath, enableCategories, enableTags, enableDescription, enableFaces, enableImageType, enableColor, enableAdult, enableCelebs)');
  
  local fileName = LrPathUtils.leafName(photoPath);
  local parameterizedURL = computerVisionAPIURL;
  
  if enableCategories or enableTags or enableDescription or enableFaces or enableImageType or enableColor or enableAdult or enableCelebs then
    parameterizedURL = parameterizedURL .. '?';
  end
  
  local needsAmper = false;
  
  if enableCategories or enableTags or enableDescription or enableFaces or enableImageType or enableColor or enableAdult then
    needsAmper = true;
    local needsComma = false;
    parameterizedURL = parameterizedURL .. 'visualFeatures=';
    if enableCategories then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL ..'Categories';
    end
    if enableTags then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'Tags';
    end
    if enableDescription then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'Description';
    end
    if enableFaces then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'Faces';
    end
    if enableImageType then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'ImageType';
    end
    if enableColor then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'Color';
    end
    if enableAdult then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'Adult';
    end
  end
  
  if enableCelebs then
    if needsAmper then
      parameterizedURL = parameterizedURL .. '&';
    end
    parameterizedURL = parameterizedURL .. 'details=Celebrities';
  end

  local headers = {
    { field = 'Ocp-Apim-Subscription-Key', value = prefs.ms_key_computervision },
  };
  
  local mimeChunks = {
    { name = 'form-data', fileName = fileName, filePath = photoPath, contentType = 'application/octet-stream' };
  };
  
  KmnUtils.log(KmnUtils.LogTrace, parameterizedURL);

  local body, reshdrs = LrHttp.postMultipart(parameterizedURL, mimeChunks, headers);
  
  KmnUtils.log(KmnUtils.LogTrace, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogTrace, body);
  
  return JSON:decode(body);
end

function MicrosoftCognativeServicesAPI.processVisionTagsProbabilities(response)
  KmnUtils.log(KmnUtils.LogTrace, 'MicrosoftCognativeServicesAPI.processVisionTagsProbabilities(response)');
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
  if _unexpected_condition then
    LrDialogs.showError('Error processing tag probabilities. Please check your settings and try again');
  end
  if response['tags'] ~= nil then
    for i, tag in ipairs(response['tags']) do
      processedTagsProbabilities[#processedTagsProbabilities + 1] = { tag = tag['name'], probability = tag['confidence'], service = KmnUtils.SrvMSVision };
      tagNames[#tagNames + 1] = string.lower(tag['name']); -- Already in lower case for our use case
    end
  end
  
  KmnUtils.log(KmnUtils.LogTrace, table.tostring(processedTagsProbabilities))
  
  return processedTagsProbabilities, tagNames;
end

function MicrosoftCognativeServicesAPI.detectFace(photoPath, enableFaceIds, enableLandmarks, enableAge, enableGender, enableHeadPose, enableSmile, enableFacialHair, enableGlasses)
  KmnUtils.log(KmnUtils.LogTrace, 'MicrosoftCognativeServicesAPI.detectFace(photoPath, enableFaceIds, enableLandmarks, enableAge, enableGender, enableHeadPose, enableSmile, enableFacialHair, enableGlasses)');
  
  local parameterizedURL = faceAPIURL .. '?';
  
  parameterizedURL = parameterizedURL .. 'returnFaceId=' .. KmnUtils.bool_to_string(enableFaceIds);
  parameterizedURL = parameterizedURL .. '&';
  parameterizedURL = parameterizedURL .. 'returnFaceLandmarks=' .. KmnUtils.bool_to_string(enableLandmarks);
  
  if enableAge or enableGender or enableHeadPose or enableSmile or enableFacialHair or enableGlasses then
    parameterizedURL = parameterizedURL .. '&returnFaceAttributes=';
    
    local needsComma = false;
    if enableAge then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL ..'age';
    end
    if enableGender then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'gender';
    end
    if enableHeadPose then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'headPose';
    end
    if enableSmile then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'smile';
    end
    if enableFacialHair then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'facialHair';
    end
    if enableGlasses then
      if needsComma then
        parameterizedURL = parameterizedURL .. ',';
      end
      needsComma = true;
      parameterizedURL = parameterizedURL .. 'glasses';
    end
  end

  KmnUtils.log(KmnUtils.LogTrace, parameterizedURL);

  local fileName = LrPathUtils.leafName(photoPath);
  local file = io.open(photoPath, 'rb'); -- binary read mode
  local fileData = file:read("*all");
  file:close();

  local headers = {
    { field = 'Content-Type', value = 'application/octet-stream' },
    { field = 'Ocp-Apim-Subscription-Key', value = prefs.ms_key_face },
  };
  
  local body, reshdrs = LrHttp.post(parameterizedURL, fileData, headers);
  
  KmnUtils.log(KmnUtils.LogTrace, table.tostring(reshdrs));
  KmnUtils.log(KmnUtils.LogTrace, body);
  
  return JSON:decode(body);
end

return MicrosoftCognativeServicesAPI;
