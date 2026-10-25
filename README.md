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

## What it is

[cAdvisor](https://github.com/google/cadvisor) collects and exposes resource usage and performance data for running containers. See the upstream [README](https://github.com/google/cadvisor/blob/master/README.md) and [running docs](https://github.com/google/cadvisor/blob/master/docs/running.md) for full detail.

## Usage

Typical **Docker on Linux** host monitoring (aligned with the [upstream quick start](https://github.com/google/cadvisor/blob/master/README.md)); the UI and API listen on port **8080** inside the container:

```sh
docker run -d --name cadvisor --privileged --device=/dev/kmsg \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  dockette/cadvisor:0.60.6
```

Then open `http://localhost:8080`. On rootless Docker, Podman, or non-default graph roots, the path to the container runtime state may differ from `/var/lib/docker`; adjust the bind mount to match your setup.

`--privileged` and `--device=/dev/kmsg` match the common upstream example for broad compatibility; you may be able to reduce privileges for your environment—see upstream [runtime options](https://github.com/google/cadvisor/blob/master/docs/runtime_options.md).

Use `make run` to start the same local cAdvisor container with the documented host mounts, `--privileged`, and `/dev/kmsg` device access.

## Versions

Docker image tags use the **numeric** form (e.g. `0.60.6`), matching `ghcr.io/google/cadvisor`. GitHub [releases](https://github.com/google/cadvisor/releases) use a `v` prefix (e.g. v0.60.6) for the same version.

`ghcr.io/google/cadvisor:0.60.6` is the upstream image. Tags on [Docker Hub](https://hub.docker.com/r/dockette/cadvisor/tags/):

| Tag | What it is |
|-----|------------|
| `dockette/cadvisor:latest` | latest build of `master` |
| `dockette/cadvisor:2026.10.23` | release `2026.10.23` |
| `dockette/cadvisor:0.60.6` | latest build with cAdvisor `0.60.6` |
| `dockette/cadvisor:0.60.6-2026.10.23` | cAdvisor `0.60.6` in release `2026.10.23`; pin this one |

This image is a **thin republish**: the Dockerfile uses `FROM ghcr.io/google/cadvisor:${CADVISOR_VERSION}` so runtime behavior matches that upstream tag.

For **cAdvisor versions before v0.53.0**, the historical registry was `gcr.io/cadvisor/cadvisor` instead of GHCR; this repo only republishes the modern GHCR tags.

## Release version

The release version is the date in [`VERSION`](VERSION). The cAdvisor version is pinned in the workflow (`CADVISOR_VERSION`). On `master`, CI pushes the `latest` image under the four tags above.
To release, run `make release`, commit and push to `master`. A cAdvisor upgrade is a release too.

-----

## Maintenance

See [how to contribute](https://github.com/dockette/.github/blob/master/CONTRIBUTING.md) to this package. Consider to [support](https://github.com/sponsors/f3l1x) **f3l1x**. Thank you for using this package.
