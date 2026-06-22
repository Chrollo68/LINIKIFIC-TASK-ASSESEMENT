# sup_demo

Supabase Flutter demo app with authentication, PostgreSQL-backed CRUD, realtime subscriptions, and user profile support.

## Setup

1. Create a Supabase project at https://app.supabase.com.
2. In the Supabase project dashboard, create a `profiles` table and a `messages` table.
3. Enable Row Level Security (RLS) for both tables and add policies for authenticated users.
4. Create a `.env` file in the project root using `.env.example`.
5. Set `SUPABASE_URL` and `SUPABASE_ANON_KEY` in `.env`.
6. Run `flutter pub get`.
7. Run `flutter run`.

## Supabase schema suggestions

- Table `profiles`
  - `id` text primary key
  - `email` text
  - `full_name` text
  - `avatar_url` text
  - `created_at` timestamptz
  - `updated_at` timestamptz

- Table `messages`
  - `id` uuid primary key default uuid_generate_v4()
  - `content` text
  - `user_id` text
  - `username` text
  - `created_at` timestamptz default now()

## Features

- Email/password sign up and sign in
- Magic link authentication
- OAuth sign-in support for Google and GitHub
- Supabase database insert, query, update, and delete operations
- Realtime message updates using Supabase subscriptions
- User profile management

## Notes

- Do not commit `.env` to source control.
- Use Supabase RLS policies to ensure only authenticated users can read/write their data.
- The app uses `flutter_dotenv` to load environment variables securely.
