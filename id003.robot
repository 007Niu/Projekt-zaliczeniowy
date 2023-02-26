*** Settings ***
Library             SeleniumLibrary
Library             Collections    #Enabling list creation and working on the lists.
Test Setup          Open Webpage
Test Teardown       Close Webpage
Suite Setup         Set Selenium Speed      0.5    #Changing the speed of test execution

*** Variables ***

${title}                    xpath:(//*[@class="rt-resizable-header-content"])[2]
${table_title_element}      xpath://*[@class="rt-td"]/*[@class="action-buttons"]

*** Test Cases ***
Verification of book sorting functionality
    Check If Page Is Loaded
    Click Title Column
    Check Order

*** Keywords ***
Open Webpage
    Open Browser                https://demoqa.com/books        chrome
    Maximize Browser Window

Check If Page Is Loaded
    Wait Until Page Contains    Book Store

Click Title Column
    Click Element    ${title}

Check Order
    @{list_web_elements} =       Get WebElements     ${table_title_element}
       ${list} =  Create List
    FOR     ${book}  IN  @{list_web_elements}
        Append To List    ${list}    ${book.text}
    END

    ${sorted_list} =  Copy List  ${list}
    Sort List   ${sorted_list}
    Log To Console      ${sorted_list}
    Lists Should Be Equal     ${sorted_list}    ${list}

Close Webpage
    Close Browser

