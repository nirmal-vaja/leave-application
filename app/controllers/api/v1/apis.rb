APIs :

Signup :
url : "api/v1/users" - POST
body: 
{   
    "subdomain": "scs",
    "first_name": "Gumble",
    "last_name": "Test",
    "email": "grumble@gmail.com",
    "password": "password",
    "date_of_joining": "2022-07-10T11:00:55Z",
    "phone_number": "9674566666",
    "client_id": "GziBo5-3HbhgR_Vrtt9bULg9XZA-zur9Z7TofV_9NsA"
}


--------------------------------------------------------------------------

Login :
url : "api/v1/oauth/token"
body:
{
    "grant_type": "password",
    "email": "example@gmail.com",
    "password": "example@123",
    "client_id": "w0loO2_ApUMGJBVCvhRZkDLyhy0AvVXz3ylIE5jA-Kw",
    "client_secret": "drniWvhmaXDxSTm3ZykU25UztmUeeU5XNyGUXbCoef0"
}


---------------------------------------------------------------------------

Logout :
url : "api/v1/oauth/revoke"
body: 
{
    "token": "ydKmDPZLTORbj-aEHjTOOdsLB79uJjQjw2QUSkfgzh4",
    "client_id": "w0loO2_ApUMGJBVCvhRZkDLyhy0AvVXz3ylIE5jA-Kw",
    "client_secret": "drniWvhmaXDxSTm3ZykU25UztmUeeU5XNyGUXbCoef0"
}

--------------------------------------------------------------------------

Organization registration :
url: "api/v1/organizations" - POST,
body: 
{
    "name": "Softcoding Solutions",
    "established_year" : "Date time format",
    "support_email": "support@scs.com",
    "contact_number": "7418529630",
    "city": "Ahmedabad",
    "state": "Gujarat",
    "country": "India",
    "subdomain": "scs"
}

--------------------------------------------------------------------------

Fetch names with subdomain of organization : 
url: "api/v1/organizations/fetch_names_with_subdomain" - GET

--------------------------------------------------------------------------

