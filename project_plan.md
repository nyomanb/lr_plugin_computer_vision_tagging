# Project Plan
This document outlines the rough roadmap the developers will loosely follow. Overall features (planned and otherwise) are broken down in rough order of priority.

Please note there are not any dates listed here. The developers have day jobs and will **NOT** commit to deadlines. Don't ask. 

# Phase 1
- [ ] Version info / plugin blurb
- [ ] Basic Clarifai section
- [ ] Basic Clarifai config elements
- [ ] Verify button
- [ ] Show success dialog if verify suceeds
- [ ] Button to show usage (or similar info) returned by APIs
- [ ] Option to turn debug log on/off
- [ ] Option to log to file and ability to set path with default being root dir of catalog
- [ ] API keys stored as passwords (LR SDK has password management utils)

# Phase 2
- [ ] Add pref for photo size to upload (px x px)
- [ ] Photo creation for upload -- create resized version of image based on preference
- [ ] Store photo created in temp folder
- [ ] Cleanup stored photo (verify created photo is valid and works with Clarifai manual upload first)
- [ ] Slider in prefs to adjust quality of JPEG sent to services (if NOT jpegmini)
- [ ] Strip metadata from output photo before send (option in settings)

# Phase 3
- [ ] Submission of temp photo to AI service
- [ ] Save response as sidecar file -- next to image like xmp
- [ ] Option to save response data as json sidecar files (on by default)

# Phase 4
- [ ] Tag selection window
- [ ] Bold existing tags
- [ ] Show probabilities in tag selection window
- [ ] Preference to show probabilities in tag window

# Phase Future (All other features/enhancements go here)
- [ ] Select language (Clarifai has language option in API)
- [ ] Allow selecting models and detections
- [ ] Option to auto apply tags with a given minimum p value
- [ ] Option to use jpegmini CLI tool for temp jpeg creation
- [ ] Progress Indicators
 - [ ] Upload status
 - [ ] Response processing status
 - [ ] Service sends (on service 1 of 2 for example)
 - [ ] Status of saving keywords
 - [ ] Saving sidecar files
 - [ ] Any other operations that make sense
- [ ] 2 ways for running plugin from extras menu
 - [ ] With defaults
   - [ ] Skip override prompt and just submit images as appropriate 
 - [ ] Override defaults
   - [ ] Show dialog with default options that make sense to override
   - [ ] Submit with new settings
   - [ ] Be sure NOT to save changes
   - [ ] Don't give user option to save from dialog
   - [ ] Allow selection of which services to send image to (checkbox next to service names with configured services selected)
   - [ ] Allow selection of models/detections for override
 
 
 ![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)
