from evdev import InputDevice, categorize, ecodes
from select import select

def detectInputKey():
	dev = InputDevice('/dev/input/event1')
	print(dev)
#	while True:
#		select([dev], [], [])
#		for event in dev.read():
#			print "code: %s value: %s" %(event.code, event.value)
	for event in dev.read_loop():
		if event.type == ecodes.EV_KEY:
			print(categorize(event))

if __name__ == "__main__":
	detectInputKey()
