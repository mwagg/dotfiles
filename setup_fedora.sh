#!/bin/bash

sudo dnf install \
	fish \
	emacs \
	autojump \
	stow \
	cmake \
	zlib-devel \
	bzip2 \
	bzip2-devel \
	readline-devel \
	sqlite \
	sqlite-devel \
	openssl-devel \
	xz \
	xz-devel \
	libffi-devel \
	findutils \
	libtool \
	tilix \
	tldr \
	gnome-tweaks \
	postgresql-server \
	postgresql-contrib

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install com.slack.Slack -y

sudo usermod -s $(which fish) $USER
	


