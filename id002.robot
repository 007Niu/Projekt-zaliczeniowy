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
${book1}                            xpath://*[@id="see-book-Git Pocket Guide"]
${add_to_your_collection_button}    xpath:(//*[@class="text-right fullButton"]/*[@id="addNewRecordButton"])
${message_with_second_book}         Book already present in the your collection!
${message_with_add_book}            Book added to your collection.
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


Add Book Test
    Check If Page Is Loaded
    Click Login Button
    Fill In UserName
    Fill In Password
    Click Login Button
    Click On Book
    Add Book
    Add Book Second Time

*** Keywords ***
Open Webpage
    Open Browser                https://demoqa.com/books        chrome
    Maximize Browser Window

Click Login Button
    Click Button    ${login_button}

Check If Page Is Loaded
    Wait Until Page Contains    Book Store

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

Click On Book
    Check If Page Is Loaded With Argument ${book_title}
    Click Element    ${book1}

Add Book
    Check If Page Is Loaded With Argument ${book_title}
    execute javascript    window.scrollTo(0,500)
    Click Button    ${add_to_your_collection_button}
    ${message}=  Handle Alert  action=accept
    Log To Console     ${message}
    Should Match    ${message_with_add_book}  ${message}

Add Book Second Time
    Check If Page Is Loaded With Argument ${book_title}
    Click Button    ${add_to_your_collection_button}
    ${message}=  Handle Alert  action=accept
    Log To Console     ${message}
    Should Match    ${message_with_second_book}  ${message}

Close Webpage
    Close Browser

