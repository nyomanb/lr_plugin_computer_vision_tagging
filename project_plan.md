---
layout: page
title: Project Plan
subtitle: Where the project is headed
---

This document outlines the rough roadmap the developers will loosely follow. Overall features (planned and otherwise) are broken down in rough order of priority.

Please note there are not any dates listed here. The developers have day jobs and will **NOT** commit to deadlines. Don't ask. 

# Phase 11 - Feature
- [ ] Branch
- [ ] Show service(s) that a tag was suggested by in tagging dialog
- [ ] Export option to only send to selected services (checkboxes for each configured service)
- [ ] Version Bump
- [ ] Update Project Plan
- [ ] Post on docs site

# Phase 12 - Feature
- [ ] Branch
- [ ] Implement Microsoft Computer Vision API (new service)
- [ ] Save response as side car file
- [ ] Add tags to main tagging dialog
- [ ] Add tags to auto tagging
- [ ] Version Bump
- [ ] Update Project Plan
- [ ] Post on docs site

# Phase 13 - Feature
- [ ] Branch
- [ ] Show service specific data in tagging window after tag group
- [ ] Version Bump
- [ ] Update Project Plan
- [ ] Post on docs site

# Phase 14 - Feature
- [ ] Branch
- [ ] Option to show a dialog with service specific data if auto-tagging 
- [ ] Version Bump
- [ ] Update Project Plan
- [ ] Post on docs site

# Phase 15 - Feature
- [ ] Branch
- [ ] Implement Microsoft Emotion API (new service)
- [ ] Save response as side car file
- [ ] Show service specific data in tagging dialog
- [ ] Show service specific data in auto tag dialog
- [ ] Version Bump
- [ ] Update Project Plan
- [ ] Post on docs site

# Phase 16 - Feature
- [ ] Branch
- [ ] Implement Microsoft Face API (new service)
- [ ] Save response as side car file
- [ ] Show service specific data in tagging dialog
- [ ] Show service specific data in auto tag dialog
- [ ] Version Bump
- [ ] Update Project Plan
- [ ] Post on docs site

# Phase 17 - Docs
- [ ] Create docs for setup of Microsoft Computer Vision services (use Clarifai docs as template/model)

# Phase Documentation (ongoing)
- [ ] Clarifai API setup (account, app creation, plugin prefs) documentation
- [ ] Basic usage of menu items (File/Help)
- [ ] Basic walk through of photo submissions and tagging
- [ ] Full walk through of Lightroom plugin preferences
- [ ] Full walk through of export settings
- [ ] Full walk through of tagging dialog
- [ ] Protip on tagging window size for 1280x800 monitors
- [ ] Protip on tagging window size for 1366x768 monitors

# Phase Future (enhancements / features)
- [ ] Custom metadata
    - [ ] Field(s) for tracking which services submitted to -- helps with smart collections
    - [ ] Field(s) to hold raw service response data
    - [ ] Field(s) to hold/show service specific data elements (processed to something human readable/sane -- everything but tags)
    - [ ] Field(s) to hold/show tags returned by services (show service + tag tuple)
- [ ] Way to add keyboard shortcut - ctrl - alt - a - i ?
- [ ] Badge/overlay for files sent to services
- [ ] Badge/overlay for each service
- [ ] Smart collections for
   - [ ] All photos submitted
   - [ ] Collection for each service and the images sent to the service
- [ ] Samples to try with services added to project (pick non-special shots taken by KmN, apply CC Non Commercial license [docs, photo metadata])
- [ ] Base implementation of Google vision
- [ ] Option to submit selected tags back to upstream service to help with their training
- [ ] Ensure all strings are localized
- [ ] Allow resizing of the tagging dialog
- [ ] Solve error 1004 and jpegmini