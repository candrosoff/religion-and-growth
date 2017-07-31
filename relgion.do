use "WV6_Stata_v_2016_01_01.dta", clear
//using world values survey 6 data
set more off

//ssc install estout, replace install - run this command if not installed already
keep V2 V57 V144 V145 V146 V147 V148 V149 V150 V151 V152 V229 V237 V239 V240 V241 V242 V248 V254

gen saving = (V237==1)

gen employment = ( V229==1| V229==2 |V229==3)

gen nlf = (V229 ==4 | V229 ==5 | V229 ==6 | V229 ==8| V229 ==-3| V229 ==-2| V229 ==-1| V229 ==-4  )

gen God=(V148==1)

gen hell=(V149==1)

gen religious =(V144 != 0)

gen attendance =(V145 == 1 | V145==2 )

gen prayer =(V146==1 | V146==2 |V146==3 )

gen muslim = (V144==49)

gen catholic =(V144==64)

gen other =(V144 != 49|V144 != 64|V144 != 0|V144 != -5|V144 != -4|V144 != -2|V144 != -1)

gen income2=(V239==2)

gen income3=(V239==3)

gen income4=(V239==4)

gen income5=(V239==5)

gen income6=(V239==6)

gen income7=(V239==7)

gen income8=(V239==8)

gen income9=(V239==9)

gen income10=(V239==10)

gen sex=(V240==1)

gen age=(V242)

gen agesq =(V242^2)

gen noeduc=(V248==1)

gen primary=(V248==2 | V248==3)

gen secondary=(V248==4 | V248==5 | V248==6 | V248==7)

gen university= (V248==8 | V248==9)

mean God hell religious attendance prayer

save data, replace

pca God hell religious attendance prayer

predict pc1

collapse pc1, by(V2)

graph bar pc1, over(V2, sort(1) label(angle(90)) gap(65)) xsize(8.5)

//end of question 2

save pc1, replace

merge 1:m V2 using data

//question 3

eststo: quietly reg saving God age agesq income2-income10 primary secondary university if nlf==0
eststo: quietly reg saving hell age agesq income2-income10  primary secondary university if nlf==0
eststo: quietly reg saving religious age agesq income2-income10  primary secondary university if nlf==0
eststo: quietly reg saving attendance age agesq income2-income10  primary secondary university if nlf==0
eststo: quietly reg saving pc1 age agesq income2-income10  primary secondary university if nlf==0

esttab, ar2

eststo clear

//question 4

eststo: quietly reg saving God age agesq income2-income10 primary secondary muslim catholic university if nlf==0
eststo: quietly reg saving hell age agesq income2-income10  primary secondary muslim catholic university if nlf==0
eststo: quietly reg saving religious age agesq income2-income10  primary secondary muslim catholic university if nlf==0
eststo: quietly reg saving attendance age agesq income2-income10  primary secondary muslim catholic university if nlf==0
eststo: quietly reg saving pc1 age agesq income2-income10 primary secondary muslim catholic university if nlf==0

//display question 3 and question 4 in a table
esttab, ar2

eststo clear
//question 5

eststo: quietly reg employment God age agesq income2-income10  primary secondary university if nlf==0
eststo: quietly reg employment hell age agesq income2-income10  primary secondary university if nlf==0
eststo: quietly reg employment religious age agesq income2-income10  primary secondary university if nlf==0
eststo: quietly reg employment attendance age agesq income2-income10  primary secondary university if nlf==0
eststo: quietly reg employment pc1 age agesq income2-income10  primary secondary university if nlf==0

esttab, ar2

eststo clear

//question 6

eststo: quietly reg employment God age agesq income2-income10  primary secondary muslim catholic university if nlf==0
eststo: quietly reg employment hell age agesq income2-income10  primary secondary muslim catholic university if nlf==0
eststo: quietly reg employment religious age agesq income2-income10  primary secondary muslim catholic university if nlf==0
eststo: quietly reg employment attendance age agesq income2-income10  primary secondary muslim catholic university if nlf==0
eststo: quietly reg employment pc1 age agesq income2-income10 primary secondary muslim catholic university if nlf==0

esttab, ar2

eststo clear
