# Embedded BDD Test Suite

A Behaviour Driven Development (BDD) test framework for embedded systems CLI validation,
built with Robot Framework and Python. Simulates serial communication with a chassis
manager and validates command/response behaviour using Given/When/Then test structure.

---

## Skills Demonstrated

- BDD test design using Gherkin-style syntax in Robot Framework
- Python keyword library development with mock serial interface (PySerial-ready)
- Embedded CLI command validation (SET_FAN_SPEED, error handling, boundary conditions)
- Structured test organisation with tags for regression filtering

---

## Project Structure

embedded-bdd-suite/
├── tests/
│   ├── fan_control.robot        # BDD test scenarios
│   └── resources/
│       └── SerialLibrary.py     # Python keyword library (mock serial)
├── results/                     # Auto-generated HTML reports (git ignored)
├── .gitignore
└── README.md

---

## How to Run

**1. Clone the repo**
git clone https://github.com/mistrymitul/embedded-bdd-suite.git
cd embedded-bdd-suite

**2. Create and activate virtual environment**
python -m venv venv
venv\Scripts\activate.bat        # Windows

**3. Install dependencies**
pip install robotframework pyserial

**4. Run the test suite**
robot --outputdir results tests/fan_control.robot

**5. Open the HTML report**
start results/report.html        # Windows

---

## Test Results 

| Scenario | Status |
|---|---|
| Set fan to 50% speed | PASS |
| Set fan to maximum speed (100%) | PASS |
| Reject invalid fan speed above maximum | PASS |

3/3 passing
