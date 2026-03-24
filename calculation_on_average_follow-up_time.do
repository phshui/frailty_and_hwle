clear
use "C:\Users\Administrator\Desktop\gs_study\dta_for_supervisor\yhshui_analysis_processed\append\hwle_append.dta" 

keep dod rdate* rstate*
g id=_n
reshape long rdate rstate, i(id) j(wave)
replace rdate="" if rdate=="99/9999"

g rdate_num=monthly(rdate, "MY")
format rdate_num %tm

g dod_num=monthly(dod, "MY")
format dod_num %tm

bysort id: egen start_date=min(rdate_num)
bysort id: egen last_rdate=max(rdate_num)

g is_dead_temp=(rstate=="5")
bysort id: egen is_dead=max(is_dead_temp)

bysort id: keep if _n==1

gen end_date=last_rdate
replace end_date=dod_num if is_dead==1 & !missing(dod_num)

gen followup_years=(end_date-start_date)/12

summarize followup_years, detail

display "Average follow-up time(years): " r(mean)