# docker-xmrig-amd

Quick and dirty docker container for [xmrig-amd](https://github.com/xmrig/xmrig-amd) including [ROCm](https://github.com/RadeonOpenCompute/ROCm) drivers, and donate level patch.

## Requirements

 * [docker](https://docs.docker.com/install/)
 * ROCm drivers on the host

## Usage

### Building

```
docker build . --tag bananajamma/xmrig-amd
```

### Running

```
docker run --device /dev/dri --device /dev/dri --group-add=video -it --rm --name xmrig-amd bananajamma/xmrig-amd --donate-level 0 -o gulf.moneroocean.stream:10032 -u 4JLN35ooAiU15BX6Rzi6DTWUKsdLALvf6Stx1uLLrYP28scYTAtyjhM3ULkrpCQMQ1BGvn2hSaYGtSzwtPcZhFSwdoFypnBsb6wKfhTGix -p x -k
```

## License

MIT
