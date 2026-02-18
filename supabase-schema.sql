-- Run this in your Supabase SQL Editor
-- Go to: https://supabase.com > Your Project > SQL Editor > New Query

-- 1. Create the bookmarks table
CREATE TABLE IF NOT EXISTS public.bookmarks (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  url TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS) - this makes bookmarks private per user
ALTER TABLE public.bookmarks ENABLE ROW LEVEL SECURITY;

-- 3. Create policies so users can only see/edit their own bookmarks
CREATE POLICY "Users can view their own bookmarks"
  ON public.bookmarks FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert their own bookmarks"
  ON public.bookmarks FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete their own bookmarks"
  ON public.bookmarks FOR DELETE
  USING (auth.uid() = user_id);

-- 4. Enable real-time for the bookmarks table
-- Go to: Supabase Dashboard > Database > Replication
-- Toggle ON the "bookmarks" table under "supabase_realtime" publication
-- OR run this:
ALTER PUBLICATION supabase_realtime ADD TABLE public.bookmarks;
