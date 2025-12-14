@echo off
echo Starting CoopPhoenix Development Environment...
echo.

echo Starting Backend (NestJS)...
start "Backend" cmd /k "cd backend && npm run start:dev"

echo Waiting 5 seconds for backend to start...
timeout /t 5 /nobreak > nul

echo Starting Frontend (Next.js)...
start "Frontend" cmd /k "cd Project-service && npm run dev"

echo.
echo Both services are starting...
echo Backend: http://localhost:3001
echo Frontend: http://localhost:3000
echo.
pause
