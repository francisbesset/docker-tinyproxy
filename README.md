# Tinyproxy as Docker container

## How to use

Starting a tinyproxy instance is simple:

```bash
$ docker run -d --name="tinyproxy" [-e "LOG_LEVEL=<LogLevel>"] [-e "CONNECT_PORT=all"] -p <HostPort>:8888 francisbesset/tinyproxy <ACL>
```

* Set <LogLevel>. Can be set with "Info" (default value), "Connect", "Notice", "Warning", "Error" or "Critical".
* Set <HostPort> to the port you wish the proxy to be accessible from.
* Set <ACL> to "ANY" to allow unrestricted proxy access, or one or more space seperated IP/CIDR addresses for tighter security.

## Examples

```bash
$ docker run -d --name="tinyproxy" -p 1111:8888 francisbesset/tinyproxy ANY
$ docker run -d --name="tinyproxy" -p 2222:8888 francisbesset/tinyproxy 123.45.67.89
$ docker run -d --name="tinyproxy" -p 3333:8888 francisbesset/tinyproxy 123.45.67.89 192.168.0.0/16
$ docker run -d --name="tinyproxy" -p 4444:8888 -e "LOG_LEVEL=Notice" francisbesset/tinyproxy 123.45.67.89
$ docker run -d --name="tinyproxy" -p 5555:8888 -e "LOG_LEVEL=Warning" francisbesset/tinyproxy 123.45.67.89 192.168.0.0/16
$ docker run -d --name="tinyproxy" -p 6666:8888 -e "CONNECT_PORT=all" francisbesset/tinyproxy 123.45.67.89 192.168.0.0/16
```
