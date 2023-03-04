*** Settings ***
Library             SeleniumLibrary
Test Setup          Open Webpage
Test Teardown       Close Webpage
Suite Setup         Set Selenium Speed      0.5    #Changing the speed of test execution

*** Variables ***

${login_button}                     xpath://*[@id="login"]
${user_name}                        xpath://*[@id="userName"]
${password}                         xpath://*[@id="password"]
${user_name_to_populate}            aabb
${password_to_populate}             M3cybefidy!
${user_name_value}                  xpath://*[@id="userName-value"]
${login_info}                       Login
${book_title}                       Git Pocket Guide

*** Test Cases ***
Logging in the registered user
    Check If Page Is Loaded
    Click Login Button
    Check If Page Is Loaded With Argument ${login_info}
    Fill In UserName
    Fill In Password
    Click Login Button
    Check Expected Result


*** Keywords ***
Open Webpage
    Open Browser                https://demoqa.com/books        chrome
    Maximize Browser Window

Check If Page Is Loaded
    Wait Until Page Contains    Book Store

Click Login Button
    Click Button    ${login_button}

Check If Page Is Loaded With Argument ${title}
    Wait Until Page Contains    ${title}

Fill In UserName
    Check If Page Is Loaded With Argument ${login_info}
    Click Element    ${user_name}
    Input Text    ${user_name}    ${user_name_to_populate}

Fill In Password
    Click Element    ${password}
    Input Text    ${password}    ${password_to_populate}

Check Expected Result
    Check If Page Is Loaded With Argument ${book_title}
     ${output} =  Get WebElement  ${user_name_value}
     Log To Console    ${output.text}
     Should Match     ${output.text}    ${user_name_to_populate}

Close Webpage
    Close Browser

