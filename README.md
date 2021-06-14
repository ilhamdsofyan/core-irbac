# CORE IRBAC
Core dari [Codeigniter 3](https://github.com/bcit-ci/CodeIgniter) yg sudah diubah dan ditambah beberapa configurasi

## Apa yg Sudah Di-Install
- [x] HMVC dari [crypt](https://github.com/Crypt/Codeigniter-HMVC)
- [x] Custom model dari [yidas](https://github.com/yidas/codeigniter-model) dengan sedikit penyesuaian
- [x] Template admin dari [AdminLTE](https://adminlte.io/themes/dev/AdminLTE/)
- [x] Modul RBAC yg lumayan mirip dengan yg dibuat [mdmunir](https://github.com/mdmunir/yii2-admin)

## Kebutuhan Sebelum Install
* PHP >=7.0
* [Git](https://git-scm.com/downloads)
* [Composer](https://getcomposer.org/download/)

## Cara Install
* Install aplikasi Git
* Pergi ke directory htdocs `Drive:\xampp\htdocs` (sesuaikan dengan aplikasi stand-alone server anda)
* Buka aplikasi gitbash di directory tersebut
	* Klik kanan di directory
	* Pilih Git Bash Here
* Ketik command `git clone https://github.com/ilhamdsofyan/core-irbac.git` untuk mendownload project
* Pergi ke directory aplikasi `/path/to/core-irbac` menggunakan command-line, dan jalankan `composer install`
* Copy file `.env-example` dan ubah file yg sudah di-copy jadi `.env`
* Sesuaikan koneksi db anda di file tersebut
* (Tambahan) Saya sarankan untuk akses file dengan menggunakan fitur [vhost](https://www.cloudways.com/blog/configure-virtual-host-on-windows-10-for-wordpress/)

## Lisensi
[MIT](https://choosealicense.com/licenses/mit/)
