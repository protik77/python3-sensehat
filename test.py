from sense_hat import SenseHat


if __name__ == "__main__":

    sense = SenseHat()
    sense.clear()

    temperature = sense.get_temperature_from_humidity()
    print("Current temperature: {} C\n".format(temperature))

    sense.show_message("It worked!")
