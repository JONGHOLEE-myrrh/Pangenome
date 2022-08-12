import os, sys

in_gff  = open("220809_intersect_PAV_5percent_Dempsey.bed", "r")
in_ipr  = open("Dempsey.Pfam.iprscan", "r")
out_tsv = open("ForBarPlot.tsv", "w")

s_dic_gene_pfam    = {}
s_dic_pfam_id_desc = {}
for s_ipr_line in in_ipr.readlines():
    s_ipr_line = s_ipr_line.strip()
    s_split_ipr_line = s_ipr_line.split("\t")
    s_gene_id   = s_split_ipr_line[0].split(".")[0]
    s_pfam_id   = s_split_ipr_line[1]
    s_pfam_desc = s_split_ipr_line[2]

    s_dic_gene_pfam[s_gene_id] = s_pfam_id
    s_dic_pfam_id_desc[s_pfam_id] = s_pfam_desc
#    print(s_pfam_id)
# End of for loop.
in_ipr.close()

#print(s_dic_gene_pfam.keys())

n_dic_count = {}
for s_gff_line in in_gff.readlines():
    s_gff_line = s_gff_line.strip()
    s_split_gff_line = s_gff_line.split("\t")

    s_gene_id_2 = s_split_gff_line[8].split(".")[1]
#    print(s_gene_id_2)

    if s_gene_id_2 in s_dic_gene_pfam.keys():
        try:
            n_dic_count[s_dic_gene_pfam[s_gene_id_2]] += 1
        except KeyError:
            n_dic_count[s_dic_gene_pfam[s_gene_id_2]] = 1
    else: continue
# End of for loop.
in_gff.close()

print("DESCRIPTION\tID\tNUMBER", file=out_tsv)
for s_key in sorted(n_dic_count.keys(), key=lambda x: int(n_dic_count[x]), reverse=True):
#    print(s_key)
    print("%s\t%s\t%s"%(s_dic_pfam_id_desc[s_key], s_key, n_dic_count[s_key]), file=out_tsv)
# End of for loop.
out_tsv.close()
