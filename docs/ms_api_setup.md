---
layout: page
title: Micorosft API Setup
subtitle: How to setup the Microsoft Cognition API with the Lightroom Computer Vision Plugin
---

*Note: you can click the screen shots for larger versions*

# Create Microsoft API Account
1. Head over to the [Microsoft Azure Cognitive Services website (link)](https://docs.microsoft.com/en-us/azure/cognitive-services/) and sign up for a new Azure account  
    [![create_account.png]({{ '/img/ms_api_setup/create_account.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/create_account.png' | prepend: site.baseurl | replace: '//', '/' }})  
    [![create_account_2.png]({{ '/img/ms_api_setup/create_account_2.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/create_account_2.png' | prepend: site.baseurl | replace: '//', '/' }})
1. After your account is created, login to the [Microsoft Azure Cognitive Services website (link)](https://azure.microsoft.com/en-us/try/cognitive-services/)  
    [![login.png]({{ '/img/ms_api_setup/login.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/login.png' | prepend: site.baseurl | replace: '//', '/' }})  
    [![login_2.png]({{ '/img/ms_api_setup/login_2.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/login_2.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Create API subscriptions for each of the Microsoft Cognition Services you intend to use.
1. Computer Vision API : Head to [the main site (link)](https://azure.microsoft.com/en-us/services/cognitive-services/computer-vision/) and click the "Portal" link to create the subscription.  
    [![vision_api_portal_link.png]({{ '/img/ms_api_setup/vision_api_portal_link.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/vision_api_portal_link.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The Azure subscription tool will now show. Enter the necessary details (see screen shot) and ensure you're on the free tier. Also make note of the resource group name you create, it will be used for the other APIs.  
    [![vision_api_create_sub.png]({{ '/img/ms_api_setup/vision_api_create_sub.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/vision_api_create_sub.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Face API : Head to [the main site (link)](https://azure.microsoft.com/en-us/services/cognitive-services/face/) and click the "Portal" link to create the subscription.  
    [![face_api_portal_link.png]({{ '/img/ms_api_setup/face_api_portal_link.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/face_api_portal_link.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The Azure subscription tool will now show. Enter the necessary details (see screen shot) and ensure you're on the free tier. Be sure to re-use the resource group you created for the Vision API. This will help make finding the API keys easier.  
    [![face_api_create_sub.png]({{ '/img/ms_api_setup/face_api_create_sub.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/face_api_create_sub.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Emotion API : Head to [the main site (link)](https://azure.microsoft.com/en-us/services/cognitive-services/emotion/) and click the "Portal" link to create the subscription.  
    [![emotion_api_portal_link.png]({{ '/img/ms_api_setup/emotion_api_portal_link.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/emotion_api_portal_link.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The Azure subscription tool will now show. Enter the necessary details (see screen shot) and ensure you're on the free tier. Be sure to re-use the resource group you created for the Vision API. This will help make finding the API keys easier.  
    [![emotion_api_create_sub.png]({{ '/img/ms_api_setup/emotion_api_create_sub.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/ms_api_setup/emotion_api_create_sub.png' | prepend: site.baseurl | replace: '//', '/' }})

# Setup Lightroom Computer Vision for Microsoft API usage
1. Login to the main [Azure Portal (link)](https://portal.azure.com)
1. After login you'll see the Azure Dashboard  
    [![azure_portal_dashboard.png]({{ '/img/install_setup/azure_portal_dashboard.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/azure_portal_dashboard.png' | prepend: site.baseurl | replace: '//', '/' }})
1. In the search box at the top, search for the resource group you setup when creating API keys and click on the resource group  
    [![azure_portal_search.png]({{ '/img/install_setup/azure_portal_search.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/azure_portal_search.png' | prepend: site.baseurl | replace: '//', '/' }})
1. A list of all your API subscriptions for "Cognitive Services" will now be showing
    [![azure_api_subscription_list.png]({{ '/img/install_setup/azure_api_subscription_list.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/azure_api_subscription_list.png' | prepend: site.baseurl | replace: '//', '/' }})
1. For each item in the Resource Group click on it and then the "Keys" option under "Resource Management" to find your API keys.
- *Note: You'll want to make note of "Key 1" for each item, it will be used for setup of the Lightroom Plugin*  
    [![azure_api_key_details.png]({{ '/img/install_setup/azure_api_key_details.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/azure_api_key_details.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Open Lightroom
1. Open Plugin Manager in Lightroom  
    [![file_plugin_manager.png]({{ '/img/install_setup/file_plugin_manager.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/file_plugin_manager.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Select the "Computer Vision Tagging" plugin  
    [![select_lrcvt.png]({{ '/img/install_setup/select_lrcvt.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/select_lrcvt.png' | prepend: site.baseurl | replace: '//', '/' }})
1. Enter each of the API keys from above into the "Microsoft API Settings" section of the dialog  
    [![lr_ms_api_keys.png]({{ '/img/install_setup/lr_ms_api_keys.png' | prepend: site.baseurl | replace: '//', '/' }}){:height="128px"}]({{ '/img/install_setup/lr_ms_api_keys.png' | prepend: site.baseurl | replace: '//', '/' }})
1. The plugin is now setup to utilize the Microsoft Computer Vision and Cognition APIs

![Creative Commons License]({{ '/img/CC-BY-SA-NC-4.0.png' | prepend: site.baseurl | replace: '//', '/' }})