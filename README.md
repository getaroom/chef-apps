Configures Apps

Tested on Ubuntu 12.04

# Attributes

* `node['framework_environment']` - The environment/mode a framework, such as Rails, should use - defaults to the chef_environment

# Recipes

## capistrano

* Setup apps' directories in a Capistrano deployment skeleton.
  Equivalent to the `deploy:setup` Capistrano task

## logrotate

* Setup apps' log rotation.

## user

* Setup apps' user from the apps data bag.
* Setup apps' user public SSH keys from the users data bag.

# Example Data Bag Items

## Apps

```json
{
  "id": "www",
  "server_roles": ["www"],
  "owner": "www",
  "group": "www",
  "deploy_to": "/srv/www"
}
```

## Users

```json
{
  "id": "jdoe",
  "ssh_keys": ["ssh-rsa AAAAB3Nz...yhCw== jdoe"]
}
```

# License and Authors

* Chris Griego (<cgriego@getaroom.com>)

Copyright 2012, getaroom

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
