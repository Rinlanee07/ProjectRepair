# Setup Guide - Frontend/Backend Separation

## Overview
This project has been separated into:
- **Frontend**: Next.js (Project-service folder) - Pure frontend, no database access
- **Backend**: NestJS (backend folder) - Complete backend with database, auth, business logic

## Prerequisites
- Node.js 18+
- PostgreSQL database
- npm or yarn

## Backend Setup

### 1. Navigate to backend directory
```bash
cd backend
```

### 2. Install dependencies
```bash
npm install
```

### 3. Environment Variables
Create `.env` file in backend directory:
```env
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/coopphoenix?schema=public"

# JWT Secret
JWT_SECRET=your-jwt-secret-key-here

# Server Configuration
PORT=3001
FRONTEND_URL=http://localhost:3000
```

### 4. Database Setup
```bash
# Generate Prisma client
npx prisma generate

# Run migrations
npx prisma migrate dev

# (Optional) Seed database
npx prisma db seed
```

### 5. Start Backend
```bash
npm run start:dev
```

Backend will run on http://localhost:3001

## Frontend Setup

### 1. Navigate to frontend directory
```bash
cd Project-service
```

### 2. Install dependencies
```bash
npm install
```

### 3. Environment Variables
Create `.env.local` file in Project-service directory:
```env
# NextAuth Configuration
NEXTAUTH_URL=http://localhost:3000
NEXTAUTH_SECRET=your-nextauth-secret-key-here

# Backend API URL
NEXT_PUBLIC_API_URL=http://localhost:3001/api
```

### 4. Start Frontend
```bash
npm run dev
```

Frontend will run on http://localhost:3000

## API Endpoints

### Backend API (http://localhost:3001/api)

#### Authentication
- `POST /auth/login` - User login
- `POST /auth/register` - User registration
- `GET /auth/profile` - Get user profile (requires JWT token)

#### Repairs
- `GET /repairs` - Get repair requests (with optional date filters)
- `GET /repairs/:id` - Get specific repair request
- `POST /repairs` - Create new repair request
- `PATCH /repairs/:id/status` - Update repair status
- `POST /repairs/:id/close` - Close repair
- `POST /repairs/:id/shipping` - Add shipping information

#### Upload
- `POST /upload` - Upload file (requires JWT token)

## Security Features

### Backend
- JWT authentication
- CORS enabled for frontend
- Role-based access control
- File upload validation
- Input validation

### Frontend
- NextAuth.js for session management
- API client with error handling
- No direct database access
- Secure token storage

## Development Workflow

1. Start backend first: `cd backend && npm run start:dev`
2. Start frontend: `cd Project-service && npm run dev`
3. Access application at http://localhost:3000

## Production Deployment

### Backend
- Deploy to your preferred platform (Vercel, Railway, Heroku, etc.)
- Set environment variables
- Ensure database is accessible

### Frontend
- Deploy to Vercel, Netlify, or similar
- Update `NEXT_PUBLIC_API_URL` to production backend URL
- Update `NEXTAUTH_URL` to production frontend URL

## Troubleshooting

### Common Issues

1. **CORS errors**: Ensure `FRONTEND_URL` in backend matches your frontend URL
2. **Database connection**: Check `DATABASE_URL` format and database accessibility
3. **JWT errors**: Ensure `JWT_SECRET` is set and consistent
4. **File upload issues**: Check file size limits and allowed types

### Logs
- Backend logs: Check terminal where backend is running
- Frontend logs: Check browser console and terminal
