@echo off

setlocal ENABLEDELAYEDEXPANSION

:: set up a counter

set cnt=1

:: change directory to the location where CSV data files are stored

cd "C:\FTP\data"

:: for each of the CSV files found in this location except the first one, remove the header, and append the data to a new file called output.tmp

for %%i in (*.csv) do (
  if !cnt!==1 (
    for /f "delims=" %%j in ('type "%%i"') do echo %%j >> output.tmp
  ) else (
    for /f "skip=1 delims=" %%j in ('type "%%i"') do echo %%j >> output.tmp
  )
  set /a cnt+=1
)

:: get the current system time

setlocal

set hr=%time:~0,2%
if "%hr:~0,1%" equ " " set hr=0%hr:~1,1%

:: rename the output.tmp file to a MERGED_<date time stamp>.csv

ren output.tmp MERGED_%date:~-4,4%-%date:~-10,2%-%date:~-7,2%_%hr%-%time:~3,2%-%time:~6,2%.csv

:: move the merged file to a folder one level below, called 'merged'

move MERGED_*.csv C:\FTP\data\merged

:: move the individual CSV files to a  folder called C:\FTP\data\backup

move DAT_*.csv C:\FTP\data\backup