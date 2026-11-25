-- MyFinance: penyimpanan satu dokumen JSON per akun Supabase Auth
-- Jalankan seluruh script ini di Supabase Dashboard > SQL Editor > New query.

create table if not exists public.finance_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.finance_data enable row level security;

revoke all on table public.finance_data from anon, authenticated;
grant select, insert, update, delete on table public.finance_data to authenticated;

drop policy if exists "MyFinance: read own data" on public.finance_data;
create policy "MyFinance: read own data"
on public.finance_data for select to authenticated
using ((select auth.uid()) = user_id);

drop policy if exists "MyFinance: insert own data" on public.finance_data;
create policy "MyFinance: insert own data"
on public.finance_data for insert to authenticated
with check ((select auth.uid()) = user_id);

drop policy if exists "MyFinance: update own data" on public.finance_data;
create policy "MyFinance: update own data"
on public.finance_data for update to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

drop policy if exists "MyFinance: delete own data" on public.finance_data;
create policy "MyFinance: delete own data"
on public.finance_data for delete to authenticated
using ((select auth.uid()) = user_id);


-- Aktifkan perubahan tabel untuk Supabase Realtime (sinkronisasi antarperangkat).
do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'finance_data'
  ) then
    alter publication supabase_realtime add table public.finance_data;
  end if;
end $$;
