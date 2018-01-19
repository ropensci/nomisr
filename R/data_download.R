


nomis_data_access <- function(id){

  q <- jsonlite::fromJSON("https://www.nomisweb.co.uk/api/v01/dataset/NM_1_1.jsonstat.json?", flatten = T)


}


#results <- fromJSONstat("https://www.nomisweb.co.uk/api/v01/dataset/NM_1_1.jsonstat.json?")
##investigate this JSONstat package further - currently 2 years since anything has been done to it, it is still the best way forward?