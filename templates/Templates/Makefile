TARGET = main
OBJDIR = obj
SRCDIR = src
INCDIR = include
LIBDIR = lib

CC = gcc

LIBS =
LDLIBS = $(addprefix -l,$(LIBS))

CFLAGS = -std=c99 -pedantic -Wall
ifndef RELEASE
CFLAGS += -g
endif
CPPFLAGS = -I $(INCDIR)
LDFLAGS = -L $(LIBDIR)
EFLAGS =

SRCS = $(shell find $(SRCDIR) -type f -iname '*.c')
OBJS = $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))

.PHONY: all
all: $(TARGET)

.PHONY: run
run: all
	./$(TARGET) $(EFLAGS)

.PHONY: clean
clean:
	$(RM) -r $(OBJDIR) $(TARGET)

.PHONY: test
test:
	@echo $(OBJS)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@
