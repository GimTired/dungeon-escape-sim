@echo off
rem 시뮬레이터 빌드: 실제 FinalExamGameCore\player0.c 를 그대로 링크한다. (프로젝트와 같은 /sdl, _CRT_SECURE_NO_WARNINGS)
setlocal
cd /d "%~dp0"
where cl >nul 2>nul || call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat" >nul
if not exist obj mkdir obj
rem 코어는 교수님 최종 업데이트(FinalExam00), P0 자리 전략은 제출 파일(FinalExamGameCore\player0.c)
set CORE=..\FinalExam00
rem optional: set OUT=other.exe (when sim.exe is running), set P0SRC=strategy\player0_v1.c (old version)
if "%OUT%"=="" set OUT=sim.exe
if "%P0SRC%"=="" set P0SRC=..\FinalExamGameCore\player0.c
rem P0 전략 파일은 obj 로 복사해서 컴파일한다: 파일 옆의 옛 player_api.h 대신 /I 로 준 최종 코어 헤더를 쓰게 하려는 것(따옴표 include 는 파일 옆 폴더부터 찾는다)
copy /y "%P0SRC%" obj\p0_build.c >nul
cl /nologo /O2 /W3 /sdl /utf-8 /std:c17 /D_CRT_SECURE_NO_WARNINGS /DNDEBUG /I%CORE% %* /Foobj\ /Fe:%OUT% sim.c opponents.c sim_io.c ^
  %CORE%\game.c %CORE%\snapshot.c %CORE%\display.c obj\p0_build.c %CORE%\player1.c %CORE%\player2.c %CORE%\player3.c %CORE%\player4.c %CORE%\player5.c custom\*.c
