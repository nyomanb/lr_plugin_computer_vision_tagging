# Project Plan
This document outlines the rough roadmap the developers will loosely follow. Overall features (planned and otherwise) are broken down in rough order of priority.

Please note there are not any dates listed here. The developers have day jobs and will **NOT** commit to deadlines. Don't ask. 

# Phase 1
- [X] Version info
- [X] Plugin blurb
- [X] Basic Clarifai section
- [X] Global settings section
- [X] Basic Clarifai config elements
- [X] Button to Verify API keys
- [X] Button to [re]generate client access token
- [X] Option to turn debug log on/off -- defaults to off
- [ ] Menu item to show Clarifai Info API call output as dialog

# Phase 2
- [ ] Basic export plugin setup
- [ ] Fundamental "tunables" setup for export plugin
- [ ] Verify ability to save multiple export profiles
- [ ] Photo size to upload (px x px) option
- [ ] Photo creation for upload -- create resized version of image based on preference
- [ ] Store photo created in temp folder
- [ ] Cleanup stored photo (verify created photo is valid and works with Clarifai manual upload first)
- [ ] Slider to adjust quality of JPEG sent to services (if NOT jpegmini)
- [ ] Strip metadata from output photo before send (option in settings)

# Phase 3
- [ ] Submission of temp photo to AI service
- [ ] Save response as sidecar file -- next to image like xmp (use service + date (iso) + time (HHMMSS) for file naming
- [ ] Option to save response data as json sidecar files (on by default)

# Phase 4
- [ ] Tag selection window
- [ ] Bold existing tags
- [ ] Preference to bold existing tags (global)
- [ ] Show probabilities in tag selection window
- [ ] Preference to show probabilities in tag window (global)

# Phase Future (All other features/enhancements go here)
- [ ] Install document written
- [ ] Usage document written
- [ ] Concept of log levels and only showing selected level or higher in the log
- [ ] Select language for Clarifai
- [ ] Allow selecting models (Clarifai / Google Vision)
- [ ] Allow selecting detections (Google Vision)
- [ ] Option to auto apply tags with a given minimum p value (disables tagging pop up)
- [ ] Option to only send to selected services
- [ ] Option to submit selected tags back to upstream service to help with their training
- [ ] API keys stored as passwords (LR SDK has password management utils)
- [ ] Progress Indicators
 - [ ] Upload status
 - [ ] Response processing status
 - [ ] Service sends (on service 1 of 2 for example)
 - [ ] Status of saving keywords
 - [ ] Saving sidecar files
 - [ ] Any other operations that make sense
 
 
 ![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)
