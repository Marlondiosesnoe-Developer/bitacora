-- ============================================================
-- Bitácora — configuración de base de datos en Supabase
-- Copia y pega todo este archivo en el "SQL Editor" de tu
-- proyecto Supabase (botón "New query") y dale "Run".
-- ============================================================

create extension if not exists pgcrypto;

create table if not exists entries (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  tipo text not null default 'general' check (tipo in ('error', 'apunte', 'comando', 'general')),
  titulo text not null,
  contexto text,
  contenido text not null,
  tags text[] not null default '{}'
);

-- Índice para que la búsqueda por texto sea rápida
create index if not exists entries_search_idx
  on entries using gin (to_tsvector('spanish', titulo || ' ' || contenido));

-- Activamos seguridad a nivel de fila (obligatorio en Supabase)
alter table entries enable row level security;

-- Como la app no tiene login, permitimos que cualquiera que use
-- la anon key (la que va en el HTML) pueda leer y escribir.
-- La privacidad real depende de que nadie más conozca la URL
-- de tu página en GitHub Pages.
create policy "anon_full_access"
on entries
for all
to anon
using (true)
with check (true);
