*** Settings ***
Library    SeleniumLibrary   
Resource    ../../resources/config/global.resource  

*** Keywords ***
Launch DemoblazeURL
    [Arguments]    ${s3url}    ${headless}=${True}
    IF    ${headless}
        ${options}    Get Headless options
    ELSE
        ${options}    Set Variable    ${None}
    END
    Open Browser    ${s3url}    Chrome    options=${options}
    IF    '${headless}'=='${True}'
        Set Window Size    1920    1080 
    ELSE
        Maximize Browser Window
    END

Get Headless options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${options}    add_argument    --no-sandbox
    Call Method    ${options}    add_argument    --headless 
    call Method    ${options}    add_argument    --disable-dev-shm-usage
    Call Method    ${options}    add_argument    --disable-gpu
    [Return]    ${options}



Login To Application
    [Arguments]    ${UserID}    ${pwd} 
    Wait Until Page Contains Element    id=login2    timeout=20s  
    Click Element    id=login2 
    Wait Until Page Contains Element    //div[@class='modal-content']    timeout=20s  
    Page Should Contain Element    //h5[@id="logInModalLabel"]
    Wait Until Page Contains Element    id=loginusername    timeout=20s
    Sleep    300ms  
    Input Text    id=loginusername    ${UserID} 
    Input Text    id=loginpassword    ${pwd}
    Click button    Log in 



Click on button 
    [Arguments]    ${buttonName} 
    Wait Until Page Contains Element    //button[text()='${buttonName}']    timeout=20s     
    Click Element    //button[text()='${buttonName}']

Logout from Application
    Wait Until Page Contains Element    id=logout2    timeout=20s  
    sleep  2s 
    Click Element    id=logout2


Verify The Page After Logout
    [Arguments]    ${logouturl} 
    ${currenturl}    Get Location
    Should Be Equal    ${currenturl}    ${logouturl}


Click on Link 
    [Arguments]    ${linkName} 
    Wait Until Page Contains Element    //a[text()='${linkName}']    timeout=20s     
    Sleep    1s
    Click Element    //a[text()='${linkName}']

Verify Items On Cart
    [Arguments]    ${item} 
    Wait Until Page Contains Element    (//tr/td[text()='${item}'])[1]    timeout=20s
    Page Should Contain Element    (//tr/td[text()='${item}'])[1]

Delete Added Item
    [Arguments]    ${item} 
    Wait Until Page Contains Element    (//tr/td[text()='${item}']/following-sibling::td[2]/a)[1]    timeout=20s
    Click Element    (//tr/td[text()='${item}']/following-sibling::td[2]/a)[1]

    