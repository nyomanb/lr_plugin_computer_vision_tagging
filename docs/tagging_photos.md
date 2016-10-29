---
layout: page
title: Tagging Photos
subtitle: Information on how to tag photos with the plugin
---

*Note: you can click the screen shots for larger versions*

# Tagging Photos
This plugin is implemented as an export plugin in Lightroom. It works the same way as other, standard export plugins. Follow the procedure below to tag photos.

1. If you have not done so already, configure the Clarifai API via the plugin's preferences
1. Select photos in your library/catalog/collection
1. Open the export dialog using the standard mechanism(s)  
    [![export_menu.png]({{ '/img/tagging_photos/export_menu.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/tagging_photos/export_menu.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Select the "Computer Vision Tagging" value at the top next to "Export To"  
    [![export_dialog_select_cvt.png]({{ '/img/tagging_photos/export_dialog_select_cvt.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/tagging_photos/export_dialog_select_cvt.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Tune any export settings as you see fit  
    [![export_dialog_tuning.png]({{ '/img/tagging_photos/export_dialog_tuning.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/tagging_photos/export_dialog_tuning.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Click the "Export" button  
    [![export_dialog_export_button.png]({{ '/img/tagging_photos/export_dialog_export_button.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/tagging_photos/export_dialog_export_button.png' | prepend: site.baseurl | replace: '//', '/' }})
1. A dialog will pop up with all of the selected images (scroll right if necessary) and tags returned by the APIs  
    [![tagging_dialog.png]({{ '/img/tagging_photos/tagging_dialog.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/tagging_photos/tagging_dialog.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Check or uncheck any tags you'd like to include or remove
1. Click OK
1. The tags will be added/removed as appropriate

![Creative Commons License]({{ '/img/CC-BY-SA-NC-4.0.png' | prepend: site.baseurl | replace: '//', '/' }})