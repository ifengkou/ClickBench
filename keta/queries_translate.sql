SELECT COUNT(*) FROM hits;
search2 repo="hits_events" | stats count()
SELECT COUNT(*) FROM hits WHERE AdvEngineID <> 0;
search2 repo="hits_events" | where  AdvEngineID != 0 | stats count()
SELECT SUM(AdvEngineID), COUNT(*), AVG(ResolutionWidth) FROM hits;
search2 repo="hits_events" |stats sum(AdvEngineID) as sum_avde, count(),avg(ResolutionWidth)
SELECT AVG(UserID) FROM hits;
search2 repo="hits_events" |stats avg(UserID)
SELECT COUNT(DISTINCT UserID) FROM hits;
search2 repo="hits_events" |stats distinct_count(UserID)
SELECT COUNT(DISTINCT SearchPhrase) FROM hits;
search2 repo="hits_events" |stats distinct_count(SearchPhrase)

SELECT MIN(EventDate), MAX(EventDate) FROM hits;
search2 repo="hits_events" |stats MIN(EventDate),MAX(EventDate)


SELECT AdvEngineID, COUNT(*) FROM hits WHERE AdvEngineID <> 0 GROUP BY AdvEngineID ORDER BY COUNT(*) DESC;
search2 repo="hits_events" | where AdvEngineID!=0 | stats  count() as cnt  by AdvEngineID | sort by cnt desc

SELECT RegionID, COUNT(DISTINCT UserID) AS u FROM hits GROUP BY RegionID ORDER BY u DESC LIMIT 10;
search2 repo="hits_events" |  stats  distinct_count(UserID) as cnt  by RegionID | sort 10 by cnt desc

SELECT RegionID, SUM(AdvEngineID), COUNT(*) AS c, AVG(ResolutionWidth), COUNT(DISTINCT UserID) FROM hits GROUP BY RegionID ORDER BY c DESC LIMIT 10;
search2 repo="hits_events" |  stats  sum(AdvEngineID),count() as cnt, avg(ResolutionWidth), distinct_count(UserID) by RegionID | sort 10 by cnt desc


SELECT MobilePhoneModel, COUNT(DISTINCT UserID) AS u FROM hits WHERE MobilePhoneModel <> '' GROUP BY MobilePhoneModel ORDER BY u DESC LIMIT 10;
search2 repo="hits_events" |where MobilePhoneModel !="" |  stats distinct_count(UserID) as u by MobilePhoneModel | sort 10 by u desc


SELECT MobilePhone, MobilePhoneModel, COUNT(DISTINCT UserID) AS u FROM hits WHERE MobilePhoneModel <> '' GROUP BY MobilePhone, MobilePhoneModel ORDER BY u DESC LIMIT 10;
search2 repo="hits_events" |where MobilePhoneModel !="" |  stats distinct_count(UserID) as u by MobilePhone, MobilePhoneModel | sort 10 by u desc


SELECT SearchPhrase, COUNT(*) AS c FROM hits WHERE SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY c DESC LIMIT 10;
search2 repo="hits_events" |where SearchPhrase !="" |  stats count() as cnt by SearchPhrase | sort 10 by cnt desc


SELECT SearchPhrase, COUNT(DISTINCT UserID) AS u FROM hits WHERE SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY u DESC LIMIT 10;
search2 repo="hits_events" |where SearchPhrase !="" |  stats distinct_count(UserID) as cnt by SearchPhrase | sort 10 by cnt desc


SELECT SearchEngineID, SearchPhrase, COUNT(*) AS c FROM hits WHERE SearchPhrase <> '' GROUP BY SearchEngineID, SearchPhrase ORDER BY c DESC LIMIT 10;
search2 repo="hits_events" |where SearchPhrase !="" |  stats count() as cnt by SearchEngineID,SearchPhrase | sort 10 by cnt desc


SELECT UserID, COUNT(*) FROM hits GROUP BY UserID ORDER BY COUNT(*) DESC LIMIT 10;
search2 repo="hits_events" |  stats count() as cnt by UserID | sort 10 by cnt desc


SELECT UserID, SearchPhrase, COUNT(*) FROM hits GROUP BY UserID, SearchPhrase ORDER BY COUNT(*) DESC LIMIT 10;
search2 repo="hits_events" |  stats count() as cnt by UserID,SearchPhrase | sort 10 by cnt desc


SELECT UserID, SearchPhrase, COUNT(*) FROM hits GROUP BY UserID, SearchPhrase LIMIT 10;
search2 repo="hits_events" |  stats count() as cnt by UserID,SearchPhrase | limit 10


SELECT UserID, extract(minute FROM EventTime) AS m, SearchPhrase, COUNT(*) FROM hits GROUP BY UserID, m, SearchPhrase ORDER BY COUNT(*) DESC LIMIT 10;
search2 repo="hits_events" | eval m=minute(EventTime) |  stats count() as cnt by UserID,m,SearchPhrase | sort 10 by cnt desc


SELECT UserID FROM hits WHERE UserID = 435090932899640449;
search2 repo="hits_events" | where UserID !=435090932899640449 | fields UserID

SELECT COUNT(*) FROM hits WHERE URL LIKE '%google%';
search2 repo="hits_events" | where URL like "%google%" | stats count()

SELECT SearchPhrase, MIN(URL), COUNT(*) AS c FROM hits WHERE URL LIKE '%google%' AND SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY c DESC LIMIT 10;
search2 repo="hits_events" | where URL like "%google%" and SearchPhrase !="" | eval l= len(URL) | stats count() as cnt ,min(l) by SearchPhrase | sort 10 by cnt desc


SELECT SearchPhrase, MIN(URL), MIN(Title), COUNT(*) AS c, COUNT(DISTINCT UserID) FROM hits WHERE Title LIKE '%Google%' AND URL NOT LIKE '%.google.%' AND SearchPhrase <> '' GROUP BY SearchPhrase ORDER BY c DESC LIMIT 10;

--Failed to fetch
search2 repo="hits_events" | where Title like "%google%" and URL not like "%google%" and SearchPhrase !="" | eval l= len(URL) , t = len(Title) | stats count() as cnt ,distinct_count(UserID),min(l),min(t) by SearchPhrase | sort 10 by cnt desc

SELECT * FROM hits WHERE URL LIKE '%google%' ORDER BY EventTime LIMIT 10;
search2 repo="hits_events" | where URL like "%google%" | sort 10 by EventTime asc

SELECT SearchPhrase FROM hits WHERE SearchPhrase <> '' ORDER BY EventTime LIMIT 10;
search2 repo="hits_events" | where SearchPhrase != "" | sort 10 by EventTime asc

SELECT SearchPhrase FROM hits WHERE SearchPhrase <> '' ORDER BY SearchPhrase LIMIT 10;
search2 repo="hits_events" | where SearchPhrase != "" |fields SearchPhrase  | sort 10 by SearchPhrase asc

SELECT SearchPhrase FROM hits WHERE SearchPhrase <> '' ORDER BY EventTime, SearchPhrase LIMIT 10;
search2 repo="hits_events" | where SearchPhrase != ""  | sort 10 by EventTime asc, SearchPhrase


SELECT CounterID, AVG(length(URL)) AS l, COUNT(*) AS c FROM hits WHERE URL <> '' GROUP BY CounterID HAVING COUNT(*) > 100000 ORDER BY l DESC LIMIT 25;
search2 repo="hits_events" | where URL != ""  | stats count() as cnt, avg(len(URL)) as l by CounterID | where cnt > 100000 |sort 25 by l desc

SELECT REGEXP_REPLACE(Referer, '^https?://(?:www\.)?([^/]+)/.*$', '\\1') AS k, AVG(length(Referer)) AS l, COUNT(*) AS c, MIN(Referer) FROM hits WHERE Referer <> '' GROUP BY k HAVING COUNT(*) > 100000 ORDER BY l DESC LIMIT 25;
-- replace search2 正则失败, search 支持 
search repo="hits_events" | eval k= replace(Referer,"^https?://(?:www\.)?([^/]+)/.*$","$1") , ln=len(Referer) | stats count() as cnt, avg(ln) as l ,min(ln) by k | where cnt > 100000 |sort 25 by l desc

SELECT SUM(ResolutionWidth), SUM(ResolutionWidth + 1), SUM(ResolutionWidth + 2), SUM(ResolutionWidth + 3), SUM(ResolutionWidth + 4), SUM(ResolutionWidth + 5), SUM(ResolutionWidth + 6), SUM(ResolutionWidth + 7), SUM(ResolutionWidth + 8), SUM(ResolutionWidth + 9), SUM(ResolutionWidth + 10), SUM(ResolutionWidth + 11), SUM(ResolutionWidth + 12), SUM(ResolutionWidth + 13), SUM(ResolutionWidth + 14), SUM(ResolutionWidth + 15), SUM(ResolutionWidth + 16), SUM(ResolutionWidth + 17), SUM(ResolutionWidth + 18), SUM(ResolutionWidth + 19), SUM(ResolutionWidth + 20), SUM(ResolutionWidth + 21), SUM(ResolutionWidth + 22), SUM(ResolutionWidth + 23), SUM(ResolutionWidth + 24), SUM(ResolutionWidth + 25), SUM(ResolutionWidth + 26), SUM(ResolutionWidth + 27), SUM(ResolutionWidth + 28), SUM(ResolutionWidth + 29), SUM(ResolutionWidth + 30), SUM(ResolutionWidth + 31), SUM(ResolutionWidth + 32), SUM(ResolutionWidth + 33), SUM(ResolutionWidth + 34), SUM(ResolutionWidth + 35), SUM(ResolutionWidth + 36), SUM(ResolutionWidth + 37), SUM(ResolutionWidth + 38), SUM(ResolutionWidth + 39), SUM(ResolutionWidth + 40), SUM(ResolutionWidth + 41), SUM(ResolutionWidth + 42), SUM(ResolutionWidth + 43), SUM(ResolutionWidth + 44), SUM(ResolutionWidth + 45), SUM(ResolutionWidth + 46), SUM(ResolutionWidth + 47), SUM(ResolutionWidth + 48), SUM(ResolutionWidth + 49), SUM(ResolutionWidth + 50), SUM(ResolutionWidth + 51), SUM(ResolutionWidth + 52), SUM(ResolutionWidth + 53), SUM(ResolutionWidth + 54), SUM(ResolutionWidth + 55), SUM(ResolutionWidth + 56), SUM(ResolutionWidth + 57), SUM(ResolutionWidth + 58), SUM(ResolutionWidth + 59), SUM(ResolutionWidth + 60), SUM(ResolutionWidth + 61), SUM(ResolutionWidth + 62), SUM(ResolutionWidth + 63), SUM(ResolutionWidth + 64), SUM(ResolutionWidth + 65), SUM(ResolutionWidth + 66), SUM(ResolutionWidth + 67), SUM(ResolutionWidth + 68), SUM(ResolutionWidth + 69), SUM(ResolutionWidth + 70), SUM(ResolutionWidth + 71), SUM(ResolutionWidth + 72), SUM(ResolutionWidth + 73), SUM(ResolutionWidth + 74), SUM(ResolutionWidth + 75), SUM(ResolutionWidth + 76), SUM(ResolutionWidth + 77), SUM(ResolutionWidth + 78), SUM(ResolutionWidth + 79), SUM(ResolutionWidth + 80), SUM(ResolutionWidth + 81), SUM(ResolutionWidth + 82), SUM(ResolutionWidth + 83), SUM(ResolutionWidth + 84), SUM(ResolutionWidth + 85), SUM(ResolutionWidth + 86), SUM(ResolutionWidth + 87), SUM(ResolutionWidth + 88), SUM(ResolutionWidth + 89) FROM hits;
search2 repo="hits_events"| stats sum(ResolutionWidth), sum(ResolutionWidth + 1), sum(ResolutionWidth + 2), sum(ResolutionWidth + 3), sum(ResolutionWidth + 4), sum(ResolutionWidth + 5), sum(ResolutionWidth + 6), sum(ResolutionWidth + 7), sum(ResolutionWidth + 8), sum(ResolutionWidth + 9), sum(ResolutionWidth + 10), sum(ResolutionWidth + 11), sum(ResolutionWidth + 12), sum(ResolutionWidth + 13), sum(ResolutionWidth + 14), sum(ResolutionWidth + 15), sum(ResolutionWidth + 16), sum(ResolutionWidth + 17), sum(ResolutionWidth + 18), sum(ResolutionWidth + 19), sum(ResolutionWidth + 20), sum(ResolutionWidth + 21), sum(ResolutionWidth + 22), sum(ResolutionWidth + 23), sum(ResolutionWidth + 24), sum(ResolutionWidth + 25), sum(ResolutionWidth + 26), sum(ResolutionWidth + 27), sum(ResolutionWidth + 28), sum(ResolutionWidth + 29), sum(ResolutionWidth + 30), sum(ResolutionWidth + 31), sum(ResolutionWidth + 32), sum(ResolutionWidth + 33), sum(ResolutionWidth + 34), sum(ResolutionWidth + 35), sum(ResolutionWidth + 36), sum(ResolutionWidth + 37), sum(ResolutionWidth + 38), sum(ResolutionWidth + 39), sum(ResolutionWidth + 40), sum(ResolutionWidth + 41), sum(ResolutionWidth + 42), sum(ResolutionWidth + 43), sum(ResolutionWidth + 44), sum(ResolutionWidth + 45), sum(ResolutionWidth + 46), sum(ResolutionWidth + 47), sum(ResolutionWidth + 48), sum(ResolutionWidth + 49), sum(ResolutionWidth + 50), sum(ResolutionWidth + 51), sum(ResolutionWidth + 52), sum(ResolutionWidth + 53), sum(ResolutionWidth + 54), sum(ResolutionWidth + 55), sum(ResolutionWidth + 56), sum(ResolutionWidth + 57), sum(ResolutionWidth + 58), sum(ResolutionWidth + 59), sum(ResolutionWidth + 60), sum(ResolutionWidth + 61), sum(ResolutionWidth + 62), sum(ResolutionWidth + 63), sum(ResolutionWidth + 64), sum(ResolutionWidth + 65), sum(ResolutionWidth + 66), sum(ResolutionWidth + 67), sum(ResolutionWidth + 68), sum(ResolutionWidth + 69), sum(ResolutionWidth + 70), sum(ResolutionWidth + 71), sum(ResolutionWidth + 72), sum(ResolutionWidth + 73), sum(ResolutionWidth + 74), sum(ResolutionWidth + 75), sum(ResolutionWidth + 76), sum(ResolutionWidth + 77), sum(ResolutionWidth + 78), sum(ResolutionWidth + 79), sum(ResolutionWidth + 80), sum(ResolutionWidth + 81), sum(ResolutionWidth + 82), sum(ResolutionWidth + 83), sum(ResolutionWidth + 84), sum(ResolutionWidth + 85), sum(ResolutionWidth + 86), sum(ResolutionWidth + 87), sum(ResolutionWidth + 88), sum(ResolutionWidth + 89)

SELECT SearchEngineID, ClientIP, COUNT(*) AS c, SUM(IsRefresh), AVG(ResolutionWidth) FROM hits WHERE SearchPhrase <> '' GROUP BY SearchEngineID, ClientIP ORDER BY c DESC LIMIT 10;
search2 repo="hits_events" | where SearchPhrase!="" | stats count() as cnt ,sum(IsRefresh),avg(ResolutionWidth) by SearchEngineID, ClientIP | sort 10 by cnt desc

SELECT WatchID, ClientIP, COUNT(*) AS c, SUM(IsRefresh), AVG(ResolutionWidth) FROM hits WHERE SearchPhrase <> '' GROUP BY WatchID, ClientIP ORDER BY c DESC LIMIT 10;

search2 repo="hits_events" | where SearchPhrase!="" | stats count() as cnt ,sum(IsRefresh),avg(ResolutionWidth) by WatchID, ClientIP | sort 10 by cnt desc

SELECT WatchID, ClientIP, COUNT(*) AS c, SUM(IsRefresh), AVG(ResolutionWidth) FROM hits GROUP BY WatchID, ClientIP ORDER BY c DESC LIMIT 10;
search2 repo="hits_events" | stats count() as cnt ,sum(IsRefresh),avg(ResolutionWidth) by WatchID, ClientIP | sort 10 by cnt desc

SELECT URL, COUNT(*) AS c FROM hits GROUP BY URL ORDER BY c DESC LIMIT 10;
--Failed to fetch
search2 repo="hits_events" | stats count() as cnt by URL | sort 10 by cnt desc


SELECT 1, URL, COUNT(*) AS c FROM hits GROUP BY 1, URL ORDER BY c DESC LIMIT 10;
--异常：Java heap space
search2 repo="hits_events" |eval x = 1 | stats count() as cnt by x, URL | sort 10 by cnt desc


SELECT ClientIP, ClientIP - 1, ClientIP - 2, ClientIP - 3, COUNT(*) AS c FROM hits GROUP BY ClientIP, ClientIP - 1, ClientIP - 2, ClientIP - 3 ORDER BY c DESC LIMIT 10;
search2 repo="hits_events" |eval cip1 = ClientIP - 1,cip2=ClientIP - 2,cip3=ClientIP - 3 | stats count() as cnt by ClientIP,cip1,cip2,cip3, URL | sort 10 by cnt desc



SELECT URL, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND DontCountHits = 0 AND IsRefresh = 0 AND URL <> '' GROUP BY URL ORDER BY PageViews DESC LIMIT 10;
search2 repo="hits_events" | where CounterID=62  AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND DontCountHits = 0 AND IsRefresh = 0 AND URL !="" | stats count() as cnt by URL | sort 10 by cnt desc

SELECT Title, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND DontCountHits = 0 AND IsRefresh = 0 AND Title <> '' GROUP BY Title ORDER BY PageViews DESC LIMIT 10;
search2 repo="hits_events" | where CounterID=62  AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND DontCountHits = 0 AND IsRefresh = 0 AND Title !="" | stats count() as cnt by Title | sort 10 by cnt desc


SELECT URL, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 AND IsLink <> 0 AND IsDownload = 0 GROUP BY URL ORDER BY PageViews DESC LIMIT 10 OFFSET 1000;
search2 repo="hits_events" | where CounterID=62 AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND IsRefresh = 0 AND IsLink !=0 AND IsDownload =0 | stats count() as cnt by URL | sort 1010 by cnt desc | limit 10,1000

SELECT TraficSourceID, SearchEngineID, AdvEngineID, CASE WHEN (SearchEngineID = 0 AND AdvEngineID = 0) THEN Referer ELSE '' END AS Src, URL AS Dst, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 GROUP BY TraficSourceID, SearchEngineID, AdvEngineID, Src, Dst ORDER BY PageViews DESC LIMIT 10 OFFSET 1000;
search2 repo="hits_events" | where CounterID=62 AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND IsRefresh = 0 | eval Src=case((SearchEngineID = 0 AND AdvEngineID = 0),Referer,""), Dst=URL | stats count() as cnt by TraficSourceID, SearchEngineID, AdvEngineID,Src,Dst | sort 1010 by cnt desc | limit 10,1000

SELECT URLHash, EventDate, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 AND TraficSourceID IN (-1, 6) AND RefererHash = 3594120000172545465 GROUP BY URLHash, EventDate ORDER BY PageViews DESC LIMIT 10 OFFSET 100;
-- in 操作 解析失败
search2 repo="hits_events" | where CounterID=62 AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND IsRefresh = 0 and in(TraficSourceID,[-1, 6]) and RefererHash = 3594120000172545465 | stats count() as cnt by URLHash, EventDate | sort 1010 by cnt desc | limit 10,1000
search2 repo="hits_events" | where CounterID=62 AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND IsRefresh = 0 and TraficSourceID in(-1, 6) and RefererHash = 3594120000172545465 | stats count() as cnt by URLHash, EventDate | sort 1010 by cnt desc | limit 10,1000
-- 改写为 or 执行
search2 repo="hits_events" | where CounterID=62 AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND IsRefresh = 0 and （TraficSourceID=-1 OR TraficSourceID=6 ） and RefererHash = 3594120000172545465 | stats count() as cnt by URLHash, EventDate | sort 1010 by cnt desc | limit 10,1000


SELECT WindowClientWidth, WindowClientHeight, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-01' AND EventDate <= '2013-07-31' AND IsRefresh = 0 AND DontCountHits = 0 AND URLHash = 2868770270353813622 GROUP BY WindowClientWidth, WindowClientHeight ORDER BY PageViews DESC LIMIT 10 OFFSET 10000;

search2 repo="hits_events" | where CounterID=62 AND EventDate >=toTimestamp("2013-07-01", "yyyy-MM-dd")  AND EventDate <= toTimestamp("2013-07-31", "yyyy-MM-dd") AND IsRefresh = 0 and DontCountHits = 0 and URLHash = 2868770270353813622 | stats count() as cnt by WindowClientWidth, WindowClientHeight | sort 1010 by cnt desc | limit 10,1000

SELECT DATE_FORMAT(EventTime, '%Y-%m-%d %H:%i:00') AS M, COUNT(*) AS PageViews FROM hits WHERE CounterID = 62 AND EventDate >= '2013-07-14' AND EventDate <= '2013-07-15' AND IsRefresh = 0 AND DontCountHits = 0 GROUP BY DATE_FORMAT(EventTime, '%Y-%m-%d %H:%i:00') ORDER BY DATE_FORMAT(EventTime, '%Y-%m-%d %H:%i:00') LIMIT 10 OFFSET 1000;

search2 repo="hits_events" | where CounterID=62 AND EventDate >=toTimestamp("2013-07-14", "yyyy-MM-dd", 0)  AND EventDate <= toTimestamp("2013-07-15", "yyyy-MM-dd", 0) AND IsRefresh = 0 and DontCountHits = 0 | eval m= toReadableTime(toTimestamp(EventTime, "yyyy-MM-dd HH:mm:ss"), "yyyy-MM-dd HH:mm") | stats count() as cnt by m