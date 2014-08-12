import System.Locale
import System.Environment
import Data.Time
import Data.Time.Format
import Data.Time.Calendar
import Data.List
import MayanCal

--The script takes one command line argument, a day formatted like "21 Dec 2012", and returns the Mayan long count, haab, and cholqij dates as a string.
main = do
    args <- getArgs
    --date <- getCurrentTime >>= return . countOfDays . modJDToJD . toModifiedJulianDay . utctDay
    let datetime = readTime defaultTimeLocale "%d %b %Y" (args!!0) :: UTCTime
    let date = countOfDays . modJDToJD . toModifiedJulianDay . utctDay $ datetime
    putStrLn date