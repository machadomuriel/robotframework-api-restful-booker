

# Robot Framework API Automation Example

## Introduction

Robot Framework is an open-source test automation framework based on Python, which allows for easy and efficient creation of tests. More information about Robot Framework can be found at [https://robotframework.org/](https://robotframework.org/).

## API Under Test

This project performs API tests on the "restful-booker" API, a public API for testing available at [https://restful-booker.herokuapp.com/apidoc/index.html](https://restful-booker.herokuapp.com/apidoc/index.html).

## Overview of Tests

The tests performed in this project cover the following functionalities:

* Authentication
* Creating bookings
* Getting bookings
* Updating bookings
* Deleting bookings

## Libraries Used

This project uses the following libraries:

* [RequestsLibrary](https://github.com/bulkan/robotframework-requests)
* [JSONLibrary](https://github.com/robotframework-thailand/robotframework-jsonlibrary?tab=readme-ov-file)
* [Collections](https://robotframework.org/robotframework/latest/libraries/Collections.html)

## Project Architecture

The project architecture is organized as follows:

* `tests/`: folder containing API tests
* `resources/`: folder containing resources used in tests (such as libraries and variables)
* `common/`: folder containing common functions and variables used in tests

## Conventions Adopted

To keep the code clean and standardized, it was adopt the following conventions:

| Element | Suggested Convention | Example |
| --- | --- | --- |
| Files and folders | snake_case.robot | login_tests.robot |
| Test Cases | PascalCase or spaced | Login With Valid Credentials |
| Keywords | PascalCase or spaced | Fill Login Fields |
| Variables | ${snake_case} or ${UPPER_SNAKE_CASE} | ${user}, ${BASE_URL} |
| Dictionaries/Lists | snake_case | @{user_list}, &{user_data} |

## Project Configuration

To configure the project, follow these steps:

1. Install Python 3.
2. Clone the repository and navigate to the project folder.
3. Optional: Create a virtual environment for Python. 
* Create a new virtual environment using python3 -m venv .venv
* Activate a virtual environment using source .venv/bin/activate
4. Run the command `pip install -r requirements.txt` to install dependencies.
5. Run the command `robot -d log .` to execute the tests.

## Contact

For more information or questions, contact me on LinkedIn: [https://www.linkedin.com/in/murielmachado/](https://www.linkedin.com/in/murielmachado/).