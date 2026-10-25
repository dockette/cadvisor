<h1 align=center>Dockette / cAdvisor</h1>

<p align=center>
   Minimal Docker image for <a href="https://github.com/google/cadvisor">cAdvisor</a> (Container Advisor), mirroring <code>ghcr.io/google/cadvisor</code> under the <code>dockette/cadvisor</code> name on Docker Hub.
</p>

<p align=center>
🕹 <a href="https://f3l1x.io">f3l1x.io</a> | 💻 <a href="https://github.com/f3l1x">f3l1x</a> | 🐦 <a href="https://twitter.com/xf3l1x">@xf3l1x</a>
</p>

<p align=center>
   <a href="https://github.com/dockette/cadvisor/actions"><img src="https://github.com/dockette/cadvisor/actions/workflows/docker.yml/badge.svg" alt="GitHub Actions"></a>
   <a href="https://hub.docker.com/r/dockette/cadvisor"><img src="https://img.shields.io/docker/pulls/dockette/cadvisor.svg" alt="Docker Hub pulls"></a>
   <a href="https://github.com/sponsors/f3l1x"><img src="https://img.shields.io/badge/sponsor-GitHub%20Sponsors-ea4aaa" alt="GitHub Sponsors"></a>
   <a href="https://github.com/orgs/dockette/discussions"><img src="https://img.shields.io/badge/support-discussions-6f42c1" alt="Support/Discussions"></a>
</p>

-----

[cAdvisor](https://github.com/google/cadvisor) (Container Advisor) collects and exposes resource usage and performance
data for running containers. This image is a thin republish of `ghcr.io/google/cadvisor` as `dockette/cadvisor` on
Docker Hub. See the upstream [README](https://github.com/google/cadvisor/blob/master/README.md) and
[running docs](https://github.com/google/cadvisor/blob/master/docs/running.md) for details.

## Features

- cAdvisor `0.60.6`, `FROM ghcr.io/google/cadvisor:${CADVISOR_VERSION}`, so runtime behavior matches that upstream tag
- UI and API listen on port `8080` inside the container
- Only the modern GHCR tags are republished. Before cAdvisor `v0.53.0` the registry was `gcr.io/cadvisor/cadvisor`

## Usage

```sh
# Docker on Linux host monitoring, as in the upstream quick start
docker run -d --name cadvisor --privileged --device=/dev/kmsg \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  dockette/cadvisor:0.60.6

# Open the UI
open http://localhost:8080
```

## Configuration

On rootless Docker, Podman or a non-default graph root, the path to the container runtime state may differ from
`/var/lib/docker`. Change the bind mount to match your setup.

`--privileged` and `--device=/dev/kmsg` match the common upstream example for broad compatibility. You may be able to
reduce privileges for your environment, see the upstream
[runtime options](https://github.com/google/cadvisor/blob/master/docs/runtime_options.md).

## Versions

| Version | Release |
|---------|---------|
| `dockette/cadvisor:0.60.6-YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/cadvisor:0.60.6` | latest release |
| `dockette/cadvisor:YYYY.MM.DD` | release `YYYY.MM.DD` |
| `dockette/cadvisor:latest` | latest build of `master` |

Image tags use the numeric form of the upstream version (`0.60.6`). Upstream GitHub
[releases](https://github.com/google/cadvisor/releases) use a `v` prefix (`v0.60.6`). All versions build on
`ghcr.io/google/cadvisor:0.60.6`, pinned in `VERSION` and in the `Dockerfile`. Releases are listed on
[GitHub](https://github.com/dockette/cadvisor/releases) and tags on
[Docker Hub](https://hub.docker.com/r/dockette/cadvisor/tags/).

## Development

```sh
make build     # build the image
make run       # run cAdvisor with the host mounts, --privileged and /dev/kmsg
make test      # start the image and check /healthz
make version   # print VERSION
make release   # set today's date in VERSION
```

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to
[support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
