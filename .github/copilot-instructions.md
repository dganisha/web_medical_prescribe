# Copilot Instructions for AI Agents

## Project Overview
- This is a Laravel-based web application for medication prescribing and management in a healthcare context.
- The codebase follows standard Laravel conventions for controllers, models, migrations, services, and repositories.
- Main business logic is in `app/Services/` and `app/Repositories/`.

## Key Components
- **Controllers** (`app/Http/Controllers/`): Handle HTTP requests and responses.
- **Models** (`app/Models/`): Eloquent ORM models for core entities (User, Patient, Medicine, etc.).
- **Migrations** (`database/migrations/`): Define and evolve the database schema. Foreign keys and relationships are explicit.
- **Services** (`app/Services/`): Encapsulate business logic, e.g., `MedicineService.php` for medication operations.
- **Repositories** (`app/Repositories/`): Data access abstraction, e.g., `MedicineRepository.php`.
- **Views** (`resources/views/`): Blade templates for UI, organized by feature (e.g., `medications/`).

## Developer Workflows
- **Run the app locally:**
  - `php artisan serve` (serves on http://localhost:8000)
- **Database migrations:**
  - `php artisan migrate` (apply migrations)
  - `php artisan migrate:rollback` (rollback last batch)
- **Seeding data:**
  - `php artisan db:seed`
- **Testing:**
  - `php artisan test` (runs PHPUnit tests in `tests/`)
- **Queue jobs:**
  - `php artisan queue:work` (for background jobs, see `app/Jobs/`)

## Project-Specific Patterns
- **Service/Repository Pattern:**
  - Business logic is separated from controllers using services and repositories.
  - Example: `MedicineService` uses `MedicineRepository` for data access.
- **Explicit Relationships:**
  - Migrations define foreign keys and cascading rules (see `database/migrations/`).
- **Blade Layouts:**
  - Views use layouts in `resources/views/layouts/` for consistent UI structure.

## Integration Points
- **External dependencies:**
  - Managed via Composer (`composer.json`).
  - Laravel ecosystem packages are preferred.
- **Queue/Jobs:**
  - Long-running/background tasks are implemented as jobs in `app/Jobs/`.

## Conventions
- Stick to PSR-12 coding style and Laravel best practices.
- Use Eloquent relationships for model associations.
- Place new business logic in the appropriate service or repository, not in controllers.
- Add new migrations for schema changes; do not edit existing migration files after production deployment.

## Examples
- To add a new medicine, update `MedicineService.php` and `MedicineRepository.php`, and expose via a controller in `Http/Controllers/`.
- For a new UI page, create a Blade file in `resources/views/` and add a route in `routes/web.php`.

Refer to this file for project-specific guidance before making architectural or workflow changes.