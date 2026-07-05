# Bitácora

App de una sola página para guardar errores/soluciones, apuntes y comandos de terminal, con búsqueda y filtros. Los datos viven en Supabase (Postgres en la nube), así que se ven igual desde cualquier PC donde abras la página.

## 1. Crear el proyecto en Supabase

1. Entra a [supabase.com](https://supabase.com) y crea una cuenta gratuita (puedes usar tu GitHub).
2. Crea un **New Project**. Elige una contraseña de base de datos (guárdala, no la necesitarás para esta app pero es buena práctica tenerla).
3. Espera a que termine de aprovisionarse (~1-2 minutos).

## 2. Crear la tabla

1. En el menú lateral, ve a **SQL Editor** → **New query**.
2. Copia y pega todo el contenido del archivo `supabase-setup.sql` (incluido en esta carpeta).
3. Dale **Run**. Deberías ver "Success. No rows returned".

## 3. Obtener tus llaves

1. Ve a **Project Settings** (ícono de engranaje) → **API**.
2. Copia el **Project URL** (algo como `https://xxxxx.supabase.co`).
3. Copia la **anon public key** (una cadena larga que empieza con `eyJ...`).

## 4. Configurar el HTML

Abre `index.html` y busca estas líneas cerca del final:

```js
const SUPABASE_URL = 'PEGA_AQUI_TU_SUPABASE_URL';
const SUPABASE_ANON_KEY = 'PEGA_AQUI_TU_SUPABASE_ANON_KEY';
```

Reemplaza los valores con los que copiaste. Guarda el archivo.

## 5. Subir a GitHub Pages

1. Crea un repositorio nuevo en GitHub (puede ser privado o público, da igual — lo que importa es la URL de Pages, ver nota de seguridad abajo).
2. Sube `index.html` a la raíz del repo (el archivo `supabase-setup.sql` y este README no hace falta subirlos, son solo para tu referencia).
3. Ve a **Settings → Pages** del repo, en "Branch" elige `main` y carpeta `/root`, guarda.
4. En un par de minutos tu app estará en algo como `https://tuusuario.github.io/tu-repo/`.

Desde ese momento, abre esa URL desde cualquier computadora y vas a ver siempre la misma información, porque vive en Supabase, no en el navegador.

## Nota importante sobre seguridad

Esta app **no tiene login**. Cualquier persona que conozca la URL de tu página en GitHub Pages puede ver el código fuente (incluida la `anon key`) y, en teoría, leer o modificar tus datos directamente contra Supabase.

Esto es aceptable si:
- No compartes la URL con nadie.
- El repositorio de GitHub es **privado** (recomendado) — GitHub Pages en repos privados requiere plan GitHub Pro/Team/Enterprise, u organización. Si tu cuenta es gratuita y el repo tiene que ser público, cualquiera que adivine o encuentre la URL exacta podría acceder.

Si más adelante quieres cerrarlo del todo, se puede agregar un login simple con Supabase Auth (email/contraseña) sin rehacer el resto de la app — avísame y lo agregamos.

## Cómo usar la app

- **+ nueva entrada**: abre el formulario. Elige el tipo (error, apunte, comando o general), escribe título y contenido, y opcionalmente contexto (p. ej. "Klyron ERP") y etiquetas separadas por coma (p. ej. `pm2, windows, sqlite`).
- **Filtros por tipo**: los botones arriba (todos / error / apunte / comando / general).
- **Filtros por etiqueta**: aparecen automáticamente según las etiquetas que vayas usando; haz clic para activarlas/desactivarlas, puedes combinar varias.
- **Buscador**: busca en título, contenido, contexto y etiquetas al mismo tiempo.
- **Editar / eliminar**: cada entrada tiene sus botones abajo.
- Atajo: dentro del campo de contenido, `Ctrl+Enter` (o `Cmd+Enter` en Mac) guarda directamente.
