/****************************************************************************
 *
 *   Copyright (c) 2017 PX4 Development Team. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name PX4 nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/

// implementation based on Adafruit_SSD1306 (https://github.com/adafruit/Adafruit_SSD1306) BSD-3 licensed

#include "SSD1306.hpp"

#include <string.h>


static SSD1306 *g_ssd = nullptr;

SSD1306::SSD1306(int bus) : I2C("ssd1306", SSD1306_DEVICE_PATH, bus, SSD1306_I2C_ADDRESS, 100000)
{
}

SSD1306::~SSD1306()
{
	_should_run = false;

	orb_unsubscribe(_battery_sub);
	orb_unsubscribe(_gps_sub);

	work_cancel(LPWORK, &_work);
}

int SSD1306::init()
{
	int ret;
	ret = I2C::init();

	if (ret != OK) {
		return ret;
	}

	work_queue(LPWORK, &_work, SSD1306::start_trampoline, g_ssd, 0);

	return OK;
}

void SSD1306::start_trampoline(void *arg)
{
	reinterpret_cast<SSD1306 *>(arg)->start();
}

void SSD1306::start()
{
	// TODO: check this
	int vccstate = SSD1306_EXTERNALVCC;

	// Init sequence
	ssd1306_command(SSD1306_DISPLAYOFF);                    // 0xAE
	ssd1306_command(SSD1306_SETDISPLAYCLOCKDIV);            // 0xD5
	ssd1306_command(0x80);                                  // the suggested ratio 0x80

	ssd1306_command(SSD1306_SETMULTIPLEX);                  // 0xA8
	ssd1306_command(SSD1306_LCDHEIGHT - 1);

	ssd1306_command(SSD1306_SETDISPLAYOFFSET);              // 0xD3
	ssd1306_command(0x0);                                   // no offset
	ssd1306_command(SSD1306_SETSTARTLINE | 0x0);            // line #0
	ssd1306_command(SSD1306_CHARGEPUMP);                    // 0x8D

	if (vccstate == SSD1306_EXTERNALVCC) {
		ssd1306_command(0x10);

	} else {
		ssd1306_command(0x14);
	}

	ssd1306_command(SSD1306_MEMORYMODE);                    // 0x20
	ssd1306_command(0x00);                                  // 0x0 act like ks0108
	ssd1306_command(SSD1306_SEGREMAP | 0x1);
	ssd1306_command(SSD1306_COMSCANDEC);

	ssd1306_command(SSD1306_SETCOMPINS);                    // 0xDA
	ssd1306_command(0x12);
	ssd1306_command(SSD1306_SETCONTRAST);                   // 0x81

	if (vccstate == SSD1306_EXTERNALVCC) {
		ssd1306_command(0x9F);

	} else {
		ssd1306_command(0xCF);
	}

	ssd1306_command(SSD1306_SETPRECHARGE);                  // 0xd9

	if (vccstate == SSD1306_EXTERNALVCC) {
		ssd1306_command(0x22);

	} else {
		ssd1306_command(0xF1);
	}

	ssd1306_command(SSD1306_SETVCOMDETECT);                 // 0xDB
	ssd1306_command(0x40);
	ssd1306_command(SSD1306_DISPLAYALLON_RESUME);           // 0xA4
	ssd1306_command(SSD1306_NORMALDISPLAY);                 // 0xA6

	//ssd1306_command(SSD1306_DEACTIVATE_SCROLL);

	ssd1306_command(SSD1306_DISPLAYON);//--turn on oled panel


	// Clear the buffer.
	clear_display();

	// draw a single pixel
	draw_pixel(10, 10, WHITE);

	// Show the display buffer on the hardware.
	// NOTE: You _must_ call display after making any drawing commands
	// to make them visible on the display hardware!
	display();

	_should_run = true;

	_gps_sub = orb_subscribe(ORB_ID(vehicle_gps_position));
	_battery_sub = orb_subscribe(ORB_ID(battery_status));

	work_queue(LPWORK, &_work, SSD1306::cycle_trampoline, this, 0);
}

void SSD1306::cycle_trampoline(void *arg)
{
	reinterpret_cast<SSD1306 *>(arg)->cycle();
}

void SSD1306::cycle()
{
	if (_should_run) {
		bool updated = false;

		updated = false;
		orb_check(_battery_sub, &updated);

		if (updated) {
			battery_status_s batt;
			orb_copy(ORB_ID(battery_status), _battery_sub, &batt);
			// battery
			//  print battery level
		}

		updated = false;
		orb_check(_gps_sub, &updated);

		if (updated) {
			vehicle_gps_position_s gps;
			orb_copy(ORB_ID(vehicle_gps_position), _gps_sub, &gps);

			// gps
			// fix, # sats
		}

		// Mode
		// EKF status?

		// Show the display buffer on the hardware.
		// NOTE: You _must_ call display after making any drawing commands
		// to make them visible on the display hardware!
		display();

		work_queue(LPWORK, &_work, SSD1306::cycle_trampoline, this, _interval);
	}
}

void SSD1306::ssd1306_command(uint8_t c)
{
	uint8_t cmd = 0x00;   // Co = 0, D/C = 0
	transfer(&cmd, 1, nullptr, 0);
	transfer(&c, 1, nullptr, 0);
}

void SSD1306::invert_display(uint8_t i)
{
	if (i) {
		ssd1306_command(SSD1306_INVERTDISPLAY);

	} else {
		ssd1306_command(SSD1306_NORMALDISPLAY);
	}
}

// Dim the display
// dim = true: display is dimmed
// dim = false: display is normal
void SSD1306::dim_display(bool dim)
{
	uint8_t contrast;

	if (dim) {
		contrast = 0; // Dimmed display

	} else {
		if (_vccstate == SSD1306_EXTERNALVCC) {
			contrast = 0x9F;

		} else {
			contrast = 0xCF;
		}
	}

	// the range of contrast to too small to be really useful
	// it is useful to dim the display
	ssd1306_command(SSD1306_SETCONTRAST);
	ssd1306_command(contrast);
}

void SSD1306::display()
{
	ssd1306_command(SSD1306_COLUMNADDR);
	ssd1306_command(0);   // Column start address (0 = reset)
	ssd1306_command(SSD1306_LCDWIDTH - 1); // Column end address (127 = reset)

	ssd1306_command(SSD1306_PAGEADDR);
	ssd1306_command(0); // Page start address (0 = reset)
#if SSD1306_LCDHEIGHT == 64
	ssd1306_command(7); // Page end address
#endif
#if SSD1306_LCDHEIGHT == 32
	ssd1306_command(3); // Page end address
#endif
#if SSD1306_LCDHEIGHT == 16
	ssd1306_command(1); // Page end address
#endif

	// TODO: FIX this is almost certainly wrong
	for (uint16_t i = 0; i < (SSD1306_LCDWIDTH * SSD1306_LCDHEIGHT / 8); i++) {
		// send a bunch of data in one xmission
		uint8_t cmd = 0x40;
		transfer(&cmd, 1, nullptr, 0);

		for (uint8_t x = 0; x < 16; x++) {
			transfer(&_buffer[i], 1, nullptr, 0);
			i++;
		}

		i--;
	}
}

// clear everything
void SSD1306::clear_display()
{
	memset(_buffer, 0, (SSD1306_LCDWIDTH * SSD1306_LCDHEIGHT / 8));
}

// the most basic function, set a single pixel
void SSD1306::draw_pixel(int16_t x, int16_t y, uint16_t color)
{
	// x is which column
	switch (color) {
	case WHITE:
		_buffer[x + (y / 8)*SSD1306_LCDWIDTH] |= (1 << (y & 7));
		break;

	case BLACK:
		_buffer[x + (y / 8)*SSD1306_LCDWIDTH] &= ~(1 << (y & 7));
		break;

	case INVERSE:
		_buffer[x + (y / 8)*SSD1306_LCDWIDTH] ^= (1 << (y & 7));
		break;
	}
}

extern "C" __EXPORT int ssd1306_main(int argc, char *argv[]);

static const char commandline_usage[] = "usage: ssd1306 start|status|stop";

int ssd1306_main(int argc, char *argv[])
{
	if (argc < 2) {
		PX4_WARN("missing command\n%s", commandline_usage);
		return 1;
	}

	if (!strcmp(argv[1], "start")) {

		if (g_ssd) {
			PX4_WARN("already running");
			return 0;
		}

		g_ssd = new SSD1306(PX4_I2C_BUS_EXPANSION);

		if (g_ssd != nullptr && OK != g_ssd->init()) {
			delete g_ssd;
			g_ssd = nullptr;
		}

		return 0;
	}

	if (!strcmp(argv[1], "stop")) {
		if (!g_ssd) {
			PX4_WARN("not running");
			exit(0);
		}

		delete g_ssd;
		g_ssd = nullptr;

		PX4_INFO("stopped");

		return 0;
	}

	if (!strcmp(argv[1], "status")) {
		if (g_ssd) {
			PX4_INFO("is running");

		} else {
			PX4_INFO("is not running");
		}

		exit(0);
	}

	PX4_WARN("unrecognized command\n%s", commandline_usage);
	return 1;
}
