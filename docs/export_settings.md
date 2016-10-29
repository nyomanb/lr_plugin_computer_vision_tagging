---
layout: page
title: Export Settings
subtitle: A breakdown of the export settings available for this plugin
---

*Note: you can click the screen shots for larger versions*

[![Export_Dialog.png]({{ '/img/screenshots/Export_Dialog.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="384"}]({{ '/img/screenshots/Export_Dialog.png' | prepend: site.baseurl | replace: '//', '/' }})

# Global Settings Section
This section allows you to select which APIs/services are used for tagging. Currently only the Clarifai API/service is implemented. More services will be added as they are implemented by the plugin

# Image Quality Section
Size (Mpx)
: The size of the image to submit in megapixels. The plugin will resize the image using Lightrooms built-in resizing functions which maintain aspect ratio. Set this to 0 if you do not want the image resized.

JPEG Quality
: The quality value to use for the JPEG that is submitted. Low values here will yield generally good results at low megapixels based on tests run during plugin development.

# Tags Section
Auto-Select Tags
: Allow the plugin to auto-select tags. This must be set in conjunction with the "Auto select minimum probability (inclusive)" option in order to have an effect.

Auto select minimum probability (inclusive)
: The minimum probability of a tag for it to be auto selected when "Auto-Select Tags" is checked. You'll want to adjust this value based on the results you see from the various services.

Auto save tags
: Allow the plugin to save tags automatically without showing the tagging dialog. This must be set in conjunction with the "Auto save minimum probability (inclusive) option in order to have an effect.

Auto save minimum probability (inclusive)
: The minimum probability of a tag for it to be auto saved when "Auto save tags" is checked. This is helpful when batch processing images. You'll want to tune this based on how well the computer vision APIs tag your photos.

# Side Car Files Section
Save sidecar json files
: Save the API responses as JSON files next to images. This works similar to XMP files and can be helpful if you want to catalog the raw API/service responses the plugin receives. Please note the plugin will only save the most recent response unless "Save sidecars with timestamped names" is checked.

Save sidecars with timestamped names
: This will force a unique name for each JSON side car file. This allows a proper history of responses to be saved as side cars. Note this will not have an effect unless "Save sidecar json files" is checked.

# Clarifai Settings Section
Model
: Which of the Clarifai API models to use

Language
: Which of the Clarifai API languages to use. Note the tags will be returned in this language.

# Output Sharpening Section
This is the standard Lightroom Output Sharpening export section

# Metadata Section
This is teh standard Lightroom Metadata export section

# Watermarking Section
This is the standard Ligthroom Watermarking export section

![Creative Commons License]({{ '/img/CC-BY-SA-NC-4.0.png' | prepend: site.baseurl | replace: '//', '/' }})