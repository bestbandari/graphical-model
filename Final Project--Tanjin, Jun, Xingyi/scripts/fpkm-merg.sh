#!/bin/sh

wdir=/nfs1/BIOMED/Ramsey_Lab/tanjin/TCGA/blca
cd $wdir

geneFpkmFile="genes.fpkm_tracking"
geneFpkmOut="fpkm.out"
geneFpkmTmpOut="fpkm.out.tmp"
geneIDTmpOut="genes_tmp.out"
geneIDOut="genes.out"

#------------------------------------------------------------------
# merge all fpkm values by (gene,transcript)
#------------------------------------------------------------------
count=2
outfmt="1.1,1.2"
samplesnum=433

i=1
rm -rf fpkmall.*

while [ $i -le $samplesnum ]
do
  if [ $count -eq 2 ]; then
     join -1 1 -2 1 -o 1.1,2.2 -e '0' -a1 ./$geneIDOut ./fpkm/$geneFpkmOut"."$i >./fpkmall.out
  else
     j=3
     while [ $j -le $count ]
     do
        outfmt=$outfmt",1."$j
        j=`expr $j + 1`
     done

     outfmt=$outfmt",2.2"
     echo $outfmt

     join -1 1 -2 1 -o $outfmt -e '0' -a1 ./fpkmall.out ./fpkm/$geneFpkmOut"."$i >./fpkmall.tmp
     mv fpkmall.tmp fpkmall.out
     outfmt="1.1,1.2"
  fi

  count=`expr $count + 1`
  i=`expr $i + 1`
done

#sort -k1,1 -k2,2 fpkmall.out | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12}' >> ./tcga_fpkm_all.out
#sort -k1,1 fpkmall.out

