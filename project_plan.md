---
layout: page
title: Project Plan
subtitle: Where the project is headed
---

This document outlines the rough roadmap the developers will loosely follow. Overall features (planned and otherwise) are broken down in rough order of priority.

Please note there are not any dates listed here. The developers have day jobs and will **NOT** commit to deadlines. Don't ask.

# Phase 17 - Custom Metadata
- [ ] Branch
- [ ] Field(s) for tracking which services submitted to -- helps with smart collections
- [ ] Field(s) to hold raw service response data
- [ ] Field(s) to hold/show service specific data elements (processed to something human readable/sane -- everything but tags)
- [ ] Field(s) to hold/show tags returned by services (show service + tag tuple)
- [ ] Menu items for saving custom metadata fields as json side cars (think XMP sidecars)
- [ ] Version Bump
- [ ] Branch merge
- [ ] Branch cleanup
- [ ] Update Project Plan / Changelog / Release post

# Phase 18 - Smart Collections
- [ ] Branch
- [ ] All photos submitted
- [ ] Collection for each service and the images sent to the service
- [ ] Version Bump
- [ ] Branch merge
- [ ] Branch cleanup
- [ ] Update Project Plan / Changelog / Release post

# Phase 19 - Custom Badges
- [ ] Branch
- [ ] Badge/overlay for files sent to services
- [ ] Badge/overlay for each service
- [ ] Version Bump
- [ ] Branch merge
- [ ] Branch cleanup
- [ ] Update Project Plan / Changelog / Release post

# Phase 20 - Search Filters
- [ ] Branch
- [ ] Additional filters for search
- [ ] Version Bump
- [ ] Branch merge
- [ ] Branch cleanup
- [ ] Update Project Plan / Changelog / Release post

# Phase Future (enhancements / features)
- [ ] Preference to show only non-API suggested, existing key words in tagging dialog
- [ ] Option to show a dialog with service specific data if auto-tagging
- [ ] Ability to edit existing keywords (select/de-select) from the tagging dialog
- [ ] Self update support based on feed.xml from main website
- [ ] Way to add keyboard shortcut - ctrl - alt - a - i ?
- [ ] Samples to try with services added to project (pick non-special shots taken by KmN, apply CC Non Commercial license [docs, photo metadata])
- [ ] Base implementation of Google vision
- [ ] Base implementation of Amazon Computer Vision (https://aws.amazon.com/rekognition/)
- [ ] Option to submit selected tags back to upstream service to help with their training
- [ ] Ensure all strings are localized
- [ ] Allow resizing of the tagging dialog
- [ ] Solve error 1004 and jpegmini
- [ ] Look at the Clarifai API for feedback mechanisms and training. Implement if there is a good way to introduce the feedback and training into the standard plugin workflow(s). This may need a separate plugin of some form.