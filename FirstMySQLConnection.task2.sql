CREATE PROCEDURE sp_tambah_mobil(
    IN p_id_merek INT,
    IN p_id_tipe INT,
    IN p_nama_model VARCHAR(100),
    IN p_varian VARCHAR(50),
    IN p_tahun_produksi INT,
    IN p_warna VARCHAR(30),
    IN p_transmisi VARCHAR(20),
    IN p_jenis_bahan_bakar VARCHAR(20),
    IN p_kapasitas_mesin INT,
    IN p_nomor_polisi VARCHAR(20),
    IN p_nomor_rangka VARCHAR(50),
    IN p_nomor_mesin VARCHAR(50),
    IN p_harga DECIMAL(15,2),
    IN p_stok INT,
    IN p_dibuat_oleh INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Terjadi kesalahan saat menambah mobil baru';
    END;

    START TRANSACTION;
    
    INSERT INTO mobil (
        id_merek, id_tipe, nama_model, varian, tahun_produksi,
        warna, transmisi, jenis_bahan_bakar, kapasitas_mesin,
        nomor_polisi, nomor_rangka, nomor_mesin,
        harga_sekarang, stok, dibuat_oleh
    ) VALUES (
        p_id_merek, p_id_tipe, p_nama_model, p_varian, p_tahun_produksi,
        p_warna, p_transmisi, p_jenis_bahan_bakar, p_kapasitas_mesin,
        p_nomor_polisi, p_nomor_rangka, p_nomor_mesin,
        p_harga, p_stok, p_dibuat_oleh
    );

    COMMIT;
END