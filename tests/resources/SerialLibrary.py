import time

class SerialLibrary:
    """
    Mock serial library for BDD embedded CLI testing.
    Simulates a chassis manager responding to commands.
    Replace mock responses with real PySerial calls when hardware is available.
    """

    def __init__(self):
        self.connected = False
        self.last_command = None
        self.last_response = None
        self.fan_speed = 0

    # --- MOCK RESPONSE ENGINE ---

    def _send_and_receive(self, command):
        """
        Simulates sending a command and receiving a response.
        In production: replace with serial.write() + serial.readline()
        """
        self.last_command = command
        parts = command.strip().split()

        if parts[0] == "SET_FAN_SPEED":
            try:
                value = int(parts[1])
                if 0 <= value <= 100:
                    self.fan_speed = value
                    return "OK"
                else:
                    return "ERROR: VALUE_OUT_OF_RANGE"
            except (IndexError, ValueError):
                return "ERROR: INVALID_SYNTAX"

        return "ERROR: UNKNOWN_COMMAND"

    # --- ROBOT FRAMEWORK KEYWORDS ---

    def the_chassis_is_powered_on(self):
        """Background: the chassis is powered on"""
        self.connected = True
        self.fan_speed = 0
        self.last_response = None
        print("Mock chassis powered on and ready.")

    def i_send_the_command(self, command):
        """When I send the command    <command>"""
        if not self.connected:
            raise AssertionError("Cannot send command: chassis is not powered on.")
        self.last_response = self._send_and_receive(command)
        print(f"  >> Sent:     {command}")
        print(f"  >> Received: {self.last_response}")

    def the_response_should_be(self, expected_response):
        """Then the response should be    <expected>"""
        actual = self.last_response
        if actual != expected_response:
            raise AssertionError(
                f"Response mismatch.\n"
                f"  Expected: '{expected_response}'\n"
                f"  Actual:   '{actual}'"
            )

    def the_fan_speed_should_read(self, expected_speed):
        """And the fan speed should read    <value>"""
        expected = int(expected_speed)
        if self.fan_speed != expected:
            raise AssertionError(
                f"Fan speed mismatch.\n"
                f"  Expected: {expected}\n"
                f"  Actual:   {self.fan_speed}"
            )