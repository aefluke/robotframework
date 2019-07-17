*** Settings ***
Library     Selenium2Library
Library     XvfbRobot

*** Variables ***
${BASE_URL}       https://avansas.com
${TMP_PATH}                 /tmp

*** Test Cases ***
Open Google
    Start Virtual Display    1920    1080
    Open Chrome Browser
    GoTo    https://avansas.com
    ${title}=       Get Title
    Should Contain    ${title}    Avansas
    Search For An Item          Su
    Item Should Be Queried      Su
    Close Browser

*** Keywords ***
Open Chrome Browser
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method  ${options}  add_argument  --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}

Search For An Item
    [Arguments]  ${item}
    Input Text      css:#multiple-datasets > span > input.search-input.tt-input         ${item}
    Click Button    css:#multiple-datasets > button

Item Should Be Queried
    [Arguments]     ${item}
    ${itemHeader} =     Get Text    css:#main > div:nth-child(3) > div > header > h1
    Should Be Equal As Strings    ${itemHeader}         ${item}
    Capture Page Screenshot



    