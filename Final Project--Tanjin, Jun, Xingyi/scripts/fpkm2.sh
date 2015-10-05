#!/bin/sh

wdir=/nfs1/BIOMED/Ramsey_Lab/tanjin/TCGA/blca
cd $wdir

geneFpkmFile="genes.fpkm_tracking"
geneFpkmOut="fpkm.out"
geneFpkmTmpOut="fpkm.out.tmp"
geneIDTmpOut="genes_tmp.out"
geneIDOut="genes.out"

rm -rf ./$geneIDTmpOut
rm -rf ./$geneIDOut

cuffdirs=`find RNASeq/* -type d -name "cufflinks"`
i=0

#---------------------------------------------------
# get fpkm values from all samples
#---------------------------------------------------
for dir in $cuffdirs
do
   cdir=$wdir/$dir
   fpkmorg=$cdir/$geneFpkmFile
   fpkmtmpout=$cdir/$geneFpkmTmpOut
   fpkmout=$cdir/$geneFpkmOut"."$i
   geneout=$cdir/"geneid."$i

   if [ -f $fpkmorg ]; then
      rm -rf $fpkmout

      i=`expr $i + 1`
    
      egrep -v 'tracking_id|CUFF' $fpkmorg|awk '{print $4}'|sed 's/"//g'|sed 's/;//g'|sort -u > $geneout
      cat $geneout >> ./$geneIDTmpOut
      egrep -v 'tracking_id|CUFF' $fpkmorg|awk '{print $4"\t"$10}'|sed 's/"//g'|sed 's/;//g'|sort -k1,2 > $fpkmtmpout

      #need to average the fpkm value if the same gene has more than 1 expression
      perl fpkmavg.pl $fpkmtmpout $fpkmout

      rm -rf ./fpkm/$geneFpkmOut"."$i
      cp -f $fpkmout ./fpkm/$geneFpkmOut"."$i
      rm -rf $fpkmtmpout
   fi
done

samplesnum=$i
echo "----------------------------------------------"
echo "----there are $samplesnum samples----"
echo "----------------------------------------------"

sort -u ./$geneIDTmpOut  > ./$geneIDOut

#------------------------------------------------------------------
# merge all fpkm values by (gene,transcript)
#------------------------------------------------------------------
count=2
outfmt="1.1,1.2"

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

     join -1 2 -2 1 -o $outfmt -e '0' -a1 ./fpkmall.out ./fpkm/$geneFpkmOut"."$i >./fpkmall.tmp
     mv fpkmall.tmp fpkmall.out
     outfmt="1.1,1.2"
  fi

  count=`expr $count + 1`
  i=`expr $i + 1`
done

#sort -k1,1 -k2,2 fpkmall.out | awk '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12}' >> ./tcga_fpkm_all.out
#sort -k1,1 fpkmall.out
