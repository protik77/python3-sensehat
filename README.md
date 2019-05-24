# Docker container for Raspberry Pi Sensehat with Python 3!

## Note: This project is forked from [bmwshop/sensehat](https://github.com/bmwshop/sensehat),



### Using the docker image:

Create a temporary container,
```bash
docker run --privileged --name sensehat -ti protik77/python3-sensehat bash
```

This should pull the image from the docker hub, create a temporary container with an interactive shell. The prompt at this point should look like,
```bash
root@0cab39t3d53:/code#
```

Now run the test code using,
```bash
python3 test.py
```

This should print the current temperature and show the message "It worked!".

Type `exit` and this should give back the original shell. The temporary container will be removed automatically.

See the [SenseHat API docs](https://pythonhosted.org/sense-hat/) for more SenseHat API.

### Changes made from the original repository:

* Python3 based. Python 3.4 to be exact.
* Based on official `arm32v7/debian:jessie` based rather than `armhf/ubuntu` image which is not supported anymore. Also the required `RTIMULIB` version is only supported for `debian:jessie`
* Updated `RTIMULIB` to version `7.2.1-3`. Even though `7.2.1-4` and `7.2.1-5` are out there, they don't work with `debian:jessie` based image.
* Moved test code `test.py` into `/code` directory.
