-- Create database
CREATE DATABASE seva_connect;

-- Connect to database
\c seva_connect;

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('customer', 'worker', 'admin')),
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20),
    is_verified BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Worker profiles
CREATE TABLE worker_profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id) ON DELETE CASCADE,
    photo_url TEXT,
    address TEXT,
    city VARCHAR(100),
    pin_code VARCHAR(10),
    skills TEXT[],
    hourly_rate DECIMAL(10,2),
    fixed_rate DECIMAL(10,2),
    description TEXT,
    portfolio_urls TEXT[],
    languages TEXT[],
    available_hours JSONB,
    verification_docs TEXT,
    is_approved BOOLEAN DEFAULT false,
    rating_avg DECIMAL(2,1) DEFAULT 0.0,
    total_reviews INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    icon VARCHAR(50),
    description TEXT
);

-- Jobs
CREATE TABLE jobs (
    i