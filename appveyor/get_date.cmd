@ECHO OFF
:: This script is based on https://ss64.com/nt/syntax-getdate.html
:: Modified to return only the ISO 8601 date (without time)

:: Use WMIC to retrieve date and time
for /F "skip=1 tokens=1-6" %%G in ('wmic path win32_utctime get Day^,Hour^,Minute^,Month^,Second^,Year /format:table') do (
  if "%%~L"=="" goto s_done
    set _yyyy=%%L
    set _mm=00%%J
    set _dd=00%%G
)
:s_done

:: Pad digits with leading zeros
set _mm=%_mm:~-2%
set _dd=%_dd:~-2%

:: Display the date/time in ISO 8601 format
set _isodate=%_yyyy%-%_mm%-%_dd%
echo %_isodate%
