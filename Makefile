CFLAGS += -Wall -ggdb -O2
LDLIBS += -lm -lcurl

TARGET = corsairmi

all: $(TARGET)

clean:
	$(RM) $(TARGET)

.PHONY: all clean
