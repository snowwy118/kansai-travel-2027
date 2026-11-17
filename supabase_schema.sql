-- Run this in Supabase Dashboard → SQL Editor.
-- 1) Create the table and allow public read-only access.
create table if not exists public.travel_journals (
  id text primary key,
  content jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.travel_journals enable row level security;

grant select on public.travel_journals to anon, authenticated;
grant insert, update on public.travel_journals to authenticated;

drop policy if exists "Anyone can read public travel journals" on public.travel_journals;
create policy "Anyone can read public travel journals"
on public.travel_journals for select
to anon, authenticated
using (true);

-- IMPORTANT:
-- After creating your admin user in Supabase Authentication → Users,
-- copy that user's UUID and replace ADMIN_USER_UUID below.
drop policy if exists "Only the designated admin can insert journals" on public.travel_journals;
create policy "Only the designated admin can insert journals"
on public.travel_journals for insert
to authenticated
with check ((select auth.uid()) = 'ADMIN_USER_UUID'::uuid);

drop policy if exists "Only the designated admin can update journals" on public.travel_journals;
create policy "Only the designated admin can update journals"
on public.travel_journals for update
to authenticated
using ((select auth.uid()) = 'ADMIN_USER_UUID'::uuid)
with check ((select auth.uid()) = 'ADMIN_USER_UUID'::uuid);

-- Seed the journal row. The website's first admin save will populate content.
insert into public.travel_journals (id, content)
values ('osaka-may-2027', '{}'::jsonb)
on conflict (id) do nothing;
