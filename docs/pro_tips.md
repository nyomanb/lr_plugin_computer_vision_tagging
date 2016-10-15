---
layout: page
title: Pro Tips
subtitle: Various tips/tricks to make life easier while using the plugin
---

# Error 1004
If you receive "Error 1004" you likely have found an odd interaction with JPEG mini. If you turn off JPEG mini in the export, the plugin should work again.

The developers are aware of the problem but have not looked into it closely.

# JPEG Mini
The plugin will work with the JPEG mini plugin generally. It may cause a 1004 error, use at your own risk.

# Tagging Window Preferences
If you have a 1080p monitor, the following values work great for the tagging window and thumbnail sizes:

- Thumbnail size: 256
- Tagging Window Width: 1850
- Tagging Window Height: 875

# Image Sizing
The quality of an image submitted to the various computer vision services doesn't have to be large or especially high quality. Godo results can be achieved with a 2 megapixel image and 50 as a q value for the JPEG encoding. You shouldn't need to go above 4 megapixels or 70 for the q value to get good results from the APIs.

![Creative Commons License]({{ '/img/CC-BY-SA-NC-4.0.png' | prepend: site.baseurl | replace: '//', '/' }})