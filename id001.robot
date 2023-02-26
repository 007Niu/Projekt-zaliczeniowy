*** Settings ***
Library             SeleniumLibrary
Library             Dialogs                         #Enable manual step during automated test execution
Test Setup          Open Webpage
Test Teardown       Close Webpage
Suite Setup         Set Selenium Speed      0.5     #Changing the speed of test execution

*** Variables ***

${login_button}            xpath://*[@id="login"]
${new_user_button}         xpath://*[@id="newUser"]
${first_name_input}        xpath://*[@id="firstname"]
${last_name_input}         xpath://*[@id="lastname"]
${user_name_input}         xpath://*[@id="userName"]
${password_input}          xpath://*[@id="password"]
${register}                xpath://*[@id="register"]
${error}                   xpath://*[@id="name"]
${expected_error_text}     Passwords must have at least one non alphanumeric character, one digit ('0'-'9'), one uppercase ('A'-'Z'), one lowercase ('a'-'z'), one special character and Password must be eight characters or longer.
${login_info}              Login
${register_info}           Register

*** Test Cases ***
Validate the password when a new user is registered
    Check If Page Is Loaded
    Go To Login Page
    Go To New User Page
    Fill In First Name
    Fill In Last Name
    Fill In User Name
    Fill In Password
    Check I Am Not A Robot
    Click Register
    Check Expected Result

*** Keywords ***

Open Webpage
    Open Browser                https://demoqa.com/books        chrome
    Maximize Browser Window

Check If Page Is Loaded
     Wait Until Page Contains    Book Store

Check If Page Is Loaded With Argument ${title}
     Wait Until Page Contains    ${title}

Go To Login Page
    Click Button                        ${login_button}

Go To New User Page
    Check If Page Is Loaded With Argument ${login_info}
    Click Button                        ${new_user_button}

Fill In First Name
    Check If Page Is Loaded With Argument ${register_info}
    Click Element                       ${first_name_input}
    Input Text    ${first_name_input}    Name

Fill In Last Name
    Click Element    ${last_name_input}
    Input Text    ${last_name_input}    Last

Fill In User Name
    Click Element    ${user_name_input}
    Input Text    ${user_name_input}    User

Fill In Password
    Click Element    ${password_input}
    Input Text    ${password_input}    123

Check I am not a robot
    Pause Execution    Enter captcha
    Sleep    2s

Click Register
     Click Element    ${register}
     Sleep    2s

Check Expected Result
     ${output} =  Get WebElement  ${error}
     Log To Console    ${output.text}
     Should Match     ${output.text}    ${expected_error_text}

Close Webpage
    Close Browser

