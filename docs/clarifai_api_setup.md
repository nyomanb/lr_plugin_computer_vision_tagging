---
layout: page
title: Clarifai API Setup
subtitle: How to setup the Clarifai API with the Lightroom Computer Vision Plugin (starting with 20170717.1 release)
---

*Note: you can click the screen shots for larger versions*

# Create Clarifai API Account
1. Head over to the [Clarifai API Developer website (link)](https://developer.clarifai.com/) and sign up for a new account  
    [![sign_up.png]({{ '/img/clarifai_api_setup/sign_up.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/sign_up.png' | prepend: site.baseurl | replace: '//', '/' }})
1. After your account is created, login to the [Clarifai API Developer website (link)](https://developer.clarifai.com/)  
    [![login.png]({{ '/img/clarifai_api_setup/login.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/login.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Click on the "Applications" link in the left navigation bar  
    [![applications.png]({{ '/img/clarifai_api_setup/applications.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/applications.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Click on "Create a New Application" button that is in the main area of the web page  
    [![create_application.png]({{ '/img/clarifai_api_setup/create_application.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/create_application.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Give the application a name that makes sense for you and click "Create Application"  
    [![name_create.png]({{ '/img/clarifai_api_setup/name_create.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/name_create.png' | prepend: site.baseurl | replace: '//', '/' }})
1. You will be returned to your application list after creation.
1. Click the "Edit" button on the newly created app to open the details for the application  
    [![app_details.png]({{ '/img/clarifai_api_setup/app_details.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/app_details.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Click the "API Keys" heading on the screen that pops up.  
    [![show_api_key.png]({{ '/img/clarifai_api_setup/show_api_key.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/show_api_key.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The screen will now show the generated API Key. The value is used within the plugin for access to the Clarifai API setup.  
   - *Note: I've blacked out a large portion of the API Key in the screenshot, your values will be much longer*  
   [![web_api_key.png]({{ '/img/clarifai_api_setup/web_api_key.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/web_api_key.png' | prepend: site.baseurl | replace: '//', '/' }})

# Setup Lightroom Computer Vision for Clarifai API usage
1. Open Lightroom
1. Open Plugin Manager in Lightroom  
    [![file_plugin_manager.png]({{ '/img/install_setup/file_plugin_manager.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/file_plugin_manager.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Select the "Computer Vision Tagging" plugin  
    [![select_lrcvt.png]({{ '/img/install_setup/select_lrcvt.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/select_lrcvt.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Copy and paste the "API Key" value from the Clarifai website into the "API Key" field that can be found under the Clarifai Settings section of the plugin preferences  
    [![lr_api_key.png]({{ '/img/clarifai_api_setup/lr_api_key.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/lr_api_key.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The plugin is now setup to utilize the Clarifai API

![Creative Commons License]({{ '/img/CC-BY-SA-NC-4.0.png' | prepend: site.baseurl | replace: '//', '/' }})