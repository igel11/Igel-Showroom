BEGIN;

CREATE TABLE IF NOT EXISTS pegawai (
    id_pegawai INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    jabatan ENUM('admin', 'sales', 'manajer') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telepon VARCHAR(20),
    status_aktif BOOLEAN DEFAULT TRUE,
    dibuat_pada DATETIME DEFAULT CURRENT_TIMESTAMP,
    diupdate_pada DATETIME ON UPDATE CURRENT_TIMESTAMP,
    login_terakhir DATETIME,
    INDEX idx_pegawai_jabatan (jabatan),
    INDEX idx_pegawai_username (username)
);

CREATE TABLE IF NOT EXISTS merek (
    id_merek INT PRIMARY KEY AUTO_INCREMENT,
    nama_merek VARCHAR(50) NOT NULL,
    kode_merek VARCHAR(10) UNIQUE NOT NULL,
    negara_asal VARCHAR(50),
    deskripsi TEXT,
    status_aktif BOOLEAN DEFAULT TRUE,
    dibuat_oleh INT,
    dibuat_pada DATETIME DEFAULT CURRENT_TIMESTAMP,
    diupdate_pada DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (dibuat_oleh) REFERENCES pegawai(id_pegawai),
    INDEX idx_nama_merek (nama_merek)
);

CREATE TABLE IF NOT EXISTS tipe_mobil (
    id_tipe INT PRIMARY KEY AUTO_INCREMENT,
    nama_tipe VARCHAR(50) NOT NULL,
    kode_tipe VARCHAR(10) UNIQUE NOT NULL,
    deskripsi TEXT,
    status_aktif BOOLEAN DEFAULT TRUE,
    dibuat_oleh INT,
    dibuat_pada DATETIME DEFAULT CURRENT_TIMESTAMP,
    diupdate_pada DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (dibuat_oleh) REFERENCES pegawai(id_pegawai),
    INDEX idx_nama_tipe (nama_tipe)
);

CREATE TABLE IF NOT EXISTS mobil (
    id_mobil INT PRIMARY KEY AUTO_INCREMENT,
    id_merek INT,
    id_tipe INT,
    nama_model VARCHAR(100) NOT NULL,
    varian VARCHAR(50),
    tahun_produksi INT NOT NULL,
    warna VARCHAR(30),
    transmisi VARCHAR(20),
    jenis_bahan_bakar VARCHAR(20),
    kapasitas_mesin INT,
    nomor_polisi VARCHAR(20) UNIQUE,
    nomor_rangka VARCHAR(50) UNIQUE,
    nomor_mesin VARCHAR(50) UNIQUE,
    status ENUM('tersedia', 'dipesan', 'terjual', 'perawatan') DEFAULT 'tersedia',
    harga_sekarang DECIMAL(15,2),
    stok INT DEFAULT 0,
    stok_minimum INT DEFAULT 1,
    status_aktif BOOLEAN DEFAULT TRUE,
    dibuat_oleh INT,
    dibuat_pada DATETIME DEFAULT CURRENT_TIMESTAMP,
    diupdate_pada DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_merek) REFERENCES merek(id_merek),
    FOREIGN KEY (id_tipe) REFERENCES tipe_mobil(id_tipe),
    FOREIGN KEY (dibuat_oleh) REFERENCES pegawai(id_pegawai),
    INDEX idx_status_mobil (status),
    INDEX idx_model_mobil (nama_model)
);

CREATE TABLE IF NOT EXISTS pelanggan (
    id_pelanggan INT PRIMARY KEY AUTO_INCREMENT,
    kode_pelanggan VARCHAR(20) UNIQUE NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telepon VARCHAR(20) NOT NULL,
    alamat TEXT,
    nomor_identitas VARCHAR(50) UNIQUE NOT NULL,
    jenis_identitas ENUM('KTP', 'SIM', 'Passport') NOT NULL,
    status_aktif BOOLEAN DEFAULT TRUE,
    dibuat_oleh INT,
    dibuat_pada DATETIME DEFAULT CURRENT_TIMESTAMP,
    diupdate_pada DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (dibuat_oleh) REFERENCES pegawai(id_pegawai),
    INDEX idx_nama_pelanggan (nama_lengkap),
    INDEX idx_telepon_pelanggan (telepon)
);

CREATE TABLE IF NOT EXISTS penjualan (
    id_penjualan INT PRIMARY KEY AUTO_INCREMENT,
    nomor_transaksi VARCHAR(20) UNIQUE NOT NULL,
    id_mobil INT,
    id_pelanggan INT,
    id_pegawai INT,
    tanggal_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    harga_jual DECIMAL(15,2) NOT NULL,
    metode_pembayaran ENUM('tunai', 'kredit', 'transfer') NOT NULL,
    status_pembayaran ENUM('pending', 'sebagian', 'lunas') DEFAULT 'pending',
    status_pengiriman ENUM('pending', 'proses', 'selesai') DEFAULT 'pending',
    catatan TEXT,
    dibuat_pada DATETIME DEFAULT CURRENT_TIMESTAMP,
    diupdate_pada DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_mobil) REFERENCES mobil(id_mobil),
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan),
    FOREIGN KEY (id_pegawai) REFERENCES pegawai(id_pegawai),
    INDEX idx_tanggal_transaksi (tanggal_transaksi),
    INDEX idx_status_pembayaran (status_pembayaran)
);

COMMIT;
