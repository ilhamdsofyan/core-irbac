# CORE IRBAC Documentation

Dokumentasi ini dibuat untuk onboarding developer baru dan sebagai referensi teknis saat mengembangkan fitur di repository `core-irbac`.

---

## 1) Gambaran Umum Repository

- **Framework:** CodeIgniter 3.
- **Arsitektur:** HMVC (Modular Extensions / MX).
- **UI:** AdminLTE.
- **Auth:** Session-based auth untuk web + JWT untuk API.
- **Authorization:** RBAC (role-based access control) berbasis route.

Referensi struktur utama:

```text
├── application/     # Core aplikasi CodeIgniter
├── system/          # System files CodeIgniter
├── web/             # Web assets (CSS, JS, images)
├── index.php        # Entry point
├── irbac.sql        # Database schema + seed
└── .env.example     # Environment config template
```

---

## 2) Bootstrapping dan Entry Point

### 2.1 Alur startup

1. Request masuk ke `index.php`.
2. CI environment diset dari `$_SERVER['CI_ENV']` (default `development`).
3. Dotenv loader dijalankan untuk membaca file `.env`.
4. Framework CodeIgniter diboot melalui `system/core/CodeIgniter.php`.

### 2.2 Konfigurasi environment

Pastikan `.env` diisi berdasarkan `.env.example`, terutama:

- `APP_*` metadata aplikasi.
- `DB_*` koneksi database.
- `GOOGLE_ID`, `GOOGLE_SECRET` untuk OAuth.
- `JWT_ACCESS_TOKEN`, `JWT_REFRESH_TOKEN` untuk API JWT.

---

## 3) Arsitektur Aplikasi

### 3.1 HMVC

Project menggunakan `MY_Router` yang mewarisi `MX_Router`. Artinya controller bisa berada di:

- `application/controllers/*` (global)
- `application/modules/<module>/controllers/*` (modular)

Modul utama saat ini: `rbac`.

### 3.2 Route organization

Route dibagi menjadi beberapa file:

- `application/config/routes.php` → route utama aplikasi.
- `application/config/rbac.php` → route modul RBAC.
- `application/config/api.php` → route API.

`routes.php` melakukan `require_once` ke `api.php` dan `rbac.php`.

### 3.3 Pola naming routing (wajib konsisten)

#### Controller
- Pattern: `{Name}Controller.php`
- Contoh: `SiteController`, `UserController`, `PermissionController`

#### Action method
- Pattern: `action{MethodName}`
- Contoh: `actionIndex`, `actionCreate`, `actionSimpan`, `actionGetData`

#### URL route
- Pattern: `kebab-case`
- Contoh: `site/login`, `profil/simpan-info-personal`, `rbac/user/get-data`

#### HTTP method
- Default route = GET
- POST route harus eksplisit: `['post']`

---

## 4) Authentication dan Authorization

### 4.1 Session auth (web)

### Login flow (`SiteController::actionLogin`)

1. User membuka `/site/login`.
2. Form POST diproses oleh model `Formlogin`.
3. `Formlogin` melakukan validasi user + `password_verify()`.
4. Jika sukses, session diset:
   - `status_login`
   - `identity`
   - `menus`
   - `group_id`
   - `detail_identity`

### Lock/unlock flow

- `/site/lock` menset status login ke `locked`.
- Unlock membutuhkan verifikasi password user saat ini.

### Google OAuth flow

- Route: `/site/google-auth`.
- Menggunakan `google/apiclient`.
- Jika email match user internal, session login dibentuk seperti flow normal.

### 4.2 Route guard via hooks

Hook aktif melalui `enable_hooks = TRUE`:

- `AuthHelper::checkLogin` (post_controller_constructor)
- `AuthHelper::checkPermission` (post_controller)
- `CommonHook::setNotification` (post_controller)

Aturan utamanya:

1. Jika route ada di `sys_allowed` → bypass login/permission.
2. Jika tidak, user harus login.
3. Setelah login, route harus ada pada daftar route yang diizinkan berdasarkan group.
4. Jika gagal: redirect login / lock / 401 / 404 sesuai kondisi.

### 4.3 JWT auth (API)

`MY_Controller` dipakai untuk endpoint API yang memerlukan bearer token:

- Set CORS header.
- Ambil bearer token.
- Decode JWT (`HS512`) dan validasi claim (`iss`, `nbf`, `exp`).
- Jika valid, data user disimpan ke session `identity` untuk kebutuhan `blameable`.

---

## 5) RBAC Module

Lokasi: `application/modules/rbac/`.

### 5.1 Controller utama RBAC

- `MenuController`
- `UserController`
- `GroupController`
- `RouteController`
- `AllowedController`
- `PermissionController`
- `AssignmentController`

### 5.2 Konsep RBAC di project ini

- **Allowed route:** route publik yang tidak butuh login (`sys_allowed`).
- **Route item:** route yang dapat diassign (`sys_auth_item` dengan type route).
- **Permission item:** permission yang mengelompokkan route (`sys_auth_item` dengan type permission).
- **Assignment:** permission ke group (`sys_auth_assignment`).
- **Child mapping:** relasi permission ↔ route (`sys_auth_item_child`).

---

## 6) Layout, View, dan UI Convention

### 6.1 Layout Library

`application/libraries/Layout.php` mengatur render dengan pola:

```php
$this->layout->layout = 'main';
$this->layout->title = 'Page Title';
$this->layout->view_js = '_partial/index_js';
$this->layout->view_css = '_partial/index_css';
$this->layout->render('index', $data);
```

### 6.2 Layout utama

- `application/views/layouts/main.php` untuk halaman setelah login.
- Sidebar menu dirender dinamis via `Menuhelper` berdasarkan session `menus` + `group_id`.

### 6.3 Konvensi folder view

Jika controller `SiteController` memanggil `render('index')`, maka default view path:

- `application/views/site/index.php`

Partial yang lazim dipakai:

- `application/views/site/_partial/index_js.php`
- `application/views/site/_partial/index_css.php`

---

## 7) Custom ORM & Model Layer

### 7.1 Base classes

- `MY_Orm` (adaptasi dari yidas model): ActiveRecord style, relation helper (`hasOne`, `hasMany`), timestamps, blameable, soft delete.
- `MY_Model`: utility query umum (`get`, `getAll`, `delete`, datatables helpers).

### 7.2 Form model vs table model

- **Table model**: representasi 1 tabel (contoh: `User`, `Group`, `Notifikasi`).
- **Form model**: model untuk validasi/input flow tanpa representasi langsung tabel (contoh: `Formlogin`, `FormChangePassword`).

---

## 8) Mapping Database → Model (1 table 1 model)

> Catatan: Beberapa model berbagi tabel yang sama untuk memisahkan concern bisnis (contoh: `Authitem`, `Routes`, `Permission` semuanya berbasis `sys_auth_item`).

| Tabel | Model utama | Lokasi model | Catatan |
|---|---|---|---|
| `tbl_user` | `User` | `application/models/master/User.php` | User account + relation group/detail |
| `tbl_user_detail` | `Userdetail` | `application/models/transaksi/Userdetail.php` | Profil/detail user |
| `tbl_group` | `Group` | `application/models/master/Group.php` | Group/role level aplikasi |
| `tbl_group_user` | `Usergroup` | `application/models/master/Usergroup.php` | Pivot user-group |
| `tbl_menu` | `Menu` | `application/models/master/Menu.php` | Data menu dinamis |
| `tbl_menu_group` | `Menugroup` | `application/models/master/Menugroup.php` | Pivot menu-group |
| `tbl_menu_type` | `Menutype` | `application/models/master/Menutype.php` | Tipe menu |
| `tbl_notifikasi` | `Notifikasi` | `application/models/Notifikasi.php` | Notifikasi user |
| `sys_allowed` | `Allowed` | `application/models/rbac/Allowed.php` | Route publik tanpa auth |
| `sys_auth_assignment` | `Authassignment` | `application/models/rbac/Authassignment.php` | Assignment permission ke group |
| `sys_auth_item` | `Authitem` | `application/models/rbac/Authitem.php` | Entitas route + permission |
| `sys_auth_item` | `Routes` | `application/models/rbac/Routes.php` | Operasi route (type route) |
| `sys_auth_item` | `Permission` | `application/models/rbac/Permission.php` | Operasi permission (type permission) |
| `sys_auth_item_child` | `Authitemchild` | `application/models/rbac/Authitemchild.php` | Relasi parent-child item |

### 8.1 Tabel yang belum punya model khusus

- `sys_audit_trails` sudah ada di SQL, namun belum ada model aktif khusus di `application/models` saat ini.

---

## 9) Migration & Seeder (CodeIgniter)

Project ini sekarang menyediakan migration dan seeder native CodeIgniter:

- Migration schema: `application/migrations/20260206090000_init_irbac_schema.php`
- Seeder runner library: `application/libraries/Seeder.php`
- Initial seeder: `application/seeders/InitialSeeder.php`
- CLI command: `application/controllers/CommandsController.php`

### 9.1 Menjalankan migration

```bash
php index.php CommandsController actionMigrate
```

### 9.2 Menjalankan seeder

```bash
php index.php CommandsController actionSeed
```

### 9.3 Menjalankan migration + seeder sekaligus

```bash
php index.php CommandsController actionMigrateAndSeed
```

### 9.4 Default credential seed

Seeder akan membuat user admin default:

- username: `admin`
- password: `4dm1n-Rbac`

> Catatan: migration dan seeder **tidak bergantung** pada pembacaan file `irbac.sql` saat runtime; schema dan seed statement sudah didefinisikan langsung di file migration/seeder.

---

## 10) Developer Workflow (fitur baru)

Contoh: menambah modul `Blog`.

1. Buat struktur module:
   - `application/modules/blog/controllers/BlogController.php`
   - `application/modules/blog/models/Blog.php`
   - `application/modules/blog/views/blog/index.php`
2. Tambah route di `application/config/routes.php` dengan pola `action*`.
3. Buka `/rbac/route` dan lakukan refresh route.
4. Buat permission di `/rbac/permission`.
5. Assign permission ke group di `/rbac/assignment`.
6. Tambah menu di `/rbac/menu`.
7. Uji login user dengan group berbeda.

---

## 11) Dokumentasi Otomatis ke Depan (WAJIB)

Agar dokumentasi ini selalu up-to-date, gunakan aturan berikut:

1. **Setiap PR yang menambah/mengubah salah satu dari poin ini wajib update file ini:**
   - route baru/perubahan route,
   - model/table baru,
   - hook/auth flow,
   - module baru,
   - perubahan convention.
2. **Checklist PR wajib** (copy ke deskripsi PR):
   - [ ] Sudah update `docs/CORE_IRBAC_GUIDE.md`
   - [ ] Sudah update mapping table-model (jika ada tabel/model baru)
   - [ ] Sudah update contoh flow jika ada perubahan auth/rbac
3. **Rule review:** PR tidak boleh di-merge jika checklist dokumentasi tidak terpenuhi.

> Rekomendasi: jadikan poin checklist di atas sebagai bagian template Pull Request tim agar pembaruan dokumentasi berlangsung otomatis sebagai bagian standar proses merge.

---

## 12) Quick Checklist untuk Developer Baru

- [ ] Jalankan `composer install`.
- [ ] Copy `.env.example` → `.env` dan isi semua variabel penting.
- [ ] Jalankan migration + seeder via CLI command.
- [ ] Pastikan route default (`/site`) bisa diakses.
- [ ] Login menggunakan akun seed data.
- [ ] Cek menu RBAC (`/rbac/*`) untuk memahami relasi route-permission-group.
- [ ] Baca ulang section 3, 4, 5, 8 sebelum menambah fitur baru.

