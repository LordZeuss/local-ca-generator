# local-ca-generator
Generate local CA certificates.

I personally use this to create a root CA so I can use the cert for mTLS using Caddy for my homelab.

I was using mkcert (which is great) but I wanted the data in the cert to be custom, so I use openssl here. This script just is a time-saver for quick deployments, and allows you to generate a local CA in the current folder, which is great if you want multiple CAs.
