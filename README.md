# Coreboot with Tianocore for ThinkPad X220
Dockerfile + scripts to simplify building and updating coreboot for Lenovo ThinkPad X220.

## How compile?

1. Clone this repo
2. Make sure all the files in ```files``` directory make sense:
	- ```splash.bmp``` is the boot splash image that will be used
	- ```lenovox220.bin``` is a dump of the stock X220 bios. Used to extract some blobs. Ripping it from a bios update file off of Lenovo's website would probably work but it's not tested
	- ```defconfig``` is the config file to make it all work for X220. No need to mess with it too much unless some major options get deprecated/modified on coreboot's side
	- ```prepX220``` is the actual script that puts everything in place - pulls in the coreboot repo, sets up the toolchain, compiles all the tools needed and extracts the blobs from the bios image
3. Run ```./build.sh``` to build the Docker image
4. Run ```./run.sh``` to run the container
5. When inside the container, run ```prepX220```, after it's done make sure you're inside ```/src/coreboot```
6. Check configs with ```make menuconfig``` or ```make nconfig```, then **SAVE!**
7. Finally run ```make -j12```, tweak the number of jobs to taste.

After that you'll have your new bios file in ```/src/coreboot/build/coreboot.rom```. 

## How flash?

This will likely only work if you're already running coreboot. If you're not, skip to the next section.

1. Make sure you have ```flashrom``` installed
2. Make sure you have ```iomem=relaxed``` added to your kernel command line (on Fedora Silverblue you can add it with ```rpm-ostree kargs --append=iomem=relaxed```, then reboot).
3. Copy your bios file (```coreboot.rom```) somewhere easily accessible by ```flashrom```
4. Flash the bios with ```sudo flashrom -p internal:laptop=force_I_want_a_brick -w coreboot.rom -c MX25L6436E/MX25L6445E/MX25L6465E/MX25L6473E/MX25L6473F```. Heed the scary warning flag and remember the chip might vary on your particular model, so make sure you know what you're doing. **IF YOU SEE ANY ERRORS AT ALL, DO NOT REBOOT!** You won't be able to boot.
5. If it flashed without errors, your bios is installed, reboot to use it.

## How flash if I don't already have coreboot?

You have program the flash chip with a standalone SPI programmer. Hope you know how to do that. If not, there's plenty of tutorials online. 

You're gonna need a SOIC8 clip and a programmer of some description, Raspberry Pi works fine. You can also use USB based programmers.

The chip is located near the ExpressCard slot, towards the bottom of the mainboard. It's easily accessible if you take off the palmrest. You'll need to peel up the corner of the the black insulation tape to get to it.