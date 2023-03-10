using Pkg
Pkg.add("BioAlignments")
using BioAlignments

#Function to check DNA structure
function check_dna(dna::String)
    nu = "ATGC"
    for i in dna
        if i ∉ nu
            return "-"
        end
    end
    return dna
end

seq = "CCTAGGAGGG"
ref = "ACCTGGTATGATAGCG"

scoremodel = AffineGapScoreModel(EDNAFULL,gap_open = -16, gap_extend = -1)
res = pairalign(GlobalAlignment(),check_dna(seq),check_dna(ref), scoremodel)

s = score(res)
aln = alignment(res)

collect(aln)
# -> aln is an array of tuples, which describe all positions in the alignment

#read Alignments: aligned seq und ref (saved in string)
aln_seq = reduce(*,[x for (x,_) in aln])
aln_ref = reduce(*,[y for (_,y) in aln])