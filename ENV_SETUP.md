# Environment Variables Setup

Create a `.env` file in the root directory of your project with the following content:

```env
VITE_SUPABASE_URL=https://ypaqzdcnmmdlokmywiab.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwYXF6ZGNubW1kbG9rbXl3aWFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY5MjQ1OTksImV4cCI6MjA4MjUwMDU5OX0.g8UZa32FpB7ui8j2ejvPb-9lMJkzEHBxKfyoO3lwiRs
```

## How to get these values:

1. Go to your Supabase project dashboard at https://supabase.com
2. Click on your project
3. Go to **Settings** (gear icon in sidebar)
4. Click on **API** in the settings menu
5. Copy the values:
   - **URL**: This is your `VITE_SUPABASE_URL`
   - **anon public**: This is your `VITE_SUPABASE_ANON_KEY`

## Important:
- Never commit the `.env` file to version control
- Add `.env` to your `.gitignore` file (it's usually already there)
- Each developer needs to create their own `.env` file

