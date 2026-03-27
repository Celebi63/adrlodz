# Environment Variables Setup

Create a `.env` file in the root directory of your project with the following content:

```env
VITE_SUPABASE_URL=https://ypaqzdcnmmdlokmywiab.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlwYXF6ZGNubW1kbG9rbXl3aWFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY5MjQ1OTksImV4cCI6MjA4MjUwMDU5OX0.g8UZa32FpB7ui8j2ejvPb-9lMJkzEHBxKfyoO3lwiRs
```

## Important:
- Never commit the `.env` file to version control
- Add `.env` to your `.gitignore` file (it's usually already there)
- Each developer needs to create their own `.env` file

