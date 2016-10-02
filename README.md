# General info
Welcome to the Computer Vision Lightroom plugin project page. This project aims to provide a Lightroom plugin that lets you submit photos to the various compouter vision platforms. The idea is to leverage AI to help improve photo tagging.

# Compatibility
- Lightroom 5 and higher
- Windows 10 (lower versions of Windows likely work but are untested, please let me know if you have success with other versions of Windows)
- Mac is untested but will likely work, please let me know if it works on a Mac

# Install
To install follow the procedure below
1. Click the "releases" tab
1. Click "Zip" icon for the latest release to download
1. Extract the downloaded zip file somewhere on your computer
1. Open Lightroom
1. File -> Plugin Manager
1. Click Add and select the ai_tagging.lrdevplugin folder that is in the unzipped directory

# Setup
1. Open Plugin Manager in Lightroom
1. Select the "Computer Vision Tagging" plugin
1. Configure your computer vision API settings (each has it's own section)
1. Configure other settings as you see fit

# Usage
## API Usage/Info
API usage stats and general information is available under the Plugin Extras menu item in the File or Help menus of Lightroom.

## Tagging
This plugin is implemented as an export plugin in Lightroom. It works the same way as other, standard export plugins. Follow the procedure below to tag photos.

1. Select photos in your library/catalog/collection
1. Open the export dialog using the standard mechanism(s)
1. Select the "Computer Vision Tagging" value at the top next to "Export To"
1. Tune any export settings as you see fit
1. Click the "Export" button
1. A dialog will pop up with all of the selected images (scroll right if necessary) and tags returned by the APIs
1. Check or uncheck any tags you'd like to include or remove
1. Click OK
1. The tags will be added/removed as appropriate

# Pro Tips
## Tagging Window Preferences
If you have a 1080p monitor, the following values work great for the tagging window and thumbnail sizes:

- Thumbnail size: 256
- Tagging Window Width: 1850
- Tagging Window Height: 875

# Roadmap / Project Plan
See the "project_plan.md" file for more details on the current state of the project and what is on the roadmap for development.

# Contributing
Contributions to this project are welcome and appreciated. Please create a pull request with any changes you'd like to see included. The developers(s) will review the pull request and make any necessary comments/approvals after review.

Please note all code and documentation (except libraries as appropriate) must be licensed according to the "Licensing" section of the README.

# Licensing
## Code
All code in this project is licensed under the GPLv3. The "GPLv3" file contains the full license.
## Documentation
All documentation is licensed under the Creative Commons Attribution, Non Commercial, Share Alike 4.0 International license (CC BY-NC-SA 4.0). The "CC_BY-NC-SA_4.0.html" file contains the full license.


![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)
