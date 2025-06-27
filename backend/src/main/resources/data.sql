-- Insert sample users (avoid duplicates with NOT EXISTS)
INSERT INTO users (user_name, user_email, user_password, user_role)
SELECT * FROM (VALUES
    ('Admin User', 'admin@shop.com', 'password', 'ADMIN'),
    ('John Mechanic', 'john@shop.com', 'password', 'MECHANIC'),
    ('Jane Mechanic', 'jane@shop.com', 'password', 'MECHANIC')
) AS data(user_name, user_email, user_password, user_role)
WHERE NOT EXISTS (SELECT 1 FROM users);

-- Insert mechanic schedules
INSERT INTO mechanic_schedule (user_id, schedule_date, schedule_is_working)
SELECT * FROM (VALUES
    (2, CURRENT_DATE, true),  -- John working today
    (3, CURRENT_DATE, true),  -- Jane working today
    (2, CURRENT_DATE + INTERVAL '1 day', true),  -- John working tomorrow
    (3, CURRENT_DATE + INTERVAL '1 day', false)  -- Jane OFF tomorrow
) AS data(user_id, schedule_date, schedule_is_working)
WHERE NOT EXISTS (SELECT 1 FROM mechanic_schedule);

-- Insert shop closures (recurring Sundays + holidays)
INSERT INTO shop_closure (closure_date, closure_reason, closure_is_recurring)
SELECT * FROM (VALUES
    (DATE_TRUNC('week', CURRENT_DATE) + INTERVAL '6 days', 'Sunday closure', true),
    ('2023-12-25', 'Christmas Day', false)
) AS data(closure_date, closure_reason, closure_is_recurring)
WHERE NOT EXISTS (SELECT 1 FROM shop_closure);

-- Insert sample appointments
INSERT INTO appointment (appointment_date, appointment_start_time, appointment_is_waiting, appointment_num_slots, appointment_job_description, appointment_status, appointment_vehicle_info, user_id)
SELECT * FROM (VALUES
    (CURRENT_DATE, TIME '09:00:00', true, 1, 'Oil change', 'SCHEDULED', 'Honda Accord - ABC123', 1),
    (CURRENT_DATE, NULL, false, 2, 'Brake repair + inspection', 'SCHEDULED', 'Ford F150 - XYZ789', 2),
    (CURRENT_DATE + INTERVAL '1 day', TIME '10:30:00', true, 1, 'A/C recharge', 'SCHEDULED', 'Toyota Camry - DEF456', 1)
) AS data(appointment_date, appointment_start_time, appointment_is_waiting, appointment_num_slots, appointment_job_description, appointment_status, appointment_vehicle_info, user_id)
WHERE NOT EXISTS (SELECT 1 FROM appointment);