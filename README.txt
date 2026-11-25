MYFINANCE - SUPABASE CLOUD EDITION

FILE STRUCTURE (semua file di satu folder/root GitHub):
index.html
style.css
app.js
bri.png
seabank.png
gopay.webp
dana.jpg
cash.png

SETUP:
1. Jalankan MyFinance_Supabase_Setup.sql di Supabase SQL Editor untuk membuat tabel public.finance_data dan RLS.
2. Di Supabase Authentication > Users, buat satu user dengan email dan password milikmu.
3. Di Authentication > Providers / Sign In settings, matikan signups publik (disable new user signups).
4. Pastikan URL dan publishable key di app.js sesuai project milikmu.
5. Deploy file ke GitHub Pages / jalankan melalui localhost/Live Server.

CLOUD:
- Login menggunakan email/password Supabase Auth.
- Data disimpan di public.finance_data sebagai satu dokumen JSON per user.
- RLS memastikan user hanya mengakses baris miliknya.
- LocalStorage tetap menjadi cache lokal; cloud menjadi sumber data lintas perangkat.
- Realtime update aktif untuk perubahan dari perangkat lain.
- Simpan transaksi dengan koneksi internet aktif.

MIGRASI DATA LAMA DARI HP DAN LAPTOP:
1. Sebelum menggunakan versi cloud, buka aplikasi versi lama pada HP lalu klik Backup data dan simpan file JSON.
2. Lakukan hal yang sama di laptop. Jangan menghapus backup.
3. Login ke versi cloud dari perangkat pertama. Jika database masih kosong, data LocalStorage perangkat itu otomatis diunggah.
4. Pada menu samping klik "Gabungkan backup perangkat", pilih file backup dari perangkat lain (bisa pilih beberapa file sekaligus), lalu tunggu notifikasi selesai.
5. Login di perangkat lain dengan email/password Supabase yang sama. Data akan dimuat dari cloud.

CATATAN:
- Publishable key boleh berada di frontend bila RLS sudah aktif. Jangan pernah memasukkan sb_secret_ atau service_role key ke app.js.
- Backup JSON berisi data keuangan pribadi; simpan dengan aman.
- Jika user belum dibuat di Supabase Authentication > Users, login tidak akan berhasil.
- Realtime broadcast antar perangkat bergantung koneksi; reload halaman akan mengambil data terbaru dari database.

LOGIN BUTTON FIX:
- Supabase browser SDK now loads from its explicit UMD bundle:
  https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/dist/umd/supabase.js
- Login errors are shown directly under the login button.
- If SDK/CDN is blocked, the login page displays a clear message instead of silently doing nothing.
