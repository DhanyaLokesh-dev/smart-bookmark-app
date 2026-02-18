# Smart Bookmark App — Setup & Deployment Guide

## Introduction

Smart Bookmark App is a simple web application that allows users to save and manage bookmarks securely.
It uses Supabase authentication to ensure bookmarks are private to each user and supports real-time
updates across multiple browser tabs.


## Tech Stack
- **Next.js 15** (App Router)
- **Supabase** (Auth via Google OAuth, PostgreSQL database, Realtime)
- **Tailwind CSS**
- **Deployed on Vercel**

---

## Step 1: Set Up Supabase

1. Go to [https://supabase.com](https://supabase.com) and create a free account
2. Click **New Project**, name it `smart-bookmarks`, pick a region close to you
3. Wait ~2 minutes for the project to be ready

### Create the Database Table
4. In your Supabase dashboard, click **SQL Editor** → **New Query**
5. Copy and paste the contents of `supabase-schema.sql` and click **Run**

### Enable Google OAuth
6. Go to **Authentication** → **Providers** → find **Google** and toggle it ON
7. You'll need a Google OAuth Client ID and Secret:
   - Go to [https://console.cloud.google.com](https://console.cloud.google.com)
   - Create a new project (or use existing)
   - Go to **APIs & Services** → **Credentials** → **Create Credentials** → **OAuth 2.0 Client ID**
   - Application type: **Web application**
   - Authorized redirect URIs: `https://<your-supabase-project-ref>.supabase.co/auth/v1/callback`
     (You can find your project ref in Supabase: Settings → General)
   - Copy the **Client ID** and **Client Secret** back into Supabase
8. Save in Supabase

### Get Your API Keys
9. In Supabase, go to **Settings** → **API**
10. Copy:
    - **Project URL** (looks like `https://xxxx.supabase.co`)
    - **anon/public** key

---

## Step 2: Run Locally

1. Clone/download this project folder
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env.local` file (copy from `.env.local.example`):
   ```
   NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
   ```
4. Run the dev server:
   ```bash
   npm run dev
   ```
5. Open [http://localhost:3000](http://localhost:3000)

---

## Step 3: Deploy to Vercel

1. Push this project to a GitHub repository:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/YOUR_USERNAME/smart-bookmark-app.git
   git push -u origin main
   ```

2. Go to [https://vercel.com](https://vercel.com) and sign in
3. Click **New Project** → **Import** your GitHub repo
4. In the **Environment Variables** section, add:
   - `NEXT_PUBLIC_SUPABASE_URL` = your Supabase project URL
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = your Supabase anon key
5. Click **Deploy**
6. Wait ~1 minute — your live URL will be shown (e.g. `https://smart-bookmark-app.vercel.app`)

### Update Supabase OAuth Redirect URL
7. Copy your Vercel URL and go back to Supabase
8. Go to **Authentication** → **URL Configuration**
9. Add your Vercel URL to **Site URL**: `https://your-app.vercel.app`
10. Add to **Redirect URLs**: `https://your-app.vercel.app/api/auth/callback`

### Update Google OAuth Redirect
11. Go back to Google Cloud Console → your OAuth credentials
12. Add `https://<your-supabase-project-ref>.supabase.co/auth/v1/callback` if not already there
    (This was already done in Step 1, so you should be good!)

---

## Features
- ✅ Google OAuth sign-in (no email/password)
- ✅ Add bookmarks (title + URL)
- ✅ Private bookmarks per user (Row Level Security)
- ✅ Real-time updates (open 2 tabs — changes sync instantly)
- ✅ Delete your own bookmarks
- ✅ Favicon auto-loading
- ✅ Responsive design with Tailwind CSS

## Problems Faced & Solutions

**Issue:** OAuth redirect caused blank page after login  
**Solution:** Added `/app/auth/callback/route.ts` to properly handle Supabase OAuth in Next.js App Router.


## Live Demo
https://smart-bookmark-app-sigma-olive.vercel.app


