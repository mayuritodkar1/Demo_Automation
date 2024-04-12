*** Settings ***
Resource    ../resources/config/global.resource 
Resource    ../resources/Keywords/Keywords Demoblaze.resource

Test Setup    Set Test Documentation    This test case is to verify ${TEST_NAME} component creation and validation      

*** Test Cases ***
Test Case_1.1_Successful for Login
    [Tags]    smoke
    Launch DemoblazeURL   ${url}    headless=${headless}  
    Login To Application    ${userid}    ${password}
    Close Browser


Test Case_1.2 Invalid User Id for Login
    [Tags]    smoke
    Launch DemoblazeURL   ${url}    headless=${headless}
    Login To Application    ${invaliduserid}    ${password}
    Alert Should Be Present    User does not exist.    DISMISS
    Close Browser

Test Case_1.3 Invalid Password for Login
    [Tags]    smoke
    Launch DemoblazeURL   ${url}    headless=${headless}  
    Login To Application    ${userid}    ${invalidpassword}
    Alert Should Be Present    Wrong password.    DISMISS
    Close Browser

Test Case_1.4 Empty UserID and Password for Login
    [Tags]    smoke
    Launch DemoblazeURL   ${url}    headless=${headless}  
    Login To Application    ${emptyuserid}    ${emptypassword}
    Alert Should Be Present    Please fill out Username and Password.    ACCEPT
    Close Browser

Test Case_2.0 Logout from The application
    [Tags]    smoke
    Launch DemoblazeURL   ${url}    headless=${headless} 
    Login To Application    ${userid}    ${password}
    Logout from Application
    Verify The Page After Logout    ${url}
    Close Browser

Test Case_3.0 Add Item To Shoping cart
    [Tags]    smoke
    Launch DemoblazeURL   ${url}    headless=${headless}  
    Login To Application    ${userid}    ${password}
    Click on Link    Phones
    Click on Link    ${item}
    Click on Link    Add to cart
    Alert Should Be Present    Product added.    ACCEPT
    Click on Link    Cart
    Verify Items On Cart    ${item} 
    Delete Added Item    ${item}
    Close Browser

