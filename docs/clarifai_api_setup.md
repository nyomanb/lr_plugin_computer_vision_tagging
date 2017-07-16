---
layout: page
title: Clarifai API Setup
subtitle: How to setup the Clarifai API with the Lightroom Computer Vision Plugin
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
1. Click the "Show Legacy Authorization" heading on the screen that pops up.
- *Note: as of this writing the legacy authorization tokens are required, a future update will change this*  
    [![show_legacy_auth.png]({{ '/img/clarifai_api_setup/show_legacy_auth.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/show_legacy_auth.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The screen will now show with fields named "Client Id" and "Client Secret". These values are used within the plugin for access to the Clarifai API setup.
   - *Note: I've blacked out a large portion of the Client Id and Client Secret in the screenshot, your values will be much longer*  
   [![client_id_client_secret.png]({{ '/img/clarifai_api_setup/client_id_client_secret.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/client_id_client_secret.png' | prepend: site.baseurl | replace: '//', '/' }})

# Setup Lightroom Computer Vision for Clarifai API usage
1. Open Lightroom
1. Open Plugin Manager in Lightroom  
    [![file_plugin_manager.png]({{ '/img/install_setup/file_plugin_manager.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/file_plugin_manager.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Select the "Computer Vision Tagging" plugin  
    [![select_lrcvt.png]({{ '/img/install_setup/select_lrcvt.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/select_lrcvt.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Copy and paste the "Client Id" value from the Clarifai website into the "Client ID" field that can be found under the Clarifai Settings section of the plugin preferences  
    [![client_id_client_secret.png]({{ '/img/clarifai_api_setup/client_id_client_secret.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/client_id_client_secret.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Copy and paste the "Client Secret" value from the Clarifai website into the "Client Secret" field that can be found under the Clarifai Settings section of the plugin preferences
    - *Note: the pasted value will show as a series of dots, this is intentional behavior*  
    [![lr_setup_client_secret.png]({{ '/img/clarifai_api_setup/lr_setup_client_secret.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/lr_setup_client_secret.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Click the "Verify Settings" button  
    [![verify_settings.png]({{ '/img/clarifai_api_setup/verify_settings.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/verify_settings.png' | prepend: site.baseurl | replace: '//', '/' }})
1. If the values for "Client ID" and "Client Secret" were correct, a "Success" message (in green) should display as well as an "Access Token" being generated and displayed
    - *Note: if you see success and/or no access token, double check the values you entered for "Client ID" and "Client Secret"*  
    [![values_returned.png]({{ '/img/clarifai_api_setup/values_returned.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/clarifai_api_setup/values_returned.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The plugin is now setup to utilize the Clarifai API

![Creative Commons License]({{ '/img/CC-BY-SA-NC-4.0.png' | prepend: site.baseurl | replace: '//', '/' }})