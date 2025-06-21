# 📌 Project Title:
### ShopScheduler – Auto Repair Scheduling & Job Management Tool

## 🧠 Purpose:
ShopScheduler is a scheduling platform tailored to the real-world workflow of auto repair shops. It simplifies booking management, mechanic availability tracking, and day-to-day job flow coordination. The system supports a range of user roles, provides real-time slot visibility, and helps prevent double-bookings — while allowing mechanic/admin overrides for flexibility.

## 🎯 Objectives:
- Provide a monthly calendar with visible slot availability.
- Allow gas attendants to book simple jobs (oil changes, inspections, etc.).
- Let mechanics/admins schedule complex, multi-slot jobs.
- Dynamically calculate daily slot availability based on working mechanics.
- Prevent overbooking with real-time validation and lock mechanisms.
- Enable check-in tracking for customer vehicles.
- Offer printable daily job sheets.
- Support CRUD operations for all appointments.
- Allow days to be marked as shop closed.
- Allow admin/mechanic override of slot limits when necessary.

## 👥 User Roles & Permissions:
### Role	Capabilities
Gas Attendant:	Create basic jobs (1 slot), choose from predefined services, no overrides
Mechanic:	Create/edit any job, override slot rules, check-in vehicles
Admin	Full access: manage jobs, mechanics, closures, override limits

Role-based controls are enforced on the frontend through permission checks.

## 🗓️ Key Features:
### ✅ Dynamic Monthly Calendar
Shows all days in the current month

### Highlights:
- Current day
- Closed days
- Slot availability (remaining capacity based on mechanics working)

### 🔧 Job Scheduling
Job Description: Free-text field (e.g., “Oil + Inspection”)

Slot Count: Assigned per appointment

Gas attendants limited to 1 slot

Mechanics/Admins can assign multiple

Waiters: Optional wait status + start time

Max 1 per hour

Override Mode: Admins/mechanics can bypass slot caps with warning popup

### 👷 Mechanic Availability
Default: All mechanics working per weekday

MechanicSchedule tracks days off

Slot capacity per day = Number of mechanics working * # of jobs mechanic can be assigned

### ❌ Shop Closures
Default closed days: Sundays

Admins can mark other days (e.g., holidays, vacation)

These days are blocked from all bookings unless overridden

### 📋 Check-In & Job Sheet
Track appointment check-in with timestamps

Print-friendly view of the day’s jobs

Ordered by time

Shows description, vehicle, status, wait flag

### 🔁 Real-Time Access & Slot Control
Slot usage = sum of num_slots per day

Locking mechanisms or transaction control prevent double-booking

Flag overbooked jobs using an is_override boolean field

## 🧱 Database Design Summary (ERD)
Entity	Key Fields
User	id, name, role (ADMIN, MECHANIC, GAS_KID)
Appointment	id, date, num_slots, job_description, is_waiting_customer, start_time, status, vehicle, user_id, is_override
MechanicSchedule	id, user_id, date, is_off
ShopClosure	id, date, reason, is_recurring

See ERD diagram for full schema structure.

## ⚙️ Technology Stack
Frontend: React, React Query, Context API/Auth
Backend: Spring Boot, Spring Data JPA, PostgreSQL
Real-Time: WebSocket
Printing: HTML print stylesheet or jsPDF
Auth (optional): Spring Security or Firebase Auth

## ✅ Success Criteria
Calendar view correctly shows remaining slots and closures

Users restricted by role on job creation

Double-booking prevented under normal flow

Jobs can be overridden if necessary (with flag)

Daily job sheet printable and accurate

Minimal training required for front-desk users

