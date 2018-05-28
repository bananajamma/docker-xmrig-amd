# docker-xmrig-amd

Quick and dirty docker container for [xmrig-amd](https://github.com/xmrig/xmrig-amd) including [AMDGPU-Pro drivers](https://support.amd.com/en-us/kb-articles/Pages/AMD-Radeon-GPU-PRO-Linux-Beta-Driver%E2%80%93Release-Notes.aspx), and donate level patch.

## Requirements

 * [docker](https://docs.docker.com/install/)
 * [AMDGPU-Pro drivers](https://support.amd.com/en-us/kb-articles/Pages/AMD-Radeon-GPU-PRO-Linux-Beta-Driver%E2%80%93Release-Notes.aspx) on the host

## Usage

### First

Pull the latest build:

```
docker pull bananajamma/xmrig-amd
```

### Running

Example:

```
docker run --device /dev/dri --device /dev/kfd --group-add=video -it --rm --name xmrig-amd bananajamma/xmrig-amd --donate-level 0 -o gulf.moneroocean.stream:10032 -u 4JLN35ooAiU15BX6Rzi6DTWUKsdLALvf6Stx1uLLrYP28scYTAtyjhM3ULkrpCQMQ1BGvn2hSaYGtSzwtPcZhFSwdoFypnBsb6wKfhTGix -p x -k
```

### Building

If you've clone this repo and made changes:

```
docker build . --tag bananajamma/xmrig-amd
```

## FAQ

#### Does this support ROCm for Vega cards?

No, but [docker-xmrig-amd-vega](https://github.com/bananajamma/docker-xmrig-amd-vega) does.

## License

MIT
