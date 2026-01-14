# Medication Prescribing Web

## Description

This Application is Medication Prescibing

Technology Using:

- Laravel 12
- PHP 8.2 or newest
- PostgreSQL
- CDN Bootstrap (must have internet connection)

## Installation

1) Install dependencies
```bash
composer install
npm install
```

2) Create environment file
```bash
cp .env.example .env
```

3) Generate app key
```bash
php artisan key:generate
```

4) Configure Environment

Copy `.env.example` to `.env`

Please configuration `database`

Please Configuration API 
```bash
API_BASE_URL=http://url-your-api.com/api/v1
API_USERNAME=dhiemasganisha9a@gmail.com
API_PASSWORD=087898292270
```

5) Restore Database

You can restore database from my local database from `/database/database_dump.sql`, this restore will fill the table and all data. And you can skip step 5 and 6.

5) Run migrations (optional)
```bash
php artisan migrate
```

6) Seed sample data (optional)
```bash
php artisan db:seed
```

7) Build assets
```bash
npm run build
```

8) Run the app
```bash
php artisan serve
```

Optional: if using file uploads, create storage symlink:
```bash
php artisan storage:link
```

## Seeder Credentials

- Administrator
  - Email: `admin@example.com`
  - Password: `password`
- Dokter
  - Email: `dokter@example.com`
  - Password: `password`
- Apoteker
  - Email: `apoteker@example.com`
  - Password: `password`
- Pendaftaran
  - Email: `pendaftaran@example.com`
  - Password: `password`

## Application Flow

### Registration (Pendaftaran)
1) Open Registration Queue (`/registrations`).
2) Type patient name. If not found, click "Tambah Pasien Baru" and fill patient details.
3) Register visit. Status becomes `waiting_doctor`.

### Doctor (Dokter)
1) Open Checkups (`/doctor/checkups`).
2) Create checkup by selecting Visit Queue.
3) Fill vitals, diagnosis, and prescription items.
4) Status becomes `waiting_pharmacy`.

### Pharmacy (Apoteker)
1) Open Pharmacy Queue (`/pharmacy`).
2) Serve pending prescription.
3) Download receipt PDF. Status becomes `completed`.

### Administrator
1) Open Admin Dashboard (`/admin`).
2) Manage users (including Dokter, Apoteker, Pendaftaran).
3) Manage patients, medications, roles, and view medical history.
4) Can Synchronize Medicine from BASE API (`must be filled API Connection in environment`)

## Activity Logs

All process actions are stored in `activity_logs` table:
- login/logout
- registration (patient created, visit created)
- doctor checkup create/update
- pharmacy serve + receipt download
- admin user create/update/toggle
- patient create/update
- medicines synchronization

##

## Thankyou
