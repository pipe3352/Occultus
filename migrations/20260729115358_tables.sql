-- Add migration script here

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

--Users Table
CREATE TABLE users(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, --store hashed passwords
    public_key TEXT, -- store the user public key
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

--Files table

CREATE TABLE files(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE, -- foreign key to users table, if the user id is deleted everything related is deleted too, cascade.
    file_name VARCHAR(255) NOT NULL,
    file_size BIGINT NOT NULL,
    encrypted_aes_key BYTEA NOT NULL, --store encrypted AES key
    encrypted_file BYTEA NOT NULL, -- store the actual encrypted file content
    iv BYTEA NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

--shared links table
CREATE TABLE shared_links(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    file_id UUID REFERENCES files(id) ON DELETE CASCADE,
    recipient_user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    password VARCHAR(255) NOT NULL,
    expiration_date TIMESTAMP WITH TIME ZONE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);