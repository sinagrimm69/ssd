{
  "log": {
    "level": "warn",
    "output": "box.log",
    "timestamp": true
  },
  "dns": {
    "servers": [
      {
        "tag": "dns-remote",
        "address": "udp://1.1.1.1",
        "address_resolver": "dns-direct"
      },
      {
        "tag": "dns-trick-direct",
        "address": "https://sky.rethinkdns.com/",
        "detour": "direct-fragment"
      },
      {
        "tag": "dns-direct",
        "address": "1.1.1.1",
        "address_resolver": "dns-local",
        "detour": "direct"
      },
      {
        "tag": "dns-local",
        "address": "local",
        "detour": "direct"
      },
      {
        "tag": "dns-block",
        "address": "rcode://success"
      }
    ],
    "rules": [
      {
        "domain_suffix": ".ir",
        "geosite": "ir",
        "server": "dns-direct"
      },
      {
        "domain": "cp.cloudflare.com",
        "server": "dns-remote",
        "rewrite_ttl": 3000
      }
    ],
    "final": "dns-remote",
    "static_ips": {
      "sky.rethinkdns.com": [
        "188.114.97.6",
        "188.114.96.6",
        "104.18.203.232",
        "104.18.202.232",
        "188.114.97.3",
        "188.114.96.3"
      ]
    },
    "independent_cache": true
  },
  "inbounds": [
    {
      "type": "mixed",
      "tag": "mixed-in",
      "listen": "127.0.0.1",
      "listen_port": 2334,
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "ipv4_only",
      "set_system_proxy": true
    },
    {
      "type": "direct",
      "tag": "dns-in",
      "listen": "127.0.0.1",
      "listen_port": 6450,
      "override_address": "1.1.1.1",
      "override_port": 53
    }
  ],
  "outbounds": [
    {
      "type": "selector",
      "tag": "select",
      "outbounds": [
        "auto",
        "IR1🇮🇷(SinaGrimm) § 0",
        "Main1🇩🇪(SinaGrimm) § 1",
        "IR2🇮🇷(SinaGrimm) § 2",
        "Main2🇩🇪(SinaGrimm) § 3"
      ],
      "default": "auto"
    },
    {
      "type": "urltest",
      "tag": "auto",
      "outbounds": [
        "IR1🇮🇷(SinaGrimm) § 0",
        "Main1🇩🇪(SinaGrimm) § 1",
        "IR2🇮🇷(SinaGrimm) § 2",
        "Main2🇩🇪(SinaGrimm) § 3"
      ],
      "url": "http://cp.cloudflare.com/",
      "interval": "10m0s"
    },
    {
      "type": "wireguard",
      "tag": "IR1🇮🇷(SinaGrimm) § 0",
      "local_address": [
        "172.16.0.2/24",
        "2606:4700:110:821e:670d:79ab:a384:899/128"
      ],
      "private_key": "mCePa5bh1sf/HqhdKcHa+r29jgpM5fTnJ2n9HEY7bFw=",
      "server": "162.159.195.93",
      "server_port": 2506,
      "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
      "reserved": "AAAA",
      "mtu": ,
      "fake_packets": "5-10",
      "fake_packets_size": "40-100",
      "fake_packets_delay": "20-250"
    },
    {
      "type": "wireguard",
      "tag": "Main1🇩🇪(SinaGrimm) § 1",
      "detour": "IR1🇮🇷(SinaGrimm) § 0",
      "local_address": [
        "172.16.0.2/24",
        "2606:4700:110:882e:a532:aaa9:f164:f4e6/128"
      ],
      "private_key": "eJu7ZfGCPU+vohXTIh+pJgE2h5aIE144pje993+6TVc=",
      "server": "162.159.195.93",
      "server_port": 2506,
      "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
      "reserved": "AAAA",
      "mtu": 
    },
    {
      "type": "wireguard",
      "tag": "IR2🇮🇷(SinaGrimm) § 2",
      "local_address": [
        "172.16.0.2/24",
        "2606:4700:110:80f6:731e:32d3:425d:3045/128"
      ],
      "private_key": "iHLYaAV/R+PhzWMhEqGAFqIBs5kZciBNBfGw3PU85Vo=",
      "server": "188.114.97.20",
      "server_port": 988,
      "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
      "reserved": "AAAA",
      "mtu": ,
      "fake_packets": "5-10",
      "fake_packets_size": "40-100",
      "fake_packets_delay": "20-250"
    },
    {
      "type": "wireguard",
      "tag": "Main2🇩🇪(SinaGrimm) § 3",
      "detour": "IR2🇮🇷(SinaGrimm) § 2",
      "local_address": [
        "172.16.0.2/24",
        "2606:4700:110:8f03:1b8e:7ed9:22cf:aa44/128"
      ],
      "private_key": "QOhrKCVCAV2di8vatEYR1NnYTa7NxfslgSWuaKvenWc=",
      "server": "188.114.97.20",
      "server_port": 988,
      "peer_public_key": "bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
      "reserved": "AAAA",
      "mtu": 
    },
    {
      "type": "dns",
      "tag": "dns-out"
    },
    {
      "type": "direct",
      "tag": "direct"
    },
    {
      "type": "direct",
      "tag": "direct-fragment",
      "tls_fragment": {
        "enabled": true,
        "size": "1-500",
        "sleep": "0-500"
      }
    },
    {
      "type": "direct",
      "tag": "bypass"
    },
    {
      "type": "block",
      "tag": "block"
    }
  ],
  "route": {
    "geoip": {
      "path": "geo-assets\\sagernet-sing-geoip-geoip.db"
    },
    "geosite": {
      "path": "geo-assets\\sagernet-sing-geosite-geosite.db"
    },
    "rules": [
      {
        "inbound": "dns-in",
        "outbound": "dns-out"
      },
      {
        "port": 53,
        "outbound": "dns-out"
      },
      {
        "clash_mode": "Direct",
        "outbound": "direct"
      },
      {
        "clash_mode": "Global",
        "outbound": "select"
      },
      {
        "domain_suffix": ".ir",
        "geosite": "ir",
        "geoip": "ir",
        "outbound": "bypass"
      }
    ],
    "final": "select",
    "auto_detect_interface": true,
    "override_android_vpn": true
  },
  "experimental": {
    "cache_file": {
      "enabled": true,
      "path": "clash.db"
    },
    "clash_api": {
      "external_controller": "127.0.0.1:6756"
    }
  }
}
