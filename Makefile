#
# Makefile
#
CC = gcc
CFLAGS = -Wall -Wshadow -Wundef -Wmaybe-uninitialized -fbounds-check

LVGL_DIR = ${shell pwd}

CFLAGS += -O3 -g3 -I$(LVGL_DIR)/
LDFLAGS += -lSDL2 -lm
BIN = demo


#Collect the files to compile
MAINSRC = ./main.c

include $(LVGL_DIR)/lvgl/lvgl.mk
include $(LVGL_DIR)/lv_drivers/lv_drivers.mk
include $(LVGL_DIR)/lv_examples/lv_examples.mk

CSRCS +=$(LVGL_DIR)/lv_mister/mouse_cursor_icon.c
CSRCS +=$(LVGL_DIR)/lv_mister/wifi.c
CSRCS +=$(LVGL_DIR)/lv_mister/iniedit.c
CSRCS +=$(LVGL_DIR)/lv_mister/mainmenu.c
CSRCS +=$(LVGL_DIR)/lv_mister/window.c
CSRCS +=$(LVGL_DIR)/lv_mister/browser.c

OBJEXT ?= .o

AOBJS = $(ASRCS:.S=$(OBJEXT))
COBJS = $(CSRCS:.c=$(OBJEXT))

MAINOBJ = $(MAINSRC:.c=$(OBJEXT))

SRCS = $(ASRCS) $(CSRCS) $(MAINSRC)
OBJS = $(AOBJS) $(COBJS)

## MAINOBJ -> OBJFILES

all: default

%.o: %.c
	@$(CC)  $(CFLAGS) -c $< -o $@
	@echo "CC $<"
    
default: $(AOBJS) $(COBJS) $(MAINOBJ)
	$(CC) -o $(BIN) $(MAINOBJ) $(AOBJS) $(COBJS) $(LDFLAGS)

clean: 
	rm -f $(BIN) $(AOBJS) $(COBJS) $(MAINOBJ)

