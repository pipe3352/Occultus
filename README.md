Occultus is an end-to-end encrypted file sharing service: every file is encrypted server-side with a hybrid AES-256 + RSA-2048 pattern before being stored, 
and made available through password-protected links with expiration dates. 
The backend is written in Rust with Axum and PostgreSQL, with JWT authentication and passwords hashed using Argon2; the frontend is built with Next.js
