create table if not exists public.garden_albums (
  id text primary key,
  era text not null,
  title text not null,
  description text default '',
  cover_url text default '',
  updated_at timestamptz default now()
);
create table if not exists public.garden_photos (
  id uuid primary key default gen_random_uuid(),
  album_id text references public.garden_albums(id) on delete cascade,
  title text default '',
  file_url text not null,
  created_at timestamptz default now()
);
create table if not exists public.garden_settings (
  id text primary key,
  value jsonb not null default '{}'::jsonb,
  updated_at timestamptz default now()
);
alter table public.garden_albums enable row level security;
alter table public.garden_photos enable row level security;
alter table public.garden_settings enable row level security;
create policy "public read albums" on public.garden_albums for select using (true);
create policy "public write albums" on public.garden_albums for insert with check (true);
create policy "public update albums" on public.garden_albums for update using (true) with check (true);
create policy "public read photos" on public.garden_photos for select using (true);
create policy "public write photos" on public.garden_photos for insert with check (true);
create policy "public update photos" on public.garden_photos for update using (true) with check (true);
create policy "public delete photos" on public.garden_photos for delete using (true);
create policy "public read settings" on public.garden_settings for select using (true);
create policy "public write settings" on public.garden_settings for insert with check (true);
create policy "public update settings" on public.garden_settings for update using (true) with check (true);
insert into storage.buckets (id,name,public) values ('garden-media','garden-media',true) on conflict (id) do nothing;
create policy "public read garden media" on storage.objects for select using (bucket_id='garden-media');
create policy "public upload garden media" on storage.objects for insert with check (bucket_id='garden-media');
create policy "public update garden media" on storage.objects for update using (bucket_id='garden-media');
