# lita-etcd

**lita-etcd** is a handler plugin for [Lita](https://www.lita.io/) that lets you interact with an [etcd](https://github.com/coreos/etcd) cluster.

## Installation

Add lita-etcd to your Lita instance's Gemfile:

``` ruby
gem "lita-etcd"
```

## Configuration

* **host** (`String`) - The network hostname or IP address of the etcd server. Default: `"127.0.0.1"`.
* **port** (`Integer`) - The network port of the etcd server. Default: `4001`.
* **username** (`String`) - A username for basic authentication on the etcd server. Default: `nil`.
* **password** (`String`) - A password for basic authentication on the etcd server. Default: `nil`.
* **ssl** (Boolean) - Set to `true` to connect to etcd over HTTPS. Default: `false`.
* **ssl_ca_file** (`String`) - The path to a custom certificate authority certificate to use. Default: `nil`.
* **ssl_cert** (SSL Certificate) - The contents of a client certificate to use. Default: `nil`.
* **ssl_key** (SSL Key) - The unencrypted contents of the client key. Default: `nil`.
* **ssl_verify_mode** (SSL Verify Mode) - The certificate verification mode. Default: `OpenSSL::SSL::VERIFY_PEER`.
* **timeout** (`Integer`) - The maximum number of seconds to wait for a connection to etcd. Default: `60`.
* **allow_redirect** (Boolean) - Set to `false` to require commands to be run against the etcd leader. Default: `true`.

### Example

``` ruby
Lita.configure do |config|
  config.handlers.etcd.host = "1.2.3.4"
  config.handlers.etcd.port = 5678

  config.handlers.etcd.username = "carl"
  config.handlers.etcd.password = "secret"

  config.handlers.etcd.ssl = true
  config.handlers.etcd.ssl_ca_file = "/path/to/ca-bundle.crt"
  config.handlers.etcd.ssl_cert = OpenSSL::X509::Certificate.new(File.read("/path/to/my-cert.crt"))
  config.handlers.etcd.ssl_key = OpenSSL::PKey::RSA.new("/path/to/my-cert.key", "passphrase")
  config.handlers.etcd.ssl_verify_mode = OpenSSL::SSL::VERIFY_PEER

  config.handlers.etcd.timeout = 120
  config.handlers.etcd.allow_redirect = false
end
```

## Usage

**lita-etcd** aims to have a compatible syntax with [etcdctl](https://github.com/coreos/etcdctl) for the features it supports. All commands can be issued as "etcd" or "etcdctl". To use the commands, the user must be in the `:etcd_admins` authorization group.

### Setting

To set a key:

```
Lita: etcd set KEY VALUE
```

To set a key with an expiration in seconds:

```
Lita: etcd set KEY VALUE --ttl SECONDS
```

To set a key only if it has a specific current value:

```
Lita: etcd set KEY VALUE --swap-with-value CURRENT_VALUE
```

To set a key only if it has a specific current index:

```
Lita: etcd set KEY VALUE --swap-with-index CURRENT_INDEX
```

To set a key only if it doesn't already exist:

```
Lita: etcd mk KEY VALUE
```

To create a directory only if it doesn't already exist:

```
Lita: etcd mkdir DIR
```

To update a key that must currently exist:

```
Lita: etcd update KEY VALUE
```

To create a directory unconditionally:

```
Lita: etcd setDir DIR
```

### Getting

To get the value of a key:

```
Lita: etcd get KEY
```

To get the value of a key, ensuring the read is not stale:

```
Lita: etcd get KEY --consistent
```

### Listing

To list the keys available at a path (or the root path if no path is specified):

```
Lita: etcd ls [PATH]
```

To list the keys available at a path, recursing into directories:

```
Lita: etcd ls --recursive
```

To list the keys available at a path, with trailing slashes after directories:

```
Lita: etcd ls -p
```

### Deleting

To delete a key:

```
Lita: etcd rm KEY
```

To delete a key or empty directory, the following two commands are equivalent:

```
Lita: etcd rmdir DIR
Lita: etcd rm DIR --dir
```

To delete a directory recursively:

```
Lita: etcd rm DIR --recursive
```

To delete a key only if it has a specific current value:

```
Lita: etcd rm KEY --with-value CURRENT_VALUE
```

To delete a key only if it has a specific current index:

```
Lita: etcd rm KEY --with-index INDEX
```

### Watching

To watch a key and report the next change:

```
Lita: etcd watch KEY
```

To watch a directory and report the next change anywhere underneath it:

```
Lita: etcd watch DIR --recursive
```

To watch a key and report the next change, starting at a specific index:

```
Lita: etcd watch KEY --after-index INDEX
```

To watch a directory and report the next change anywhere underneath it, starting at a specific index:

```
Lita: etcd watch DIR --recursive --after-index INDEX
```

## License

[MIT](http://opensource.org/licenses/MIT)
