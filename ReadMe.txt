# Artifacts for _Reconciling Enumerative and Deductive Program Synthesis_

## Getting Started

1. To get started, you will need to install [docker](https://github.com/docker/docker-ce) on your system, and have [xz](https://tukaani.org/xz/) ready for decompressing the image file. Also you will need to have the artifact image file `dryadsynth.tar.xz`
2. Before setting up the image, be sure to check its md5sum in case of any possible file corruption:

    ```bash
    md5sum dryadsynth.tar.xz
    ```

    - MD5: `` __TODO:MD5 here__
3. Then decompress and load the image into your local docker

    ```bash
    xz -d -c dryadsynth.tar.xz | docker load
    ```

    - If pipe `|` is not available on your system (i.e. `cmd` on Windows), do this separately:

        ```bash
        xz -d dryadsynth.tar.xz
        docker load -i dryadsynth.tar
        ```

    - __TODO:Manual build instructions__
4. The loaded image is named as `chaserhkj/dryadsynth`, run it as

    ```bash
    docker run -it --name evaluation chaserhkj/dryadsynth
    ```

    And then you are in the artifact image environment. Feel free to substitute `evaluation` with any other proper container name. You could peek around and do some evaluations, after you are done, just `exit` or `Ctrl-D` to quit. Next time when you want to start from where you left, just do

    ```bash
    docker start -ia evaluation
    ```

5. Once you are in, we could do some basic testings to ensure everything works. For example we could use our test script to run `DryadSynth` on all `CLIA` benchmarks

    ```bash
    $ $HOME/run_benchmarks.py -j 4 -t CLIA
    Running solvers: ['dryadsynth'] on 88 benchmark(s)
    Writing to /home/user/result.json
    Solver dryadsynth TOTAL  88:DONE  88, TIMEOUT   0, ...
    ```

    It should not take more than a few minutes to finish these. Once you see something like above, it's a good sign of image running well.

## Evaluations

### Test script

The main test facility would be the test script at `$HOME/run_benchmarks.py`, you could see its full help documentation by running `$HOME/run_benchmarks.py --help`:

```bash
$ $HOME/run_benchmarks.py --help
Usage: run_benchmarks.py [options]

Options:
  -h, --help            show this help message and exit
  -s SOLVERS, --solver=SOLVERS
                        Solver to run, could be repeated to specify multiple,
                        if omitted, would only run DryadSynth
  -t TRACKS, --track=TRACKS
                        Track of benchmark to be run, could be repeated to
                        specify multiple, if omitted, all would be run
  -B BENCHMARK_BASE, --benchmark_base=BENCHMARK_BASE
                        Benchmark base directory path, default:
                        /home/user/benchmarks
  -b, --list_benchmarks
                        List benchmark files to run specifically, if enabled,
                        would read arguments as list of benchmark files to
                        run, default: False
  -T TIMEOUT, --timeout=TIMEOUT
                        Timeout for running solvers, in seconds, default: 3600
  -j JOBS, --jobs=JOBS  Number of jobs to be run in parallel. NOTE: If you
                        want to use this, you need to configure enclosing
                        container to provide sufficient CPU cores or it won't
                        improve any performance, default: 1
  -d DATABASE, --database=DATABASE
                        Database JSON file to read from / write to, default:
                        /home/user/result.json
  -S, --stats_only      Only print stats accumulated in database, does not run
                        anything, default: False
  -f, --force           Force rerun of benchmark, even it's already in
                        database, default: False
  -v, --verbose         Show verbose running logs, default: False
  --cvc4_CLIA_entrypoint=CVC4_CLIA
                        Entrypoint to CVC4 CLIA track run script, default:
                        /home/user/CVC4/cvc4_CLIA
  --cvc4_GENERAL_entrypoint=CVC4_GENERAL
                        Entrypoint to CVC4 GENERAL track run script, default:
                        /home/user/CVC4/cvc4_GENERAL
  --cvc4_INV_entrypoint=CVC4_INV
                        Entrypoint to CVC4 INV track run script, default:
                        /home/user/CVC4/cvc4_INV
  --dryadsynth_entrypoint=DRYADSYNTH
                        Entrypoint to DryadSynth run script, default:
                        /home/user/DryadSynth/exec.sh
  --loopinvgen_entrypoint=LOOPINVGEN
                        Entrypoint to LoopInvGen run script, default:
                        /home/user/LoopInvGen/bin/loopinvgen.sh
  --eusolver_entrypoint=EUSOLVER
                        Entrypoint to EUSolver run script, default:
                        /home/user/EUSolver/bin/eusolver.sh

```

Available Solvers are `dryadsynth, cvc4, loopinvgen, eusolver`

Avaiable tracks are `CLIA, INV, General`

Most of the flags are more configurable behavior and you could just use the default version.

For example, if you want to run `CLIA` track benchmarks on `DryadSynth`, `CVC4` and `EUSolver`, with 4 jobs in parallel:

```bash
$HOME/run_benchmarks.py -s dryadsynth -s cvc4 -s eusolver -t CLIA -j 4
```

If you want to run `INV` track benchmarks on `DryadSynth`, `CVC4` and `LoopInvGen`, with 4 jobs in parallel:

```bash
$HOME/run_benchmarks.py -s dryadsynth -s cvc4 -s loopinvgen -t INV -j 4
```

If you want to run `CLIA` and `General` track benchmarks on `DryadSynth` and `CVC4`, with 4 jobs in parallel:

```bash
$HOME/run_benchmarks.py -s dryadsynth -s cvc4 -t CLIA -t General -j 4
```

__Note__:

- By default, the run result is saved to `$HOME/result.json` and once a result is present the script won't run again, add `-f` or `--force` to override existing results.
- If you wish to print stats of the accumulated results, you could use `-S` or `--stats_only` flag for that
- Effectiveness of `-j` or `--jobs` flag heavily depends on your system performance, raising it too high might actually impact the performance negatively, use with wise.

### Steps to reproduce results in paper

__TODO: Check against paper and make sure this part is correct__

1. Clean up any old run results

   ```bash
   rm -f $HOME/result.json
   ```

2. Run `CLIA` and `General` track on `DryadSynth`, `CVC4` and `EUSolver`

    ```bash
    $HOME/run_benchmarks.py -s dryadsynth -s cvc4 -s eusolver -t CLIA -t General -j <n>
    ```

    - Use a proper `n` according to your system performance, usually something between `2` and `6` is preferred
3. Run `INV` track on `DryadSynth`, `CVC4` and `LoopInvGen`

    ```bash
    $HOME/run_benchmarks.py -s dryadsynth -s cvc4 -s loopinvgen -t INV -j <n>
    ```

4. Inspect accumulated stats

    ```bash
    $HOME/run_benchmarks.py -S
    ```

### File structure in artifact image

Under `$HOME/`:

- `CVC4/` scripts for running CVC4 in SyGuS mode
- `DryadSynth/` source repository for `DryadSynth`
- `EUSolver/` solver binary of `EUSolver` extracted from StarExec
- `LoopInvGen/` solver binary of `LoopInvGen` extracted from StarExec
- `benchmarks/` directory of all benchmarks as mentioned in paper
- `run_benchmarks.py` test script

If you wish to run any solver manually, here are a list of entry points:

- `DryadSynth`: `$HOME/DryadSynth/exec.sh [OPTIONS] <BENCHMARK>`
- `CVC4`:
    - `$HOME/CVC4/cvc4_CLIA [OPTIONS] <BENCHMARK>` for `CLIA` track
    - `$HOME/CVC4/cvc4_INV [OPTIONS] <BENCHMARK>` for `INV` track
    - `$HOME/CVC4/cvc4_GENERAL [OPTIONS] <BENCHMARK>` for `General` track
- `EUSolver`: `$HOME/EUSolver/bin/eusolver.sh [OPTIONS] <BENCHMARK>`
- `LoopInvGen`: `$HOME/LoopInvGen/bin/loopinvgen.sh [OPTIONS] <BENCHMARK>` 

## Supported Claims

__TODO__

## Unsupported Claims

__TODO__