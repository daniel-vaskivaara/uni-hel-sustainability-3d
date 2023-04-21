## build & run
```
  from project root:
    matchmaker/build.sh
    matchmaker/run.sh
```

## push to ECR
```
  aws ecr get-login-password --region eu-north-1 | docker login --username AWS --password-stdin 698794391023.dkr.ecr.eu-north-1.amazonaws.com
  docker push 698794391023.dkr.ecr.eu-north-1.amazonaws.com/pixel_stream:matchmaker-[version]
```

## description of main server
  - port defaults: 80, 9999
  - maintains a list of all connected Cirrus servers (variable name: cirrusServers)
  - supports only sending players to empty servers
  - if no servers are available, send some simple JavaScript to the client to make it retry after a short period of time
  - maintains a log at ./logs
  - user has 10 seconds to click play in order to 'claim' the server
  - RESTful API (on by default) used by the signalling server (part of Cirrus)
    - /signallingserver (gets list of available servers)
-redirectionLinks option (on by default) will redirect incoming requests to the Cirrus server
  -redirect supported paths: '/', 'custom_html/<fileName>'
-makes a check in case a reconnect is happening between the client and Cirrus (to not assign them to a new server)

message json schema:
```
{   
  playerConnected: boolean,
  type: [connect,
    clientConnected,
    clientDisonnected,
    ping,
    streamerConnected,
    streamerDisconnected],
  ready: boolean
}
```

note: the connect type refers to a Cirrus server connecting