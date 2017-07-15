---
layout: page
title: Changelog
subtitle: Changes / updates / fixes by phase
---

# Phase Fixes - Small Bug Fix
- [X] Fixed bug that prevented use when API token expired

# Phase Fixes - Fixes / Misc Updates
- [X] Fixed bug that prevented plugin from running twice in a row
- [X] Minor debugging code added
- [X] Minor code formatting updates

# Phase 11.5 - Fixes / Features
- [X] Fixed keywords/tags not being included on export
- [X] Added ability to specify parent keyword/tag for any created during CVT processing (hierarcy/hierarchical)

# Phase Contrib - Lowell Montgomery Contributions
- [X] Merge support for keyword hierarchies (By Lowell Montgomery)
- [X] Merge misc fixes / updates (By Lowell Montgomery)

# Phase GitHub Misc - Misc GitHub issues fixed/addressed
- [X] Add group to bottom of tagging dialog columns with the existing keywords for a photo (GitHub #9)
- [X] Add add button that opens a dialog with a larger version of the image in Tagging Dialog. Dialog size is tunable via preferences (GitHub #10)
- [X] Add debugging support via http://www.johnrellis.com/lightroom/debugging-toolkit.htm (GitHub #12)

# Phase Fixes - Fix Recursion Guard Error
- [X] Fix error when Clarifai API token expires (GitHub Issue #7)
- [X] Version Bump
- [X] Update Project Plan
- [X] Post on docs site

# Phase Docs - Docs/website updates
- [X] Basic usage of menu items (File/Help)
- [X] Basic walk through of photo submissions and tagging
- [X] Full walk through of Lightroom plugin preferences
- [X] Full walk through of export settings
- [X] Full walk through of tagging dialog

# Phase Docs - Docs/website updates
- [X] Enhance Install/Setup documentation
- [X] Clarifai API setup (account, app creation, plugin prefs) documentation

# Phase 12 - Features
- [X] Add ability to clear Clarifai access token
- [X] Add links to website/releases/etc to preferences

# Phase 11 - Feature, Misc Updates
- [X] Branch
- [X] Minor preference/export dialog UI cleanup
- [X] Move tag auto selection to export preferences
- [X] Show service(s) that a tag was suggested by in tagging dialog
- [X] Export option to only send to selected services (checkboxes for each configured service)
- [X] Dialog UI cleanup
- [X] Version Bump
- [X] Update Project Plan
- [X] Post on docs site

# Phase Fixes - Fix 'Verify Settings' button in prefs
- [X] Fix 'Verify Settings' button in Clarifai section of preferences
- [X] Version Bump
- [X] Update Project Plan
- [X] Post on docs site

# Phase GH Issue #3 - Bug fix + Auto select tags with minimum p value
- [X] Branch phase_gh_3
- [X] Fix recursion guard error
- [X] Auto select tags with minimum p value
- [X] Version Bump
- [X] Update Project Plan
- [X] Post on docs site

# Phase OSX - Various fixes for OSX compatibility
- [X] Convert sources to UTF8 encoding
- [X] Convert sources to Unix line endings
- [X] Remove auto generation of Clarifai API token when closing preferences dialog
- [X] Fix plugin preferences so they no longer use an invalid option on OSX

# Phase Fixes - Various fixes related to first launch/post install
- [X] Fixup preference defaults
- [X] Fixup showing preferences after fresh install
- [X] Fixup menu item errors when no valid API keys setup
- [X] Fixup export API usage if API isn't setup
- [X] Fixup tagging dialog if no tags returned for photos
- [X] Version bump

# Phase Docs - Docs/website updates
- [X] Finalize gh-pages branch / theme / etc
- [X] Setup release posts for existing releases
- [X] Install doc moved to gh-pages
- [X] Usage doc moved to gh-pages
- [X] Protips doc moved to gh-pages
- [X] Error 1004 and jpegmini protip
- [X] Screenshots
- [X] Update master branch README to point to gh-pages branch and github.io docs page
- [X] Remove docs from master branch

# Phase 10 - Feature
- [X] Branch
- [X] Preference to auto apply tags with a given minimum p value (disables tagging pop up)
- [X] Version bump

# Phase 9 - Feature/Fix
- [X] Branch
- [X] Verify jpeg mini output support
- [X] Progress indicator showing status of applying tags to images (increment on image)
- [X] Setup tag (by image) progress indicator as a sub to the export indicator (allows seeing progress while tags are being applied)
- [X] Test cancel function of progress during tagging
- [X] Version bump

# Phase 8 - Fix
- [X] Branch
- [X] Fix default log level
- [X] Version bump

# Phase 7 - Feature
- [X] Branch
- [X] Export option to be able to set megapixels = 0 which means sending the full resolution image to services
- [X] Fix bug when calling recursion guard when Clarifai 401 error occurs
- [X] Ability to sort tags alphabetically or by probability
- [X] Preference to use unique naming for sidecar files (iso date + HHMMSS) -- default to false
- [X] Version bump

# Phase 6 - Feature
- [X] Branch
- [X] Concept of log levels and corresponding preference
- [X] Update preference to be just "Logging", not "Debug" -- rename preference variable name accordingly
- [X] Version bump

# Phase 5 - Fix
- [X] Branch
- [X] Update README install to reference releases instead of master version
- [X] Break install/setup and usage into own documents
- [X] Clarifai usage dialog have better field naming/titles
- [X] Fixup Clarifai API to properly handle 401 status responses properly
- [X] Version bump

# Phase 4.9
- [X] Branch
- [X] Fix start up crash
- [X] Version bump

## Phase 4.1
- [X] Verify / cleanup readme
- [X] Add screenshots of UI
- [X] Basic install section to README
- [X] Basic setup section to README
- [X] Basic usage section to README 
 
## Phase 4
- [X] Tag selection window (saves selected computer vision tags)
- [X] Bold existing tags
- [X] Preference to bold existing tags (global)
- [X] Show probabilities in tag selection window
- [X] Preference to show probabilities in tag window (global)
- [X] Option to set dialog height / width via global preferences
- [X] Option to set thumbnail size via global preferences
 
## Phase 3
- [X] Submission of temp photo to AI service
- [X] Save response as sidecar file -- next to image like xmp (use service + date (iso) + time (HHMMSS) for file naming
- [X] Option to save response data as json sidecar files (on by default)
 
## Phase 2
- [X] Basic export plugin setup
- [X] Fundamental "tunables" setup for export plugin
- [X] Select language for Clarifai
- [X] Allow selecting models (Clarifai)
- [X] Photo size to upload (px x px) option
- [X] Slider for quality of JPEG sent to services
- [X] Verify ability to save multiple export profiles
- [X] Photo creation for upload -- create resized version of image based on preference
- [X] Store photo created in temp folder
- [X] Swap JPEG quality in export to slider
- [X] Allow strip of metadata from output photo before send -- using default metadata handler
- [X] Allow watermarking -- using default watermarking handler
- [X] Allow sharpening -- using default sharpening handler
- [X] Cleanup stored photo (verify created photo is valid and works with Clarifai manual upload first) 
 
## Phase 1.5
- [X] Implement usage stats as menu item under help
- [X] Add help menu items to file menu as well
 
## Phase 1
- [X] Version info
- [X] Plugin blurb
- [X] Basic Clarifai section
- [X] Global settings section
- [X] Basic Clarifai config elements
- [X] Button to Verify API keys
- [X] Button to [re]generate client access token
- [X] Option to turn debug log on/off -- defaults to off
- [X] Help Menu item to show Clarifai Info API call output as dialog
