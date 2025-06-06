const express = require('express');
const net = require('net');

function checkPort(host, port) {
  return new Promise((resolve) => {
    const socket = new net.Socket();
    socket.setTimeout(2000);
    socket.on('connect', () => {
      socket.destroy();
      resolve(true);
    }).on('error', () => {
      resolve(false);
    }).on('timeout', () => {
      resolve(false);
    }).connect(port, host);
  });
}

async function checkHttp(url) {
  try {
    const res = await fetch(url);
    return res.ok;
  } catch {
    return false;
  }
}

const checks = [
  {
    name: 'PostgreSQL',
    type: 'tcp',
    host: 'postgres',
    port: 5432,
    ui: null,
  },
  {
    name: 'Keycloak',
    type: 'http',
    url: 'http://keycloak:8080',
    ui: '/keycloak/',
  },
  {
    name: 'Elasticsearch',
    type: 'http',
    url: 'http://elasticsearch:9200',
    ui: '/elasticsearch/',
  },
  {
    name: 'Kibana',
    type: 'http',
    url: 'http://kibana:5601',
    ui: '/kibana/',
  },
  {
    name: 'Prometheus',
    type: 'http',
    url: 'http://prometheus:9090/-/ready',
    ui: '/prometheus/',
  },
  {
    name: 'Grafana',
    type: 'http',
    url: 'http://grafana:3000',
    ui: '/grafana/',
  },
  {
    name: 'NGINX',
    type: 'http',
    url: 'http://nginx',
    ui: '/',
  },
];

async function getStatuses() {
  return Promise.all(
    checks.map(async (c) => {
      let online = false;
      if (c.type === 'tcp') {
        online = await checkPort(c.host, c.port);
      } else {
        online = await checkHttp(c.url);
      }
      return { name: c.name, online, ui: c.ui };
    })
  );
}

const app = express();
app.get('/', async (_req, res) => {
  const statuses = await getStatuses();
  res.send(`<!doctype html>
<html>
<head><title>Service Status</title></head>
<body>
<h1>Service Status</h1>
<table border="1" cellspacing="0" cellpadding="4">
<tr><th>Service</th><th>Status</th><th>URL</th></tr>
${statuses
  .map((s) => `<tr><td>${s.name}</td><td>${s.online ? 'online' : 'offline'}</td><td>${s.ui ? `<a href="${s.ui}">${s.ui}</a>` : ''}</td></tr>`)
  .join('\n')}
</table>
</body>
</html>`);
});

app.get('/online', (_req, res) => {
  res.send('<h1>TU ES ONLINE</h1>');
});

const port = 3001;
app.listen(port, () => {
  console.log('Status page listening on port', port);
});
