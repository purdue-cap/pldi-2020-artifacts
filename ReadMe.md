# Artifacts for _Reconciling Enumerative and Deductive Program Synthesis_

__NOTE__: Our solver is called **Grass** in the submission version of paper to stay anonymized. In this artifact, we will use the original name **DryadSynth** instead.

## Getting Started

1. To get started, you will need to install [docker](https://github.com/docker/docker-ce) on your system, and have [xz](https://tukaani.org/xz/) ready for decompressing the image file. Also you will need to have the artifact image file `dryadsynth.tar.xz`
2. Before setting up the image, be sure to check its md5sum in case of any possible file corruption:

    ```bash
    md5sum dryadsynth.tar.xz
    ```

    - MD5: `a950a41f63683437c1259a5422436624`
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

## File structure in artifact image

Under `$HOME/`:

- `CVC4/` scripts for running CVC4 in SyGuS mode
- `DryadSynth/` source repository for `DryadSynth`
- `EUSolver/` solver binary of `EUSolver` extracted from StarExec
- `LoopInvGen/` solver binary of `LoopInvGen` extracted from StarExec
- `benchmarks/` directory of all benchmarks as mentioned in paper
- `run_benchmarks.py` test script

`cvc4` executable is in `/usr/local/bin`

`z3` executable (For `DryadSynth` constraint solving) is in `/usr/local/bin`

If you wish to run any solver manually, here are a list of entry points:

- `DryadSynth`
    - `$HOME/DryadSynth/exec.sh [OPTIONS] <BENCHMARK>`
- `CVC4`
    - `$HOME/CVC4/cvc4_CLIA [OPTIONS] <BENCHMARK>` for `CLIA` track
    - `$HOME/CVC4/cvc4_INV [OPTIONS] <BENCHMARK>` for `INV` track
    - `$HOME/CVC4/cvc4_GENERAL [OPTIONS] <BENCHMARK>` for `General` track
- `EUSolver`
    - `$HOME/EUSolver/bin/eusolver.sh [OPTIONS] <BENCHMARK>`
- `LoopInvGen`
    - `$HOME/LoopInvGen/bin/loopinvgen.sh [OPTIONS] <BENCHMARK>`

## Evaluations

### Test script

The main test facility would be the test script at `$HOME/run_benchmarks.py`, you could see its full help documentation by running `$HOME/run_benchmarks.py --help`:

```plaintext
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

Or you could use `-b` or `--list_benchmarks` to specify benchmark files to run in the script arguments, like this:

```bash
$HOME/run_benchmarks.py -s dryadsynth -s cvc4 -b -j 4 \
    $HOME/benchmarks/CLIA/<CLIA benchmark1>.sl \
    $HOME/benchmarks/CLIA/<CLIA benchmark2>.sl \
    $HOME/benchmarks/General/<General benchmark>.sl \
    $HOME/benchmarks/INV/From 2018/<INV benchmark>.sl
```

__NOTE__:

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

    - Use a proper `n` according to your system performance, usually something between `2` and `6` is preferred, or use the number of CPU cores on your system
3. Run `INV` track on `DryadSynth`, `CVC4` and `LoopInvGen`

    ```bash
    $HOME/run_benchmarks.py -s dryadsynth -s cvc4 -s loopinvgen -t INV -j <n>
    ```

    - Step 2 and Step 3 may take long time (several hours) to finish, and you may:
        - Use `-v` or `--verbose` flag to monitor the progress
        - Split the steps into smaller fragments as demonstrated in the previous section
        - Use `-T` or `--timeout` to specify a shorter timeout. __Note that this may impact the performance stats greatly, but may still flag significant performance differences__

4. Inspect accumulated stats

    ```bash
    $HOME/run_benchmarks.py -S
    ```

    - Stats would be printed after each run as well
    - Stats fields
        - `TOTAL`: total number of benchmarks run
        - `DONE`: solved benchmarks
        - `NONZERO`: benchmarks that the solver returned a non-zero return code, indicating a solver failure
        - `NO_OUTPUT`: benchmarks that the solver produced no output, indicating a solver failure
        - `TIMEOUT`: benchmarks that the solver has timed out
        - `TOTAL_TIME`: total per-job time used, in seconds
        - `DONE_TIME`: total per-job time used on solved benchmarks, in seconds

__NOTE__:

- Since the data in the paper is from StarExec, which have far more computing resources then most artifact evaluation environments, the absolute performance numbers may be very different
- However, we expect relative performance relationships to remain the similar.
- Depending on the performance of the evaluation environment, some benchmarks may not have enough time to finish within the default timeout, resulting in different performance numbers, this could be resolved by tuning `-T`/`--timeout` flag

## Supported Claims

__NOTE__:

- Since experiments reported in the paper were originally conducted on the StarExec platform, which have far more computing resources then most artifact evaluation environments, the absolute performance numbers may be very different. (Details can be found in Unsupported Claims.) However, we expect relative performance relationships to remain the similar.
- It may take hours (potentially 30+) to finish running the experiments. Using `-T`/`--timeout` to specify a shorter timeout may help, however, ***this may impact the performance stats greatly***.

To reproduce results that support the following claims, fisrt run every solver (DryadSynth, CVC4, EUSolver, LoopInvGen) on benchmarks in all the tracks (CLIA, INV, General)

```bash
$HOME/run_benchmarks.py -runAll
```

1. DryadSynth solved more benchmarks than all other solvers in all tracks.

    - Inspect the stats by track

    ```bash
    $HOME/get_solved.py -track=CLIA
    ```

    - `-track` can be `CLIA`/`INV`/`GENERAL`
    - Stats for corresponding track would be printed
    - Stats fields
        - `Track`: track that the benchmarks are in
        - `DryadSynth`: total number of benchmarks solved by DryadSynth
        - `CVC4`: total number of benchmarks solved by CVC4
        - `EUSolver`: total number of benchmarks solved by EUSolver
        - `LoopInvGen`: total number of benchmarks solved by LoopInvGen, would only appear if inspecting stats of INV track

2. DryadSynth *fastest* solved more benchmarks than all other solvers in all tracks.

    - Inspect the stats by track

    ```bash
    $HOME/get_fastest.py -track=CLIA
    ```

    - `-track` can be `CLIA`/`INV`/`GENERAL`
    - Stats for corresponding track would be printed
    - Stats fields
        - `Track`: track that the benchmarks are in
        - `DryadSynth`: total number of benchmarks *fastest* solved by DryadSynth
        - `CVC4`: total number of benchmarks *fastest* solved by CVC4
        - `EUSolver`: total number of benchmarks *fastest* solved by EUSolver
        - `LoopInvGen`: total number of benchmarks *fastest* solved by LoopInvGen, would only appear if inspecting stats of INV track

    __NOTE__: Following the criterion of SyGuS competition, the time amounts are classified into buckets of pseudo-logarithmic scales: [0, 1), [1, 3), [3, 10), . . . , [1000, 1800). We identify a solver to fastest solve a benchmark if solving time of the solver falls into the smallest bucket among all other solvers. Hence, the number of solver that fastest solve a benchmark can be more than one. For example, if solver A solves a benchmark in 1.5 seconds and another solver B solve the benchmark in 2.5 seconds, we consider both A and B fastest solve the benchmark.

3. DryadSynth solved more CLIA and General track benchmarks than all other solvers, with less time spent.

    - Inspect the stats by track

    ```bash
    $HOME/get_total.py -track=CLIA
    ```

    - `-track` can be `CLIA`/`INV`/`GENERAL`
    - Stats for corresponding track would be printed
    - Stats fields
        - `Track`: track that the benchmarks are in
        - `DryadSynth_Solved`: total number of benchmarks solved by DryadSynth
        - `DryadSynth_Total`: total solving time used by DryadSynth
        - `CVC4_Solved`: total number of benchmarks solved by CVC4
        - `CVC4_Total`: total solving time used by CVC4
        - `EUSolver_Solved`: total number of benchmarks solved by EUSolver
        - `EUSolver_Total`: total solving time used by EUSolver
        - `LoopInvGen_Solved`: total number of benchmarks solved by LoopInvGen, would only appear if inspecting stats of INV track
        - `LoopInvGen_Total`: total solving time used by LoopInvGen, would only appear if inspecting stats of INV tract

4. DryadSynth had a constant overhead on easier-to-solve problems (benchmarks that takes less time to solve), the solving time increases more mildly toward more challenging benchmarks (benchmarks that takes less time to solve) than other solvers. In other words, DryadSynth solved more benchmarks as the solving time increasing.

    - Inspect the stats by track

    ```bash
    $HOME/get_solved_under_threshold.py -track=CLIA -threshold=THRESHOLD
    ```

    - `-track` can be `CLIA`/`INV`/`GENERAL`
    - `-threshold` should be a timing threshold in seconds
    - Stats for corresponding track and threshold would be printed
    - Stats fields
        - `Track`: track that the benchmarks are in
        - `DryadSynth`: total number of benchmarks solved by DryadSynth under the timing threshold
        - `CVC4`: total number of benchmarks solved by CVC4 under the timing threshold
        - `EUSolver`: total number of benchmarks solved by EUSolver under the timing threshold
        - `LoopInvGen`: total number of benchmarks solved by LoopInvGen under the timing threshold, would only appear if inspecting stats of INV track

5. DryadSynth solved several benchmarks *uniquely*.

    - Inspect the stats

    ```bash
    $HOME/get_unique.py
    ```

    - Stats would be printed
    - Stats fields
        - `DryadSynth_Uniquely_Solved`: total number of benchmarks *uniquely* solved by DryadSynth

## Unsupported Claims

- The experiments reported in the paper were originally conducted on the [StarExec](https://www.starexec.org/starexec/secure/index.jsp) platform, on which solver is executed on a 4-core, 2.4GHz CPU and 128GB memory node. The StarExec platform may have far more computing resources then most artifact evaluation environments, the absolute performance numbers may be very different from the data provided in the paper.
- Depending on the performance of the evaluation environment, some benchmarks may not have enough time to finish within the default timeout, resulting in different performance numbers, this could be resolved by tuning `-T`/`--timeout` flag
