gen t= date(observation_date,"YMD")



gen q=quarter(t)

gen year= year(t)

gen yq=yq(year,q)

format yq %tq

