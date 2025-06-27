-- Corrected drop order (child tables first)
DROP TABLE IF EXISTS appointment CASCADE;
DROP TABLE IF EXISTS mechanic_schedule CASCADE;
DROP TABLE IF EXISTS enrollment CASCADE;  -- If this table exists
DROP TABLE IF EXISTS course CASCADE;      -- If this table exists
DROP TABLE IF EXISTS shop_closure CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- Create tables
CREATE TABLE IF NOT EXISTS users (
    user_id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    user_email VARCHAR(100) UNIQUE NOT NULL,
    user_password VARCHAR(100),
    user_role VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS mechanic_schedule (
    schedule_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id),
    schedule_date DATE NOT NULL,
    schedule_note TEXT,
    schedule_is_working BOOLEAN DEFAULT false,
);

CREATE TABLE IF NOT EXISTS shop_closure (
    closure_id SERIAL PRIMARY KEY,
    closure_date DATE UNIQUE NOT NULL,
    closure_reason TEXT,
    closure_is_recurring BOOLEAN DEFAULT false
);

CREATE TABLE IF NOT EXISTS appointment (
    appointment_id SERIAL PRIMARY KEY,
    appointment_date DATE NOT NULL,
    appointment_start_time TIME,
    appointment_is_waiting BOOLEAN DEFAULT false,
    appointment_num_slots INTEGER NOT NULL CHECK (appointment_num_slots > 0),
    appointment_job_description TEXT NOT NULL,
    appointment_status VARCHAR(20) DEFAULT 'SCHEDULED',
    appointment_vehicle_info TEXT,
    appointment_is_override BOOLEAN DEFAULT false,
    user_id INTEGER REFERENCES users(user_id)
);