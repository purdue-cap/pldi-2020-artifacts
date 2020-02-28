#!/usr/bin/env python3

import os, sys, signal
import json
import subprocess
from optparse import OptionParser
from functools import partial
from multiprocessing.dummy import Pool
from time import time

parser = OptionParser()
parser.add_option("-s", "--solver", dest="solvers", action="append", choices=["dryadsynth", "loopinvgen", "cvc4", "eusolver"],
                help="Solver to run, could be repeated to specify multiple, if omitted, all would be run",
                default=[])
parser.add_option("-t", "--track", dest="tracks", action="append", choices=["CLIA", "INV", "General"],
                help="Track of benchmark to be run, could be repeated to specify multiple, if omitted, all would be run",
                default=[])
parser.add_option("-B", "--benchmark_base", dest="benchmark_base",
                help="Benchmark base directory path, default: %default",
                default="/home/user/benchmarks")
parser.add_option("-b", "--list_benchmarks", dest="list_benchmarks", action="store_true",
                help="List benchmark files to run specifically, if enabled, would read arguments as list of benchmark files to run, default: %default",
                default=False)
parser.add_option("-T", "--timeout", dest="timeout", type="int",
                help="Timeout for running solvers, in seconds, default: %default",
                default=1800)
parser.add_option("-j", "--jobs", dest="jobs", type="int",
                help="Number of jobs to be run in parallel. "
                "NOTE: If you want to use this, you need to configure "
                "enclosing container to provide sufficient CPU cores "
                "or it won't improve any performance, default: %default",
                default=1)
parser.add_option("-d", "--database", dest="database",
                help="Database JSON file to read from / write to, default: %default",
                default="/home/user/result.json")
parser.add_option("-S", "--stats_only", dest="stats_only", action="store_true",
                help="Only print stats accumulated in database, does not run anything, default: %default",
                default=False)
parser.add_option("-f", "--force", dest="force", action="store_true",
                help="Force rerun of benchmark, even it's already in database, default: %default",
                default=False)
parser.add_option("-v", "--verbose", dest="verbose", action="store_true",
                help="Show verbose running logs, default: %default",
                default=False)
parser.add_option("--cvc4_CLIA_entrypoint", dest="cvc4_CLIA",
                help="Entrypoint to CVC4 CLIA track run script, default: %default",
                default="/home/user/CVC4/cvc4_CLIA")
parser.add_option("--cvc4_GENERAL_entrypoint", dest="cvc4_GENERAL",
                help="Entrypoint to CVC4 GENERAL track run script, default: %default",
                default="/home/user/CVC4/cvc4_GENERAL")
parser.add_option("--cvc4_INV_entrypoint", dest="cvc4_INV",
                help="Entrypoint to CVC4 INV track run script, default: %default",
                default="/home/user/CVC4/cvc4_INV")
parser.add_option("--dryadsynth_entrypoint", dest="dryadsynth",
                help="Entrypoint to DryadSynth run script, default: %default",
                default="/home/user/DryadSynth/exec.sh")
parser.add_option("--loopinvgen_entrypoint", dest="loopinvgen",
                help="Entrypoint to LoopInvGen run script, default: %default",
                default="/home/user/LoopInvGen/bin/loopinvgen.sh")
parser.add_option("--eusolver_entrypoint", dest="eusolver",
                help="Entrypoint to EUSolver run script, default: %default",
                default="/home/user/EUSolver/bin/eusolver.sh")

(options, args) = parser.parse_args()
if options.solvers == []:
    options.solvers = ["dryadsynth", "cvc4", "eusolver", "loopinvgen"]
if options.tracks == []:
    options.tracks = ["CLIA", "INV", "General"]

# Returns [(benchmark_path, benchmark_track)]
def get_benchmarks():
    if options.list_benchmarks:
        paths = list(map(os.path.abspath, args))
        if not all(s.startswith(options.benchmark_base) for s in paths):
            print("Supplied benchmark file must be in base directory")
            sys.exit(1)
        track = [os.path.relpath(s, options.benchmark_base) for s in paths]
        track = [s.split("/")[0] for s in track]
        return list(zip(paths, track))
    benchmarks = []
    for t in options.tracks:
            base = os.path.join(options.benchmark_base, t)
            paths = [s for s in os.listdir(base) if s.endswith(".sl")]
            paths = [os.path.join(base, s) for s in paths]
            benchmarks.extend((s, t) for s in paths)
    return benchmarks

# returns result = (one_of("DONE", "NONZERO", "NO_OUTPUT", "TIMEOUT"), running_time)
def run_subprocess(args, solver_to_report, path_to_report):
    start_time = time()
    try:
        result = subprocess.Popen(args, start_new_session=True,
                                  stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        try:
            pgid = os.getpgid(result.pid)
        except ProcessLookupError:
            pgid = None
        (stdout, _) = result.communicate(timeout=options.timeout)
    except subprocess.TimeoutExpired:
        os.killpg(pgid, signal.SIGTERM)
        try:
            result.communicate(timeout=5)
        except subprocess.TimeoutExpired:
            pass
        # At his point it needs to be cleaned up anyway
        try:
            os.killpg(pgid, signal.SIGTERM)
        except ProcessLookupError:
            pass
        if options.verbose:
            print(f"TIMEOUT: {solver_to_report} on {path_to_report}")
        return ("TIMEOUT", time() - start_time)
    # Cleanup any children at this point
    if pgid != None:
        try:
            os.killpg(pgid, signal.SIGTERM)
        except ProcessLookupError:
            pass
    if result.returncode != 0:
        if options.verbose:
            print(f"NONZERO: {solver_to_report} on {path_to_report}")
        return ("NONZERO", time() - start_time)
    if not stdout.strip():
        if options.verbose:
            print(f"NO_OUTPUT: {solver_to_report} on {path_to_report}")
        return ("NO_OUTPUT", time() - start_time)

    if options.verbose:
        print(f"DONE: {solver_to_report} on {path_to_report}")
    return ("DONE", time() - start_time)

# returns result = (one_of("DONE", "NONZERO", "NO_OUTPUT", "TIMEOUT"), running_time)
def run_dryadsynth(benchmark):
    (path, track) = benchmark
    if options.verbose:
        print(f"Running dryadsynth on {path}")
    if track == "CLIA":
        flags = ["-t", "4", "-f", "20", "-i", "30", "-eq", "2"]
    elif track == "INV":
        flags = ["-t", "4", "-l", "8", "-f", "20", "-i", "30", "-F"]
    else:
        flags = ["-t", "4", "-f", "20", "-i", "30"]

    return run_subprocess([options.dryadsynth] + flags + [path], "dryadsynth", path)


# returns result = (one_of("DONE", "NONZERO", "NO_OUTPUT", "TIMEOUT"), running_time)
def run_cvc4(benchmark):
    (path, track) = benchmark
    if options.verbose:
        print(f"Running cvc4 on {path}")
    if track == "CLIA":
        cmd = options.cvc4_CLIA
    elif track == "INV":
        cmd = options.cvc4_INV
    else:
        cmd = options.cvc4_GENERAL

    return run_subprocess([cmd, path], "cvc4", path)

# returns result = (one_of("DONE", "NONZERO", "NO_OUTPUT", "TIMEOUT"), running_time)
def run_others(solver, benchmark):
    (path, _) = benchmark
    if options.verbose:
        print(f"Running {solver} on {path}")
    cmd = getattr(options, solver)

    return run_subprocess([cmd, path], solver, path)

db = {}
def has_it_in_db(solver, benchmark):
    if solver in db:
        return benchmark in db[solver]
    return False

# Result is saved into db
def run_batch(solvers, benchmarks):
    pool = Pool(options.jobs)
    result_pool = []
    for s in solvers:
        for b in benchmarks:
            if options.force or not has_it_in_db(s, b[0]):
                if s == "dryadsynth":
                    result = pool.apply_async(run_dryadsynth, [b])
                elif s == "cvc4":
                    result = pool.apply_async(run_cvc4, [b])
                else:
                    result = pool.apply_async(run_others, [s, b])
                result_pool.append((s, b, result))
            elif options.verbose:
                print(f"Skipping {s} on {b[0]}")
    pool.close()
    try:
        pool.join()
    except KeyboardInterrupt:
        print("Exiting prematurely, saving all current results...")
    for result_pair in result_pool:
        (s, b, result) = result_pair
        if not s in db:
            db[s] = {}
        db[s][b[0]] = result.get()

def print_stats(solvers=None, benchmarks=None):
    for s in db:
        if not solvers is None and not s in solvers:
            continue
        done = 0
        timeout = 0
        nonzero = 0
        no_output = 0
        total = 0
        total_time = 0.0
        done_time = 0.0
        for b in db[s]:
            if not benchmarks is None and not b in benchmarks:
                continue
            if db[s][b][0] == "DONE":
                done += 1
                done_time += db[s][b][1]
            elif db[s][b][0] == "TIMEOUT":
                timeout += 1
            elif db[s][b][0] == "NONZERO":
                nonzero += 1
            elif db[s][b][0] == "NO_OUTPUT":
                no_output += 1
            total += 1
            total_time += db[s][b][1]
        print(f"Solver {s:10} TOTAL {total:>3}:DONE {done:>3},"
              f" TIMEOUT {timeout:>3}, NONZERO {nonzero:>3},"
              f" NO_OUTPUT {no_output:>3}, TOTAL_TIME {total_time:>10.1f},"
              f" DONE_TIME {done_time:>10.1f}")


def main():
    global db
    if os.path.exists(options.database):
        with open(options.database) as f:
            print(f"Loading from {options.database}")
            db = json.load(f)
    if not options.stats_only:
        benchmarks = get_benchmarks()
        print(f"Running solvers: {options.solvers} on {len(benchmarks)} benchmark(s)")
        run_batch(options.solvers, benchmarks)
        with open(options.database, "w") as f:
            print(f"Writing to {options.database}")
            json.dump(db, f, indent=2)
        print_stats(set(options.solvers), set(b[0] for b in benchmarks))
    else:
        print_stats()

if __name__ == "__main__":
    main()
