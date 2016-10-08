# Project Plan
This document outlines the rough roadmap the developers will loosely follow. Overall features (planned and otherwise) are broken down in rough order of priority.

Please note there are not any dates listed here. The developers have day jobs and will **NOT** commit to deadlines. Don't ask. 

# Phase 11 - Feature
- [ ] Branch
- [ ] Show service(s) that a tag was suggested by in tagging dialog
- [ ] Export option to only send to selected services (checkboxes for each configured service)
- [ ] Version Bump

# Phase 12 - Feature
- [ ] Branch
- [ ] Implement Microsoft Computer Vision API (new service)
- [ ] Save response as side car file
- [ ] Add tags to main tagging dialog
- [ ] Add tags to auto tagging
- [ ] Version Bump

# Phase 13 - Feature
- [ ] Branch
- [ ] Show service specific data in tagging window after tag group
- [ ] Version Bump

# Phase 14 - Feature
- [ ] Branch
- [ ] Option to show a dialog with service specific data if auto-tagging 
- [ ] Version Bump

# Phase 15 - Feature
- [ ] Branch
- [ ] Implement Microsoft Emotion API (new service)
- [ ] Save response as side car file
- [ ] Show service specific data in tagging dialog
- [ ] Show service specific data in auto tag dialog
- [ ] Version Bump

# Phase 16 - Feature
- [ ] Branch
- [ ] Implement Microsoft Face API (new service)
- [ ] Save response as side car file
- [ ] Show service specific data in tagging dialog
- [ ] Show service specific data in auto tag dialog
- [ ] Version Bump

# Phase Future (enhancements / features)
- [ ] Base implementation of Google vision
- [ ] Option to submit selected tags back to upstream service to help with their training
- [ ] Ensure all strings are localized
- [ ] Allow resizing of the tagging dialog

# Completed Phases
This section is basically the changelog in reverse chronological order

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


![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)
