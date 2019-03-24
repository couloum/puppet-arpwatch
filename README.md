# arpwatch

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with arpwatch](#setup)
    * [Beginning with arpwatch](#beginning-with-arpwatch)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
1. [Release Notes](#release-notes)

## Description

Install and configure arpwatch

## Setup

### Beginning with arpwatch

`include ::arpwatch` is enough to get you up and running.

## Usage

All interaction with the arpwatch module is done through the main arpwatch class. You can simply set the options in `::arpwatch` to have full functionality of the module.

## Reference

See [REFERENCE.md](REFERENCE.md)

## Limitations

This module currently supports RedHat and Debian distributions. It has only been thoroughly tested under Ubuntu.
This module support puppet 5 and 6 only.
Pull requests are welcome to add support for other platforms.

## Development

Pull requests are welcome. Please make sure to properly document any additions or changes made to the module.

## Release Notes

v0.1.0 - Initial release of arpwatch module, based on ardichoke-arpwatch, for puppet 5+
