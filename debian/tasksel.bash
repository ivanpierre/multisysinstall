#!/bin/bash

# u kubuntu-live	            Kubuntu live CD
# u lubuntu-live-gtk	        Lubuntu live CD (GTK part)
# u ubuntu-budgie-live	        Ubuntu Budgie live CD
# u ubuntu-live	Ubuntu          live CD
# u ubuntu-mate-live	        Ubuntu MATE Live CD
# u ubuntustudio-dvd-live	    Ubuntu Studio live DVD
# u vanilla-gnome-live	        Ubuntu GNOME live CD
# u xubuntu-live	            Xubuntu live CD
# u cloud-image	                Ubuntu Cloud Image (instance)
# u dns-server	                DNS server
# u kubuntu-desktop	            Kubuntu desktop
# u kubuntu-full	            Kubuntu full
# u lamp-server	                LAMP server
# u lubuntu-core	            Lubuntu minimal installation
# u lubuntu-desktop	            Lubuntu Desktop
# u lubuntu-gtk-core	        Lubuntu minimal installation (GTK part)
# u lubuntu-gtk-desktop	        Lubuntu Desktop (GTK part)
# u lubuntu-qt-core	            Lubuntu minimal installation (Qt part)
# u lubuntu-qt-desktop	        Lubuntu Qt Desktop (Qt part)
# u mail-server	                Mail server
# u postgresql-server	        PostgreSQL database
# i print-server	            Print server
# i samba-server	            Samba file server
# u ubuntu-budgie-desktop	    Ubuntu Budgie desktop
# u ubuntu-desktop	            Ubuntu desktop
# u ubuntu-mate-core	        Ubuntu MATE minimal
# u ubuntu-mate-desktop	        Ubuntu MATE desktop
# i ubuntustudio-audio	        Audio recording and editing suite
# u ubuntustudio-desktop	    Ubuntu Studio desktop
# u ubuntustudio-desktop-core	Ubuntu Studio minimal DE installation
# u ubuntustudio-fonts	        Large selection of font packages
# u ubuntustudio-graphics	    2D/3D creation and editing suite
# u ubuntustudio-photography	Photograph touchup and editing suite
# u ubuntustudio-publishing	    Publishing applications
# u ubuntustudio-video	        Video creation and editing suite
# u vanilla-gnome-desktop	    Vanilla GNOME desktop
# u xubuntu-core	            Xubuntu minimal installation
# u xubuntu-desktop	            Xubuntu desktop
# u debian-multimedia	        Debian Multimedia Pure Blend

####
# tasksel (get complementary packages)
inst_apt tasksel

#opt="install -t --task-packages"
opt="install"

sudo tasksel $opt ubuntustudio-audio	        # Audio recording and editing suite
sudo tasksel $opt ubuntustudio-fonts	        # Large selection of font packages
sudo tasksel $opt ubuntustudio-graphics	        # 2D/3D creation and editing suite
sudo tasksel $opt ubuntustudio-photography	    # Photograph touchup and editing suite
sudo tasksel $opt ubuntustudio-publishing	    # Publishing applications
sudo tasksel $opt ubuntustudio-video	        # Video creation and editing suite

sudo tasksel $opt multimedia-ambisonics	        # Packages for working with ambisonics (3D surround sound)
sudo tasksel $opt multimedia-animation	        # Packages for creating animations
sudo tasksel $opt multimedia-audio-plugins	    # Audio processing plugins, synths and virtual instruments
sudo tasksel $opt multimedia-audio-utilities	# packages for manipulating & cataloging music and audio
# sudo tasksel $opt multimedia-broadcasting	    # Packages for broadcasting media publicly or in the home
sudo tasksel $opt multimedia-csound	            # Packages for working with Csound
sudo tasksel $opt multimedia-devel	            # Extra packages for developers and package compiling
sudo tasksel $opt multimedia-djing	            # Packages for Disk Jockeys
sudo tasksel $opt multimedia-drums	            # Packages for drums & beats
sudo tasksel $opt multimedia-firewire	        # Packages for your firewire audiocard / interface
sudo tasksel $opt multimedia-graphics	        # Packages for making and editing artwork
sudo tasksel $opt multimedia-guitar	            # Packages for playing with your (virtual) guitar gear
sudo tasksel $opt multimedia-jack	            # JACK (Jack Audio Connection Kit) and ALSA related packages
sudo tasksel $opt multimedia-ladi	            # LADI, Linuxaudio session management, packages
sudo tasksel $opt multimedia-looping	        # Packages for looping music and audio
sudo tasksel $opt multimedia-midi	            # MIDI related packages
sudo tasksel $opt multimedia-mixing	            # Packages for mixing and mastering your music
sudo tasksel $opt multimedia-musiciantools	    # Packages for musicians
sudo tasksel $opt multimedia-photography	    # Packages for working with digital photography
sudo tasksel $opt multimedia-players	        # Packages which makes your multimedia tools complete
sudo tasksel $opt multimedia-puredata	        # Packages for working with Pure Data
sudo tasksel $opt multimedia-recording	        # Packages for audio recording
sudo tasksel $opt multimedia-samplers	        # Software samplers
sudo tasksel $opt multimedia-soundsynthesis	    # Packages for sound synthesis
sudo tasksel $opt multimedia-supercollider	    # Packages for working with SuperCollider
sudo tasksel $opt multimedia-video	            # Video packages

# i openssh-server	OpenSSH server
# u server	Basic Ubuntu server
