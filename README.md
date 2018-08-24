# Banzai

Everything goes better when a project has a code name.

## Collector for AWS Config

### Build a Release

From the root of the project:

```docker build --tag=banzai-build --file docker/Dockerfile.centos7.build .```

The release is built but we need to have the instance running, so:

```docker run -it banzai-build /bin/bash```

Get the ID of the image:

```docker ps --last 1 --quiet```

Copy the release tarball out:
```docker cp <imageid_from_above>:/app/_build/prod/rel/banzai/releases/0.0.1/banzai.tar.gz /tmp```

### Deploy

Copy the tarball to the remote server:

```scp -i creds.pem /tmp/banzai.tar.gz centos@some-long-identifier.amazonaws.com:/tmp```
