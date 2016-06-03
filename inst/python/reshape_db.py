# Re-shape Whitney's recovery actions dataset for analysis in R.
# Copyright (C) 2015 Defenders of Wildlife, jmalcom@defenders.org

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

import sys

def main():
    """Re-shape Whitney's recovery actions dataset for analysis in R.
    
    USAGE:
        reshape_db.py <infile> <outfil>
    """
    res = load_file()
    write_new(res)

def load_file():
    "Load the input file into a dictionary for writing."
    res = {}
    for line in open(infile):
        if not line.startswith("Species") or \
                not line.startswith("Control") or\
                not line.startswith("\t"):
            data = line.replace("'", "").replace("#", "N").replace('"', '').rstrip().split("\t")
            if len(data) > 35 and "Species" not in data[0]:
                sp_name = data[0].split(" (")[0]
                res[sp_name] = {"N_act": {1: data[1],
                                          2: data[2],
                                          3: data[3]},
                                "N_compl": {1: data[4],
                                            2: data[5],
                                            3: data[6]},
                                "N_partc": {1: data[7],
                                            2: data[8],
                                            3: data[9]},
                                "N_oncur": {1: data[10],
                                            2: data[11],
                                            3: data[12]},
                                "N_nocur": {1: data[13],
                                            2: data[14],
                                            3: data[15]},
                                "N_nostr": {1: data[16],
                                            2: data[17],
                                            3: data[18]},
                                "N_obsol": {1: data[19],
                                            2: data[20],
                                            3: data[21]},
                                "N_disco": {1: data[22],
                                            2: data[23],
                                            3: data[24]},
                                "Total": data[25],
                                "Threat_allev": data[26],
                                "Improve_demo": data[27],
                                "Listing_chng": data[28],
                                "five-yr_revw": data[29],
                                "listing_date": data[30],
                                "act_recov_pl": data[31],
                                "priority_num": data[32],
                                "tot_act_comp": data[33],
                                "pct_act_comp": data[34],
                                "Comments": data[35]}
    return res

def write_new(r):
    "Write the re-shaped data file."
    head = ["Species", "Priority", "N_act", "N_compl", "N_partc", "N_oncur", 
            "N_nocur", "N_nostr", "N_obsol", "N_disco", "Total", "Threat_allev", 
            "Improve_demo", "Listing_chng", "five-yr_revw", "listing_date", 
            "act_recov_pl", "priority_num", "tot_act_comp", "pct_act_comp", 
            "Comments"]
    header = "\t".join(head) + "\n"
    with open(outfil, 'wb') as out:
        out.write(header)
        for k in r:
            for l in (1, 2, 3):
                dat = [k, str(l), r[k]["N_act"][l], r[k]["N_compl"][l], 
                       r[k]["N_partc"][l], r[k]["N_oncur"][l], r[k]["N_nocur"][l], 
                       r[k]["N_nostr"][l], r[k]["N_obsol"][l], r[k]["N_disco"][l], 
                       r[k]["Total"], r[k]["Threat_allev"], r[k]["Improve_demo"],
                       r[k]["Listing_chng"], r[k]["five-yr_revw"], 
                       r[k]["listing_date"], r[k]["act_recov_pl"], 
                       r[k]["priority_num"], r[k]["tot_act_comp"], 
                       r[k]["pct_act_comp"], r[k]["Comments"]]
                to_write = "\t".join(dat) + "\n"
                out.write(to_write)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print main.__doc__
        sys.exit()
    infile = sys.argv[1]
    outfil = sys.argv[2]
    main()








