search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | where AdvEngineID != 0 | stats count()
search2 repo=\"hits_events\" | stats sum(AdvEngineID) as sum_avde, count(),avg(ResolutionWidth)
search2 repo=\"hits_events\" | stats avg(UserID)
search2 repo=\"hits_events\" | stats distinct_count(UserID)
search2 repo=\"hits_events\" | stats distinct_count(SearchPhrase)
search2 repo=\"hits_events\" | stats min(EventDate),max(EventDate)
search2 repo=\"hits_events\" | where AdvEngineID!=0 | stats  count() as cnt  by AdvEngineID | sort by cnt desc
search2 repo=\"hits_events\" | stats  distinct_count(UserID) as cnt  by RegionID | sort 11 by cnt desc
search2 repo=\"hits_events\" | stats  sum(AdvEngineID),count() as cnt, avg(ResolutionWidth), distinct_count(UserID) by RegionID | sort 11 by cnt desc
search2 repo=\"hits_events\" | where MobilePhoneModel !=\"\" |  stats distinct_count(UserID) as u by MobilePhoneModel | sort 12 by u desc
search2 repo=\"hits_events\" | where MobilePhoneModel !=\"\" |  stats distinct_count(UserID) as u by MobilePhone, MobilePhoneModel | sort 11 by u desc
search2 repo=\"hits_events\" | where SearchPhrase !=\"\" |  stats count() as cnt by SearchPhrase | sort 11 by cnt desc
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | where SearchPhrase !=\"\" |  stats count() as cnt by SearchEngineID,SearchPhrase | sort 11 by cnt desc
search2 repo=\"hits_events\" | stats count() as cnt by UserID | sort 11 by cnt desc
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | stats count() as cnt by UserID,SearchPhrase | limit 11
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | where UserID =435090932899640449 | fields UserID
search2 repo=\"hits_events\" | where URL like \"%google%\" | stats count()
search2 repo=\"hits_events\" | where URL like \"%google%\" and SearchPhrase !=\"\" | eval l= len(URL) | stats count() as cnt ,min(l) by SearchPhrase | sort 11 by cnt desc
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | where URL like \"%google%\" | sort 11 by EventTime asc
search2 repo=\"hits_events\" | where SearchPhrase != \"\" | sort 11 by EventTime asc
search2 repo=\"hits_events\" | where SearchPhrase != \"\" |fields SearchPhrase  | sort 9 by SearchPhrase asc
search2 repo=\"hits_events\" | where SearchPhrase != \"\"  | sort 11 by EventTime asc, SearchPhrase
search2 repo=\"hits_events\" | where URL != \"\"  | stats count() as cnt, avg(len(URL)) as l by CounterID | where cnt > 100000 |sort 26 by l desc
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | stats sum(ResolutionWidth), sum(ResolutionWidth + 1), sum(ResolutionWidth + 2), sum(ResolutionWidth + 3), sum(ResolutionWidth + 4), sum(ResolutionWidth + 5), sum(ResolutionWidth + 6), sum(ResolutionWidth + 7), sum(ResolutionWidth + 8), sum(ResolutionWidth + 9), sum(ResolutionWidth + 10), sum(ResolutionWidth + 11), sum(ResolutionWidth + 12), sum(ResolutionWidth + 13), sum(ResolutionWidth + 14), sum(ResolutionWidth + 15), sum(ResolutionWidth + 16), sum(ResolutionWidth + 17), sum(ResolutionWidth + 18), sum(ResolutionWidth + 19), sum(ResolutionWidth + 20), sum(ResolutionWidth + 21), sum(ResolutionWidth + 22), sum(ResolutionWidth + 23), sum(ResolutionWidth + 24), sum(ResolutionWidth + 25), sum(ResolutionWidth + 26), sum(ResolutionWidth + 27), sum(ResolutionWidth + 28), sum(ResolutionWidth + 29), sum(ResolutionWidth + 30), sum(ResolutionWidth + 31), sum(ResolutionWidth + 32), sum(ResolutionWidth + 33), sum(ResolutionWidth + 34), sum(ResolutionWidth + 35), sum(ResolutionWidth + 36), sum(ResolutionWidth + 37), sum(ResolutionWidth + 38), sum(ResolutionWidth + 39), sum(ResolutionWidth + 40), sum(ResolutionWidth + 41), sum(ResolutionWidth + 42), sum(ResolutionWidth + 43), sum(ResolutionWidth + 44), sum(ResolutionWidth + 45), sum(ResolutionWidth + 46), sum(ResolutionWidth + 47), sum(ResolutionWidth + 48), sum(ResolutionWidth + 49), sum(ResolutionWidth + 50), sum(ResolutionWidth + 51), sum(ResolutionWidth + 52), sum(ResolutionWidth + 53), sum(ResolutionWidth + 54), sum(ResolutionWidth + 55), sum(ResolutionWidth + 56), sum(ResolutionWidth + 57), sum(ResolutionWidth + 58), sum(ResolutionWidth + 59), sum(ResolutionWidth + 60), sum(ResolutionWidth + 61), sum(ResolutionWidth + 62), sum(ResolutionWidth + 63), sum(ResolutionWidth + 64), sum(ResolutionWidth + 65), sum(ResolutionWidth + 66), sum(ResolutionWidth + 67), sum(ResolutionWidth + 68), sum(ResolutionWidth + 69), sum(ResolutionWidth + 70), sum(ResolutionWidth + 71), sum(ResolutionWidth + 72), sum(ResolutionWidth + 73), sum(ResolutionWidth + 74), sum(ResolutionWidth + 75), sum(ResolutionWidth + 76), sum(ResolutionWidth + 77), sum(ResolutionWidth + 78), sum(ResolutionWidth + 79), sum(ResolutionWidth + 80), sum(ResolutionWidth + 81), sum(ResolutionWidth + 82), sum(ResolutionWidth + 83), sum(ResolutionWidth + 84), sum(ResolutionWidth + 85), sum(ResolutionWidth + 86), sum(ResolutionWidth + 87), sum(ResolutionWidth + 88), sum(ResolutionWidth + 89)
search2 repo=\"hits_events\" | where SearchPhrase!=\"\" | stats count() as cnt ,sum(IsRefresh),avg(ResolutionWidth) by SearchEngineID, ClientIP | sort 11 by cnt desc
search2 repo=\"hits_events\" | where SearchPhrase!=\"\" | stats count() as cnt ,sum(IsRefresh),avg(ResolutionWidth) by WatchID, ClientIP | sort 11 by cnt desc
search2 repo=\"hits_events\" | stats count() as cnt ,sum(IsRefresh),avg(ResolutionWidth) by WatchID, ClientIP | sort 11 by cnt desc
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | stats count()
search2 repo=\"hits_events\" | where CounterID=62 AND EventDate >=toTimestamp(\"2013-07-01\", \"yyyy-MM-dd\", 0)  AND EventDate <= toTimestamp(\"2013-07-31\", \"yyyy-MM-dd\", 0) AND DontCountHits = 0 AND IsRefresh = 0 AND URL !=\"\" | stats count() as cnt by URL | sort 11 by cnt desc
search2 repo=\"hits_events\" | where CounterID=62 AND EventDate >=toTimestamp(\"2013-07-01\", \"yyyy-MM-dd\", 0)  AND EventDate <= toTimestamp(\"2013-07-31\", \"yyyy-MM-dd\", 0) AND DontCountHits = 0 AND IsRefresh = 0 AND Title !=\"\" | stats count() as cnt by Title | sort 11 by cnt desc
search2 repo=\"hits_events\" | where CounterID=62 AND EventDate >=toTimestamp(\"2013-07-01\", \"yyyy-MM-dd\", 0)  AND EventDate <= toTimestamp(\"2013-07-31\", \"yyyy-MM-dd\", 0) AND IsRefresh = 0 AND IsLink !=0 AND IsDownload =0 | stats count() as cnt by URL | sort 1011 by cnt desc | limit 11,1000
search2 repo=\"hits_events\" | where CounterID=62 AND EventDate >=toTimestamp(\"2013-07-01\", \"yyyy-MM-dd\", 0)  AND EventDate <= toTimestamp(\"2013-07-31\", \"yyyy-MM-dd\", 0) AND IsRefresh = 0 | eval Src=case((SearchEngineID = 0 AND AdvEngineID = 0),Referer,\"\"), Dst=URL | stats count() as cnt by TraficSourceID, SearchEngineID, AdvEngineID,Src,Dst | sort 1011 by cnt desc | limit 11,1000
search2 repo=\"hits_events\" | where CounterID=62 AND EventDate >=toTimestamp(\"2013-07-01\", \"yyyy-MM-dd\", 0)  AND EventDate <= toTimestamp(\"2013-07-31\", \"yyyy-MM-dd\", 0) AND IsRefresh = 0 and （TraficSourceID=-1 OR TraficSourceID=6 ） and RefererHash = 3594120000172545465 | stats count() as cnt by URLHash, EventDate | sort 1011 by cnt desc | limit 11,1000
search2 repo=\"hits_events\" | where CounterID=62 AND EventDate >=toTimestamp(\"2013-07-01\", \"yyyy-MM-dd\", 0)  AND EventDate <= toTimestamp(\"2013-07-31\", \"yyyy-MM-dd\", 0) AND IsRefresh = 0 and DontCountHits = 0 and URLHash = 2868770270353813622 | stats count() as cnt by WindowClientWidth, WindowClientHeight | sort 1011 by cnt desc | limit 11,1000
search2 repo=\"hits_events\" | where CounterID=62 AND EventDate >=toTimestamp(\"2013-07-14\", \"yyyy-MM-dd\", 0)  AND EventDate <= toTimestamp(\"2013-07-15\", \"yyyy-MM-dd\", 0) AND IsRefresh = 0 and DontCountHits = 0 | eval m= toReadableTime(toTimestamp(EventTime, \"yyyy-MM-dd HH:mm:ss\",0), \"yyyy-MM-dd HH:mm\") | stats count() as cnt by m