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

### Getting

### Listing

### Deleting

### Watching

## License

[MIT](http://opensource.org/licenses/MIT)
