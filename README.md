# Unbound

[![Build Status](https://travis-ci.org/johanfleury/puppet-unbound.svg?branch=master)](https://travis-ci.org/johanfleury/puppet-unbound)

## Overview

Unbound is a validating, recursive, and caching DNS resolver.


## Table of Contents

1. [Module description](#module-description)
2. [Usage](#usage)
3. [Reference](#reference)
  - [Public classes](#public-classes)
  - [Private classes](#private-classes)
  - [Public defined types](#public-defined-types)
5. [Limitations](#limitations)
6. [Development](#development)


## Module description

This module installs, configures and manages Unbound.


## Usage


### Beginning with `unbound`


## Reference

### Public classes

#### Class `unbound`

##### Parameters


### Private classes

* `unbound::install`
* `unbound::config`
* `unbound::server`
* `unbound::remote_config`
* `unbound::module_config`
* `unbound::python`
* `unbound::service`


### Public defined types

#### Defined type `unbound::stub_zone`:

##### Parameters


#### Defined type `unbound::forward_zone`:

##### Parameters


#### Defined type `unbound::view`:

##### Parameters


## Limitations

This module only works with systemd. It has only been tested on Debian 8
(Jessie).


## Development

Puppet modules on the Puppet Forge are open projects, and community
contributions are essential for keeping them great. Please follow our
guidelines when contributing changes.

For more information, see our [module contribution
guide.](https://docs.puppetlabs.com/forge/contributing.html)
