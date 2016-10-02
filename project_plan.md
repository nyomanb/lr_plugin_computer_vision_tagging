# Project Plan
This document outlines the rough roadmap the developers will loosely follow. Overall features (planned and otherwise) are broken down in rough order of priority.

Please note there are not any dates listed here. The developers have day jobs and will **NOT** commit to deadlines. Don't ask. 

# Phase 4.5 - Fixes
- [ ] Add export option to use unique naming for sidecar files (iso date + HHMMSS) -- default to false
- [ ] Option to be able to set megapixels = 0 which means sending the full resolution image to services

# Phase 5
- [ ] Verify jpeg mini output support
- [ ] Concept of log levels and only showing selected level or higher in the log
- [ ] Option to strip ALL metadata (beyond normal metadata section in export dialog)
- [ ] API keys stored as passwords (LR SDK has password management utils)

# Phase Future (Microsoft Computer Vision)
- [ ] Base implementation

# Phase Future (Google Vision)
- [ ] Base implementation
- [ ] Allow selecting detections (Google Vision)

# Bug Fixes / Cleanup
- [ ] Clarifai usage dialog have better field naming/titles
- [ ] Ensure all strings are localized

# Phase Future (enhancements / features)
- [ ] Option to auto apply tags with a given minimum p value (disables tagging pop up)
- [ ] Option to only send to selected services
- [ ] Option to submit selected tags back to upstream service to help with their training
- [ ] Show which service(s) a tag came through on
- [ ] Allow resizing of the tagging dialog
- [ ] Progress Indicators
 - [ ] Upload status
 - [ ] Response processing status
 - [ ] Service sends (on service 1 of 2 for example)
 - [ ] Status of saving keywords
 - [ ] Saving sidecar files
 - [ ] Any other operations that make sense
 
# Completed Phases
This section is basically the changelog in reverse chronological order

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
