-- わくわく管理：クラウド同期用
-- Supabase Dashboard → SQL Editor に貼り付けて Run

create table if not exists public.wakuwaku_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.wakuwaku_data enable row level security;

create policy "users can read own wakuwaku data"
on public.wakuwaku_data for select
using (auth.uid() = user_id);

create policy "users can insert own wakuwaku data"
on public.wakuwaku_data for insert
with check (auth.uid() = user_id);

create policy "users can update own wakuwaku data"
on public.wakuwaku_data for update
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Supabase Dashboard → Authentication → Providers → Email で
-- 「Confirm email」をOFFにしてください。
-- このアプリはIDを内部的に username@wakuwaku.local という形式へ変換し、
-- Supabase Authのメール/パスワード認証を利用します。
