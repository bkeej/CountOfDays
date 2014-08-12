module MayanCal
( modJDToJD
, countOfDays
, jdToLongCount
, longcount
, baktun
, katun
, tun
, uinal
, kin
, jdToHaab
, haab
, hmonth
, hday
, jdToCholqij
, cholqij
, cmonth
, cday
) where

modJDToJD :: Fractional a => Integer -> a
modJDToJD mjd = (fromInteger mjd) + 2400000.5

--modified julian = julian - 2400000.5

--Take a Julian Day and return a string giving the "longcount, haab-number haab-month, cholqij-number cholqij-month".
countOfDays :: RealFrac a => a -> [Char]
countOfDays jd = (longcount jd) ++ ", " ++ (haab jd) ++ ", " ++ (cholqij jd)

epoch = 584282.5
--The number of days elapsed since the start of the longcount (relative to Julian Day)

--converts mayan long count to julian day

longCountToJD baktun katun tun uinal kin = kin + (uinal * 20) + (tun * 360) + (katun * 7200) + (baktun * 144000) + epoch

--converts julian day to mayan long count stored in a list
jdToLongCount :: RealFrac a => a -> [Int]
jdToLongCount jd = [baktun d, katun d, tun d, uinal d, kin d]
    where d = (floor jd) - (floor epoch)

--coverts julian day to long count string
longcount :: RealFrac a => a -> [Char]
longcount jd = show ((jdToLongCount jd)!!0) ++ "." ++ show ((jdToLongCount jd)!!1) ++ "." ++ show ((jdToLongCount jd)!!2) ++ "." ++ show ((jdToLongCount jd)!!3) ++ "." ++ show ((jdToLongCount jd)!!4)

--partially saturated mod functions good for doing base 20 calendar arthmetic
mod20 = flip mod 20
mod360 = flip mod 360
mod7200 = flip mod 7200
mod144000 = flip mod 144000


--functions taking julian days to baktuns, katuns, etc.
baktun :: Int -> Int
baktun jd = floor (toRational (jd `div` 144000))

katun :: Int -> Int
katun jd = floor (toRational ((mod144000 jd) `div` 7200))

tun :: Int -> Int
tun jd = floor (toRational (((mod7200 . mod144000) jd) `div` 360))

uinal :: Int -> Int
uinal jd = floor (toRational (((mod360 . mod7200 . mod144000) jd) `div` 20))

kin :: Int -> Int
kin jd = (mod20 . mod360 . mod7200 . mod144000) jd


--calculate the haab number and haab month from julian day
jdToHaab :: (RealFrac a, Integral t) => a -> [t]
jdToHaab jd = [hday jd, hmonth jd]


--takes a julian day and gives the haab number and haab month in string
haab :: RealFrac a => a -> [Char]
haab jd = show ((jdToHaab jd)!!0) ++ " " ++ themonths!!(((jdToHaab jd)!!1)-1)

hmonth :: (RealFrac a, Integral a1) => a -> a1
hmonth jd = (floor (toRational (x `div` 20))) + 1
    where x = ((floor jd) - (floor epoch) + 8 + ((18 - 1) * 20)) `mod` 365

--We allow haab days to be 0, which were usually written with a special glyph called the 'seating of the haab'.
hday :: (RealFrac a, Integral a1) => a -> a1
hday jd = x `mod` 20
    where x = ((floor jd) - (floor epoch) + 8 + ((18 - 1) * 20)) `mod` 365


--calculate the cholqij day from the julian day
jdToCholqij :: (RealFrac a, Integral t) => a -> [t]
jdToCholqij jd = [cday jd, cmonth jd]


--takes a julian day and gives the cholqij number and cholqij day in string
cholqij :: RealFrac a => a -> [Char]
cholqij jd = show ((jdToCholqij jd)!!0) ++ " " ++ thedays!!((jdToCholqij jd)!!1)

cmonth :: (RealFrac a, Integral a1) => a -> a1
cmonth jd = abs((x + 19) `mod` 20)
    where x = (floor jd) - (floor epoch)

--Cholqij days are not allowed to be 0. Instead, 0 days are set to 13.
cday :: (RealFrac a, Integral a1) => a -> a1
cday jd
    | abs((x+4) `mod` 13) == 0 = 13
    | otherwise = abs((x+4) `mod` 13)
    where x = ((floor jd) - (floor epoch))

--haab months in reconstructed classical mayan
themonths = ["Pop", "Wo'", "Sip", "Sotz'", "Tzek", "Xul", "Yaxk'in'", "Mol", "Ch'en", "Yax", "Sak'", "Keh", "Mak", "K'ank'in", "Muwan'", "Pax", "K'ayab", "Kumk'u", "Wayeb'"]

--cholqij days in Kaqchikel
thedays = ["Imox", "Iq'", "Aq'ab'al", "K'at", "Kan", "Kamey", "Kej", "Q'anil", "Toj", "Tz'i'", "B'atz'", "Ey", "Aj", "Ix", "Tz'ikin", "Ajmaq", "No'j", "Tijax", "Kawoq", "Ajpu"]
