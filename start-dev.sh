#!/bin/bash

echo "Starting CoopPhoenix Development Environment..."
echo

echo "Starting Backend (NestJS)..."
cd backend && npm run start:dev &
BACKEND_PID=$!

echo "Waiting 5 seconds for backend to start..."
sleep 5

echo "Starting Frontend (Next.js)..."
cd ../Project-service && npm run dev &
FRONTEND_PID=$!

echo
echo "Both services are starting..."
echo "Backend: http://localhost:3001"
echo "Frontend: http://localhost:3000"
echo
echo "Press Ctrl+C to stop both services"

# Function to cleanup processes on exit
cleanup() {
    echo "Stopping services..."
    kill $BACKEND_PID 2>/dev/null
    kill $FRONTEND_PID 2>/dev/null
    exit
}

# Trap Ctrl+C
trap cleanup INT

# Wait for processes
wait
