graph()
{
echo "ENTER PRODUCT ID"
read eno;
echo "ENTER UNIT COST"
read ecost;
echo "ENTER SALES PRICE"
read esales;
echo "ENTER QUANTITY"
read equant;
ecost1=$(expr $ecost \* $equant)
eprice=$(expr $esales \* $equant)
#! /bin/bash

TEMP=$(mktemp -t chart.XXXXX)
QUERY1=$ecost1
QUERY2=$eprice
cat > $TEMP <<EOF
<html>
  <head>
    <!--Load the AJAX API-->
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">

      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Title');
        data.addColumn('number', 'Value');
        data.addRows([
          ['TOTAL COST PRICE', $QUERY1],
          ['TOTAL SALES PRICE', $QUERY2]
        ]);

        // Set chart options
        var options = {'title':'PRICE GRAPH',
                       'width':900,
                       'height':700};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
  </head>

  <body>
    <!--Div that will hold the pie chart-->
    <div id="chart_div"></div>
  </body>
</html>
EOF

# open browser
case $(uname) in
   Darwin)
      open -a /Applications/Google\ Chrome.app $TEMP
      ;;

   Linux|SunOS)
      firefox $TEMP
      ;;
 esac
}
infor()
{
echo "***************INFORMATION ABOUT PRODUCTS*****************";
echo "THIS SECTION IS TO TELL WHAT KIND OF PRODUCTS ARE IN THE STORE";
echo "ENTER THE OPTION WHICH SUITS YOU:";
echo "1. EDIBLES";
echo "2. GENERAL ITEMS";
echo "OPTION :-";
read  sher;
case $sher in
1) cat eat.txt
   ;;
2) cat general.txt
   ;;
esac
stty -echo raw
c=$(dd bs=1 count=1 2>/dev/null )
stty echo -raw
}

entry()
{
echo "ENTER PRODUCT ID"
read eno;
echo "ENTER DESCRIPTION"
read edesc;
echo "ENTER CABINET NUMBER"
read ecab;
echo "ENTER RACK NUMBER"
read erack;
echo "ENTER UNIT COST"
read ecost;
echo "ENTER SALES PRICE"
read esales;
echo "ENTER QUANTITY"
read equant;
ecost1=$(expr $ecost \* $equant)
eprice=$(expr $esales \* $equant) 
sim=` grep -c -i "$eno" shop.txt`
if [ $sim -eq 0 ]
then
echo "$eno    $edesc     	$ecab       $erack            $ecost         $esales    	    $equant     	  $ecost1      $eprice" | cat >> shop.txt;
echo "SAVING..........................."|pv -qL 20;
echo -n "◐\r"; sleep .3; echo -n "◓\r"; sleep .3; echo -n "◑\r"; sleep .3; echo -n "◒\r"; sleep .3;
sleep 1
echo "RECORD SAVED..............."
else
echo " THIS PRODUCT ID NUMBER ALREADY EXISTS IN THE DATABASE"
fi
sleep 2
clear;  
}

search()
{
echo "SEARCHING DATA";
echo "ENTER PRODUCT ID NUMBER";
read eno;
sim=` grep -c -i  "$eno" database.txt`
if [ $sim -eq 0 ]
then
echo 'SEARCHING........\r'|pv -qL 20;
echo -n "◐\r"; sleep .3; echo -n "◓\r"; sleep .3; echo -n "◑\r"; sleep .3; echo -n "◒\r"; sleep .3;
sleep 2
echo "ID    DESCRIPTION	CAB-NO  RACK_NUMBER  UNIT-COST SALES-PRICE QUANTITY TOTAL-COST TOTAL-PRICE:	 "
grep "$eno" shop.txt

else
echo " THE PROVIDED DATA DOES NOT EXISTS"
fi
echo "Click to continue......"
stty -echo raw
c=$(dd bs=1 count=1 2>/dev/null )
stty echo -raw
}

del()
{
echo "DELETING DATA"
echo "ENTER PRODUCT ID NUMBER TO SEARCH ????"
read choice
sim=` grep -c -i "$choice" shop.txt`

if [ $sim -eq 0 ]
then
echo "THE PROVIDED PRODUCT ID DOES NOT EXIST IN DATABASE"
else
grep -v -i "$choice" shop.txt >second.txt
mv second.txt shop.txt
echo 'DELETING........\r'|pv -qL 20;
echo -n "◐\r"; sleep .3; echo -n "◓\r"; sleep .3; echo -n "◑\r"; sleep .3; echo -n "◒\r"; sleep .3;
sleep 2
echo "DATA DELETED"
sleep 1
echo
fi
}

sold()
{
echo "ENTER PRODUCT ID NUMBER TO SEARCH ????"
read choice
sim=` grep -c -i "$choice" shop.txt`
if [ $sim -eq 0 ]
then
echo "THE PROVIDED PRODUCT ID DOES NOT EXIST IN DATABASE"
else
grep -v -i "$choice" shop.txt >second.txt
mv second.txt shop.txt
fi
echo "ENTER DESCRIPTION"
read edesc;
echo "ENTER CABINET NUMBER"
read ecab;
echo "ENTER RACK NUMBER"
read erack;
echo "ENTER UNIT COST"
read ecost;
echo "ENTER SALES PRICE"
read esales;
echo "ENTER QUANTITY"
read equant;
ecost1=$(expr $ecost \* $equant)
eprice=$(expr $esales \* $equant)
num=$((esales- ecost))
prof= $(expr $num \* $equant)
sim=` grep -c -i "$choice" shop.txt`
if [ $sim -eq 0 ]
then
echo "$eno    $edesc     	$ecab       $erack            $ecost         $esales    	    $equant     	  $ecost1      $eprice" | cat >> shop.txt;
else
echo " THIS PRODUCT ID NUMBER ALREADY EXISTS IN THE DATABASE"
fi
sleep 2
clear;
}
report()
{
echo "GENERATING REPORT...................."|pv -qL 20;
echo -n "◐\r"; sleep .3; echo -n "◓\r"; sleep .3; echo -n "◑\r"; sleep .3; echo -n "◒\r"; sleep .3; 
sleep 2
echo ""
echo "_______________________________________________"
echo "******************REPORT***********************"
echo "_______________________________________________"
echo "" 
echo "ID    DESCRIPTION	CAB-NO  RACK_NUMBER  UNIT-COST SALES-PRICE QUANTITY TOTAL-COST TOTAL-PRICE:	 "
cat shop.txt;
echo "Click to continue......"
stty -echo raw
c=$(dd bs=1 count=1 2>/dev/null )
stty echo -raw
}
while [ 1 ]
do
echo ""
echo "---------------------------------------------------------------" 
echo "*****************INVENTORY MANAGEMENT SYSTEM*******************" ;
echo "---------------------------------------------------------------" ;
echo "$(date '+%D %T' | toilet -f term -F border --gay)";
echo "-------------------------------";
echo "-*-*-*-*-* MAIN MENU *-*-*-*-*- ";
echo "-------------------------------";
echo "1  - INFORMATION ABOUT PRODUCTS"| pv -qL 40;
echo "2  - ENTER PURCHASE RECORDS"| pv -qL 40;
echo "3  - UPDATE PURCHASED RECORDS"| pv -qL 40;
echo "4  - SEARCH FOR RECORDS"| pv -qL 40;
echo "5  - DELETE RECORDS FROM STORE DATABASE"| pv -qL 40;
echo "6  - VIEW SALES AND PURCHASE REPORT"| pv -qL 40;
echo "7  - GENERATE PIE GRAPH"| pv -qL 40;
echo "E  - EXIT"| pv -qL 40;
echo "----------------------------------------------------------------";
echo "ENTER YOUR CHOICE::" | pv -qL 20;
read choice;
case $choice in
1) infor
   clear;
   ;;
2) entry
   ;;
3) sold
   ;;
4) search
   clear;
   ;;
5) del
   clear;
   ;;
6) report
   clear;
   ;;
7) graph
   clear;
   ;;
E) echo "**************************************************************";
   echo "-----------------------CREATED BY:----------------------------";
   echo "**************************************************************";
   echo " RAJ PATEL   ...........(14BCE093)"|pv -qL 20;
   echo " SARATH KAUL ...........(14BCE104)"|pv -qL 20;
   sleep 2;      
   exit;
   ;;
e) echo "**************************************************************";
   echo "-----------------------CREATED BY:----------------------------";
   echo "**************************************************************";
   echo " RAJ PATEL   ...........(14BCE093)"|pv -qL 20;
   echo " SARATH KAUL ...........(14BCE104)"|pv -qL 20;
   sleep 2;
   exit;
   ;;
esac 
done
