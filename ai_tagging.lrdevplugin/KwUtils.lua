--[[----------------------------------------------------------------------------

KwUtils.lua
Utility functions for Lightroom Keywords

--------------------------------------------------------------------------------

    Copyright 2016 Lowell "LoweMo / LoMo" Montgomery
    https://lowemo.photo
    Latest version: https://lowemo.photo/lightroom-keyword-utils

    This file is used in a few Lightroom plugins.

    This code is released under a Creative Commons CC-BY "Attribution" License:
    http://creativecommons.org/licenses/by/3.0/deed.en_US

    This bundle may be used for any purpose, provided that the copyright notice
    and web-page links, above, as well as the 'AUTHOR_NOTE' and 'Attribution'
    strings, below are maintained. Enjoy.
------------------------------------------------------------------------------]]

local LUTILS = require 'LUTILS'
local KmnUtils = require 'KmnUtils'

local KwUtils = {}
KwUtils.catKws = nil
KwUtils.catKwPaths = nil

KwUtils.VERSION = 20161202.04 -- version history at end of file
KwUtils.AUTHOR_NOTE = "KwUtils.lua is a set of Lightroom keyword utility functions, © 2016 by Lowell Montgomery (https://lowemo.photo/lightroom-keyword-utils) version: " .. KwUtils.VERSION

-- The following provides an 80 character-width attribution text that can be inserted for display
-- in a plugin derived using these helper functions.
KwUtils.Attribution = "This plugin uses KwUtils, Lightroom keyword utilities, © 2016 by Lowell Montgomery\n (https://lowemo.photo/lightroom-keyword-utils) version: " .. KwUtils.VERSION .. "\n\nThis code is released under a Creative Commons CC-BY “Attribution” License:\n http://creativecommons.org/licenses/by/3.0/deed.en_US"

function KwUtils.addKeywordWithParents(photo, keyword)
    photo:addKeyword(keyword)
    local parent = keyword:getParent()
    if parent ~= nil then
        KwUtils.addKeywordWithParents(photo, parent)
    end
end

-- Call this function with just a keyword object. This recursively calls kw:getParent,
-- adding each parent to the table of parent keywords. When the top of the hierarchy
-- is reached, the "ancestry table" of keywords is returned.
function KwUtils.getAllParentKeywords(kw, parents)
    -- Set parents to empty table if not already existing
    parents = parents ~= nil and parents or {}
    local p = kw:getParent()
    if p ~= nil then
        parents[#parents+1] = p
        KwUtils.getAllParentKeywords(p, parents)
    end
    return parents
end

-- A photo may have keywords selected without the parent keywords actually being
-- selected. Although any parents not set to be suppressed on export will be
-- included during the export process, the photo will not show up in the library
-- if you filter by the such a term. This function explicitly adds all keyword parents.
function KwUtils.addAllKeywordParentsForPhoto(photo)
    local keywordsForPhoto = photo:getRawMetadata('keywords')

    local keywordsToAdd = {}
    for _,kw in ipairs(keywordsForPhoto) do
        local kwParents = KwUtils.getAllParentKeywords(kw)

        if (kwParents ~= nil) and (type(kwParents) == 'table') and (#kwParents ~= 0) then
            for _,parentKey in ipairs(kwParents) do
                if (not LUTILS.inTable(parentKey, keywordsForPhoto)) and (not LUTILS.inTable(parentKey, keywordsToAdd)) then
                    keywordsToAdd[#keywordsToAdd+1] = parentKey
                end
            end
        end
    end
    for _,kwToAdd in ipairs(keywordsToAdd) do
        photo:addKeyword(kwToAdd)
    end
    -- Return the keywords which have been added
    return keywordsToAdd
end

-- Add or remove a keyword based on the "state" of the associated checkbox.
-- Presumed is that we call this when the state differs from what is already on this image,
-- i.e. that the keyword is being changed for the photo (added or removed)
function KwUtils.addOrRemoveKeyword(photo, keyword, state)
    if state then
        KwUtils.addKeywordWithParents(photo, keyword)
    else
      -- We cannot assume parents should be removed if already there.
        photo:removeKeyword(keyword)
    end
end

--Returns array of keywords with a given name
function KwUtils.getAllKeywordsByName(name, keywords, found)
    found = found or {}
    if type(found) == 'LrKeyword' then
        found = {found}
        elseif type(found) ~= 'table' then
            found = {}
    end
    for i, kw in pairs(keywords) do
        -- If we have found the keyword we want, return it:
        if kw:getName() == name and LUTILS.inTable(kw, found) == false then
            found[#found + 1] = kw
        -- Otherwise, use recursion to check next level if kw has child keywords:
        else
            local kchildren = kw:getChildren()
            if #kchildren > 0 then
                found = KwUtils.getAllKeywordsByName(name, kchildren, found)
            end
        end
    end
    -- By now, we should have them all
    return found
end


-- Gets string representing a keywords parent names in hierarchical order, e.g.
-- "TOP_LEVEL_CATEGORY | second_level_parent | parent"
function KwUtils.getAncestryString(kw, ancestryString)
    ancestryString = ancestryString or ''
    local parent = kw:getParent()
    if parent ~= nil then
        ancestryString = parent:getName() .. " | " .. ancestryString
        ancestryString = KwUtils.getAncestryString(parent, ancestryString)
    end
    return ancestryString;
end

-- Return a comma-separated string listing all children of a term
function KwUtils.getChildrenString(kw)
    local childNamesTable = KwUtils.getKeywordChildNamesTable(kw)
    if #childNamesTable > 0 then
        return table.concat(childNamesTable, ", ")
    else return ""
    end
end

-- Find a keyword by a given name within a table of keyword objects
-- arg: lookfor  Name of keyword to search for
-- arg: keywordSet  Table of keywords, usually the top level keywords returned by Lightroom
-- API call to catalog:getKeywords(). If the sought keyword is not found
-- any "branches" of child terms are also examined (by recursive calls to this function)
function KwUtils.getKeywordByName(lookfor, keywordSet)
    for i, kw in pairs(keywordSet) do
        -- If we have found the keyword we want, return it:
        if kw:getName() == lookfor then
            return kw
        -- Otherwise, use recursion to check next level if kw has child keywords:
        else
            local kchildren = kw:getChildren()
            if kchildren and #kchildren > 0 then
                local nextkw = KwUtils.getKeywordByName(lookfor, kchildren)
                if nextkw ~= nil then
                    return nextkw
                end
            end
        end
    end
    -- If we have not returned the sought keyword, it's not there:
    return nil
end

--General Lightroom API helper functions for keywords
function KwUtils.getKeywordChildNamesTable(parentKey)
    local kchildren = parentKey:getChildren()
    local childNames = {}
    if kchildren and #kchildren > 0 then
       childNames = KwUtils.getKeywordNames(kchildren)
    end
    -- Return the table of child terms (empty if no child terms for passed keyword)
    return childNames
end

-- Get names of all Keyword objects in a table
-- lc is a flag to return all names in lower case.
function KwUtils.getKeywordNames(keywords, lc)
    local names = {}
    if type(keywords) == 'table' then
        for _,kw in ipairs(keywords) do
            if (lc) then
                names[#names+1] = string.lower(kw:getName())
            else
                names[#names+1] = kw:getName()                
            end
        end
    end
    return names
end


-- This is used by the KwUtils.findAllKeywords and allows skipping over branches that
-- would not be helpful for whatever purpose. A plugin does not NEED to implement
-- the ignore_keyword_branches preference. If it does not exist, we skip no branches,
-- just as if it did exist, but the field was empty.
function KwUtils.getIgnoreKeywordsTable()
    local prefs = import 'LrPrefs'.prefsForPlugin(_PLUGIN.id)
    local ignoreKeywordsList = ''
    if prefs.ignore_keyword_branches ~= nil then
        ignoreKeywordsList = prefs.ignore_keyword_branches
    end
    local ignoreKeysTable = LUTILS.split(ignoreKeywordsList, ', ')
    for i, kw in ipairs(ignoreKeysTable) do
        local val = LUTILS.trim(kw)
        if val == '' then
            ignoreKeysTable[i] = nil
        else
            ignoreKeysTable[i] = val
        end
    end
    return ignoreKeysTable
end

-- This function creates its own LrTasks.startAsyncTask() call and will run
-- as a background task that may yield. Be sure to check that the _G.AllKeys
-- variable exists before attempting to access its contents. (For this, you
-- could use LUTILS.waitForGlobal("AllKeys", timeout), which would time out after
-- timeout seconds if _G.AllKeys doesn't exist.
function KwUtils.getAllKeywords(force)
    local LrTasks = import 'LrTasks';
    LrTasks.startAsyncTask(function()
        local catalog = import 'LrApplication'.activeCatalog();
        if KwUtils.catKws == nil or force then
            KwUtils.catKws = {}
            KwUtils.catKwPaths = {}
            local topLevelKeywords = catalog:getKeywords()
            _G.AllKeys, _G.AllKeyPaths = KwUtils.findAllKeywords(topLevelKeywords)
        end
        return _G.AllKeys, _G.AllKeyPaths
    end)
end

-- Given a set of keywords (normally starting with a top level of a hierarchy),
-- get all keywords in the set with any child/descendant keywords) and populate
-- our top-level keyword table variables with data we can quickly use.
-- It has been extended to also collect the "ancestry path" for each keyword.
function KwUtils.findAllKeywords(keywords, kpath)
    kpath = kpath or ''
    local ignoreKeysTable = KwUtils.getIgnoreKeywordsTable()
    for _, kw in pairs(keywords) do
        local name = kw:getName()
      -- Skip any keywords (and descendants) listed in the ignoreKeysTable
        if not LUTILS.inTable(name, ignoreKeysTable) then
            local keyname = string.lower(name)
            if KwUtils.catKws[keyname] ~= nil then
                local count = #KwUtils.catKws[keyname]
                KwUtils.catKws[keyname][count + 1] = kw
                KwUtils.catKwPaths[keyname][count + 1] = kpath
            else
                KwUtils.catKws[keyname] = {kw}
                KwUtils.catKwPaths[keyname] = {kpath}
            end
            local kids = kw:getChildren()
            if kids and #kids > 0 then
                local new_kpath = kpath ~= '' and kpath .. ' | ' .. name or name
                KwUtils.findAllKeywords(kids, new_kpath)
            end
        end
    end
    return KwUtils.catKws, KwUtils.catKwPaths
end

-- Get number of keywords by a given name (adjusted to lower case) or false
-- if the keyword does not exist. This functionality depends on first running
-- KwUtils.findAllKeywords() to populate the catKws table.
function KwUtils.keywordByNameExists(keyName)
    KmnUtils.log(KmnUtils.LogTrace, 'KwUtils.keywordByNameExists(keyName)');
    -- Set ignoreCase flag to true, by default
    keyName = string.lower(keyName);
    if _G.AllKeys[keyName] ~= nil then
        -- Return the number of keywords by the passed name
        return #_G.AllKeys[keyName]
    end
    return false
end


-- Get existing keywords for a photo which are not in a given set (table)
function KwUtils.getOtherKeywords(photo, keywordNames)
    local photoKeywordList = photo:getFormattedMetadata('keywordTags')
    local photoKeywordNames = LUTILS.split(photoKeywordList, ', ')
    local ret = {}

    for _, keyName in ipairs(photoKeywordNames) do
        if not LUTILS.inTable(keyName, keywordNames) then
            ret[#ret + 1] = keyName
        end
    end
    return ret
end

-- Check for actual keyword (by keyword object, not name) associated with a photo
-- Given a catalog photo, check for the presence of any given keyword.
function KwUtils.hasKeywordById(photo, keyword)
    local keywordsForPhoto = photo:getRawMetadata('keywords')
	--Look for keyword object passed in array of Keyword objects.
    return LUTILS.inTable(keyword, keywordsForPhoto)
end

-- Check if photo already has a particular keyword (by name)
-- Converts all keywords to lower case before comparison which "ignores case"
function KwUtils.hasKeywordByName(photo, keywordName)
    local photoKeywordList = string.lower(photo:getFormattedMetadata('keywordTags'))
    local keywordNamesTable = LUTILS.split(photoKeywordList, ', ')
    return LUTILS.inTable(string.lower(keywordName), keywordNamesTable)
end

-- Here we return new variables for the reduced tables of keywords and keyword paths.
-- These can be assigned to _G.AllKeys, _G.AllKeyPaths or to new variables if plugin
-- logic dictates a later need for the full contents of the original global tables. 
function KwUtils.trimKeywordTablesToKeys(keys)
    local newKeys = {};
    local newKeyPaths = {};
    for _,k in pairs(keys) do
        if (_G.AllKeys[k] ~= nil) then
            newKeys[k] = _G.AllKeys[k];
            newKeyPaths[k] = _G.AllKeyPaths[k];
        end
    end
    return newKeys, newKeyPaths;    
end

return KwUtils

-- 20161101.01 Initial release.
--    It includes functions I had found myself writing and re-writing in various plugins.
-- 20161122.02 Minor tweaks and bugfixes; not yet officially released, so will not itemize changes
-- 20161126.03 Moved more logic into the KwUtils. It is no longer a local bundle, so this may have ramifications for memory
--             etc, but allows us to call "expenive" processes (new findAllKeywords() / getAllKeywords() functionality) and
--             hopefully be able to access the results from other scripts in a plugin. Still "pre-release"
-- 20161202.04 Moved more logic here for populating global keyword tables (_G.AllKeys and _G.AllKeyPaths)
--             as well as a new utility function, trimKeywordTablesToKeys, and other small improvements.
