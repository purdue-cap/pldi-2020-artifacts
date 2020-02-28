#!/usr/bin/env python3

from optparse import OptionParser
from math import inf
import os, sys
import json

parser = OptionParser()
parser.add_option("-d", "--database", dest="database",
                help="Database JSON file to read from, default: %default",
                default="/home/user/result.json")
parser.add_option("-s", "--stats", dest="stats", action="append", choices=["solved", "fastest", "total", "threshold", "unique"],
                help="Stats to display, could be repeated to specify multiple, must not be omitted."
                "Valid fields: solved, fastest, total, threshold, unique",
                default=[])
parser.add_option("-t", "--track", dest="tracks", action="append", choices=["CLIA", "INV", "General"],
                help="Tracks selected to be displayed, could be repeated to specify multiple,"
                " if omitted, all would be selected. This option won't change unique stats. Valid fields: CLIA, INV, General",
                default=[])
parser.add_option("-T", "--threshold", dest="threshold", type="float",
                help="Threshold time in seconds, to display number of benchmarks solved under threshold time,"
                " for stats type 'threshold', default: %default",
                default=30)
(options, args) = parser.parse_args()

if options.stats == []:
    print("No stats selected to display, use -s / --stats to select some, see --help for details")
    sys.exit(1)

if options.tracks == []:
    options.tracks = ["CLIA", "INV", "General"]

db = {}
benches = {}

def collect_benchmarks():
    benchmarks = set()
    for s in db:
        benchmarks |= set(db[s].keys())
    sorted_benchmarks = {
        "INV": set(), "CLIA": set(), "General": set()
    }
    for b in benchmarks:
        if '/INV/' in b:
            sorted_benchmarks["INV"].add(b)
        elif '/CLIA/' in b:
            sorted_benchmarks["CLIA"].add(b)
        elif '/General/' in b:
            sorted_benchmarks["General"].add(b)
    return sorted_benchmarks

def print_solved(track):
    stat = {"dryadsynth":0, "cvc4":0, "eusolver":0, "loopinvgen":0}
    for s in db:
        for b in db[s]:
            if b in benches[track] and db[s][b][0] == "DONE":
                stat[s] += 1

    print(f"Track: {track}, {len(benches[track])} benchmarks, solved stats")
    for s in stat:
        if track != "INV" and s == "loopinvgen":
            continue
        print(f"{s:>10}: {stat[s]:>3}" )

def get_bucket(result):
    if result == None:
        return inf
    if result[0] != "DONE":
        return inf
    if result[1] < 0.0:
        return inf
    if result[1] < 1.0:
        return 1.0
    if result[1] < 3.0:
        return 3.0
    if result[1] < 10.0:
        return 10.0
    if result[1] < 100.0:
        return 100.0
    if result[1] < 300.0:
        return 300.0
    if result[1] < 1000.0:
        return 1000.0
    if result[1] < 1800.0:
        return 1800.0
    return inf
    

def print_fastest(track):
    # bucket_time = { "bench1": {"solver1": time1, "solver2": time2, ...}, ... }
    bucket_time = {}
    for b in benches[track]:
        per_solver = {}
        for s in db:
            per_solver[s] = get_bucket(db[s].get(b, None))
        bucket_time[b] = per_solver

    fastest_time = {}
    for b in bucket_time:
        fastest_time[b] = min(bucket_time[b].values())
    
    stat = {"dryadsynth":0, "cvc4":0, "eusolver":0, "loopinvgen":0}

    for b in bucket_time:
        for s in bucket_time[b]:
            if fastest_time[b] != inf and fastest_time[b] == bucket_time[b][s]:
                stat[s] += 1

    print(f"Track: {track}, {len(benches[track])} benchmarks, fastest stats")
    for s in stat:
        if track != "INV" and s == "loopinvgen":
            continue
        print(f"{s:>10}: {stat[s]:>3}" )

def print_total(track):
    stat = {"dryadsynth":[0, 0.0], "cvc4":[0, 0.0], "eusolver":[0, 0.0], "loopinvgen":[0, 0.0]}
    for s in db:
        for b in db[s]:
            if b in benches[track] and db[s][b][0] == "DONE":
                stat[s][0] += 1
                stat[s][1] += db[s][b][1]

    print(f"Track: {track}, {len(benches[track])} benchmarks, total stats")
    for s in stat:
        if track != "INV" and s == "loopinvgen":
            continue
        print(f"{s:>10}_solved: {stat[s][0]:>10}" )
        print(f"{s:>11}_total: {stat[s][1]:>10.1f}" )
    
def print_threshold(track):
    stat = {"dryadsynth":0, "cvc4":0, "eusolver":0, "loopinvgen":0}
    for s in db:
        for b in db[s]:
            if b in benches[track] and db[s][b][0] == "DONE":
                if db[s][b][1] <= options.threshold:
                    stat[s] += 1

    print(f"Track: {track}, {len(benches[track])} benchmarks, threshold stats, threshold: {options.threshold} seconds")
    for s in stat:
        if track != "INV" and s == "loopinvgen":
            continue
        print(f"{s:>10}: {stat[s]:>3}" )

def print_unique():
    total_benchmarks = benches['INV'] | benches['CLIA'] | benches['General']
    unique = 0

    for b in total_benchmarks:
        if db['dryadsynth'].get(b, None) == "DONE" and \
            db['cvc4'].get(b, None) != "DONE" and \
            db['eusolver'].get(b, None) != "DONE" and \
            db['loopinvgen'].get(b, None) != "DONE":
            unique += 1
    print(f"dryadsynth_uniquely_solved: {unique}")

def main():
    global db, benches
    if not os.path.exists(options.database):
        print("Database not found!")
        sys.exit(1)
    with open(options.database) as f:
        print(f"Loading from {options.database}")
        db = json.load(f)
    benches = collect_benchmarks()
    for s in options.stats:
        if s == "unique":
            print("Stat: unique")
            print("------------") 
            print_unique()
            print()
            continue
        for t in options.tracks:
            heading = f"Stat: {s}"
            print(s)
            print("-"*len(heading))
            globals().get(f"print_{s}")(t)
            print()

if __name__ == "__main__":
    main()





