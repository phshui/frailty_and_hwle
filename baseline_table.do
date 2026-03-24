clear
use "C:\Users\Administrator\Desktop\gs_study\dta_for_supervisor\yhshui_analysis_processed\append\hwle_append.dta" 
keep pid gender edu2 edu3 dob rdate1 rstate1 rprefrail1 rfrail1 rmaritalb rsmokeb countryname cid
g birth_date=monthly(dob, "MY")
g follow_date=monthly(rdate1, "MY")

format birth_date follow_date %tm

g age=(follow_date-birth_date)/12

g age_int=round((follow_date-birth_date)/12)

list pid dob rdate1 birth_date follow_date age age_int in 1/10
		 
tab1 countryname cid
recode cid (1=1)(2=2)(3=5)(4=4)(40 56 100 191 196 203 208 233 246 250 276 300 348 372 376 380 428 440 442 470 528 616 620 642 703 705 724 752 756=3), g(dataid)

btable age rprefrail1 rfrail1 gender edu2 edu3 rmaritalb rsmokeb,  ///
         by(dataid) saving("baseline_table") conti(age) cat(rprefrail1 rfrail1 gender edu2 edu3 rmaritalb rsmokeb)