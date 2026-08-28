-- わくわく管理 v1.1.0
-- キャラクター画像を全ユーザー共通で参照するための設定

create table if not exists public.wakuwaku_shared_characters (
  name text primary key,
  image text not null,
  updated_by uuid references auth.users(id) on delete set null,
  updated_at timestamptz not null default now()
);

alter table public.wakuwaku_shared_characters enable row level security;

drop policy if exists "authenticated can read shared character images" on public.wakuwaku_shared_characters;
drop policy if exists "authenticated can insert shared character images" on public.wakuwaku_shared_characters;
drop policy if exists "authenticated can update shared character images" on public.wakuwaku_shared_characters;
drop policy if exists "authenticated can delete shared character images" on public.wakuwaku_shared_characters;

create policy "authenticated can read shared character images"
on public.wakuwaku_shared_characters
for select
to authenticated
using (true);

create policy "authenticated can insert shared character images"
on public.wakuwaku_shared_characters
for insert
to authenticated
with check (true);

create policy "authenticated can update shared character images"
on public.wakuwaku_shared_characters
for update
to authenticated
using (true)
with check (true);

create policy "authenticated can delete shared character images"
on public.wakuwaku_shared_characters
for delete
to authenticated
using (true);

grant select, insert, update, delete
on table public.wakuwaku_shared_characters
to authenticated;
