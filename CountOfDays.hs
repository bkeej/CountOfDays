import System.Locale
import System.Environment
import Data.Time
import Data.Time.Format
import Data.Time.Calendar
import Data.List
import MayanCal

main = do
    args <- getArgs
    --date <- getCurrentTime >>= return . countOfDays . modJDToJD . toModifiedJulianDay . utctDay
    let datetime = readTime defaultTimeLocale "%d %b %Y" (args!!0) :: UTCTime
    let date = countOfDays . modJDToJD . toModifiedJulianDay . utctDay $ datetime
    putStrLn date