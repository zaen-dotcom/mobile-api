<?php
header("Content-Type: application/json");

error_reporting(E_ALL);
ini_set('display_errors', 1);

require 'config.php';

// Mendapatkan data JSON dari request body
$data = json_decode(file_get_contents("php://input"));
error_log(print_r($data, true)); // Log data yang diterima

// Inisialisasi respon
$response = array("status" => false, "message" => "Email dan password harus diisi");

// Validasi input JSON
if (json_last_error() !== JSON_ERROR_NONE) {
    $response["message"] = "Format JSON tidak valid: " . json_last_error_msg();
    echo json_encode($response);
    exit();
}

if (isset($data->email) && isset($data->password)) {
    $email = trim($data->email);
    $password = trim($data->password);
    $password_hashed = sha1($password); // Hash password dengan sha1

    // Query untuk memeriksa user di tabel tb_siswa, tb_guru, dan tb_admin dengan join untuk nama_kelas
    $sql = "
        SELECT admin_id AS user_id, nama, email, 'admin' AS role, NULL AS kelas_mapel, NULL AS nisn_nipd 
        FROM tb_admin 
        WHERE email = ? AND password = ?
        UNION
        SELECT 
            siswa_id AS user_id, 
            tb_siswa.nama, 
            tb_siswa.email, 
            'siswa' AS role, 
            tb_kelas.nama_kelas AS kelas_mapel, 
            tb_siswa.NISN AS nisn_nipd 
        FROM tb_siswa 
        LEFT JOIN tb_kelas ON tb_siswa.kelas_id = tb_kelas.kelas_id 
        WHERE tb_siswa.email = ? AND tb_siswa.password = ?
        UNION
        SELECT 
            guru_id AS user_id, 
            nama, 
            email, 
            'guru' AS role, 
            jabatan AS kelas_mapel, 
            NIP AS nisn_nipd 
        FROM tb_guru 
        WHERE email = ? AND password = ?;
    ";

    $stmt = $conn->prepare($sql);
    if ($stmt) {
        $stmt->bind_param("ssssss", $email, $password_hashed, $email, $password_hashed, $email, $password_hashed);
        $stmt->execute();
        $res = $stmt->get_result();

        if ($res->num_rows > 0) {
            $user = $res->fetch_assoc();

            $response = array(
                "status" => true,
                "message" => "Login berhasil",
                "role" => $user['role'],
                "user" => array(
                    "id" => (int)$user['user_id'],
                    "nama" => $user['nama'],
                    "email" => $user['email'],
                    "kelas_mapel" => $user['kelas_mapel'], // nama_kelas untuk siswa atau jabatan untuk guru
                    "nisn_nipd" => $user['nisn_nipd'] // NISN untuk siswa atau NIP untuk guru
                )
            );
        } else {
            $response["message"] = "User tidak ditemukan atau password salah";
        }

        // Menutup statement
        $stmt->close();
    } else {
        $response["message"] = "Kesalahan dalam query: " . $conn->error;
    }
} else {
    $response["message"] = "Email dan password tidak boleh kosong.";
}

// Menutup koneksi
$conn->close();

// Mengirimkan hasil dalam format JSON
echo json_encode($response);
?>
