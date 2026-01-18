# Team Directory

A full-stack employee directory application built with **ColdFusion** (backend) and **React** (frontend).

## Features

- View all employees in a searchable, sortable table
- Add new employees
- Edit existing employee details
- Delete employees
- Real-time search filtering by name or role
- Responsive, modern UI design

---

## Tech Stack

| Layer    | Technology           |
|----------|----------------------|
| Frontend | React 18, Vite       |
| Backend  | ColdFusion 2021      |
| Database | SQL Script    |
| Styling  | Custom CSS           |

---

## Project Structure

```
team-directory/
├── README.md
├── employees.sql          # SQL reference file (100 employee records)
├── backend/
│   ├── Application.cfc    # ColdFusion app configuration
│   ├── api.cfm            # REST API endpoint
│   └── data/
│       └── employees.json # Data storage file
└── frontend/
    ├── package.json
    ├── vite.config.js
    └── src/
        ├── main.jsx       # App entry point
        ├── App.jsx        # Main component
        ├── App.css        # Styles
        ├── services/
        │   └── api.js     # API service layer
        ├── hooks/
        │   └── useEmployees.js  # Custom React hook
        └── components/
            ├── EmployeeTable.jsx
            └── EmployeeModal.jsx
```

---

## Prerequisites

- **ColdFusion 2021** (or compatible version) running on port 8500
- **Node.js** (v16 or higher)
- **npm** (v8 or higher)

---

## Setup Instructions

### 1. Backend Setup

1. Place the `team-directory` folder in your ColdFusion webroot:
   ```
   C:\ColdFusion2021\cfusion\wwwroot\team-directory\
   ```

2. The backend is ready to use. The API will automatically create `employees.sql` with initial data on first request.

3. Verify the backend is running:
   ```
   http://localhost:8500/team-directory/backend/api.cfm
   ```

### 2. Frontend Setup

1. Navigate to the frontend directory:
   ```bash
   cd frontend
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Start the development server:
   ```bash
   npm run dev
   ```

4. Open in browser:
   ```
   http://localhost:5173
   ```

### 3. Database Setup (Optional)

The application uses JSON file storage by default. If you want to use a SQL database instead:

1. Open `employees.sql` in your database management tool
2. Execute the script to create the `Employees` table and insert 100 records
3. Configure the datasource in ColdFusion Administrator
4. Update `api.cfm` to use the database connection

---

## API Endpoints

Base URL: `http://localhost:8500/team-directory/backend/api.cfm`

| Method | Endpoint      | Description           | Request Body                     |
|--------|---------------|-----------------------|----------------------------------|
| GET    | `/api.cfm`    | Get all employees     | —                                |
| POST   | `/api.cfm`    | Create new employee   | `{FIRSTNAME, LASTNAME, ROLE}`    |
| PUT    | `/api.cfm?id=X` | Update employee     | `{FIRSTNAME, LASTNAME, ROLE}`    |
| DELETE | `/api.cfm?id=X` | Delete employee     | —                                |

### Example Requests

**Get all employees:**
```bash
curl http://localhost:8500/team-directory/backend/api.cfm
```

**Create employee:**
```bash
curl -X POST http://localhost:8500/team-directory/backend/api.cfm \
  -H "Content-Type: application/json" \
  -d '{"FIRSTNAME":"John","LASTNAME":"Doe","ROLE":"Developer"}'
```

**Update employee:**
```bash
curl -X PUT "http://localhost:8500/team-directory/backend/api.cfm?id=1" \
  -H "Content-Type: application/json" \
  -d '{"FIRSTNAME":"Jane","LASTNAME":"Doe","ROLE":"Senior Developer"}'
```

**Delete employee:**
```bash
curl -X DELETE "http://localhost:8500/team-directory/backend/api.cfm?id=1"
```

---

## Running the Application

1. **Start ColdFusion Server** (if not running)

2. **Start Frontend Development Server:**
   ```bash
   cd frontend
   npm run dev
   ```

3. **Access the Application:**
   - Frontend: http://localhost:5173
   - API: http://localhost:8500/team-directory/backend/api.cfm

---

## Security Features

- Input sanitization to prevent XSS attacks
- Server-side validation with length limits
- Proper HTTP status codes for error handling
- CORS headers configured for cross-origin requests

---

## Build for Production

To build the frontend for production:

```bash
cd frontend
npm run build
```

The built files will be in `frontend/dist/`. Deploy these to your web server.

---

## License

This project is for educational purposes.
