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

    // Query untuk memeriksa user di tabel tb_admin, tb_siswa, tb_guru
    $sql = "
        SELECT admin_id AS user_id, nama, email, password, 'admin' AS role FROM tb_admin WHERE email = ? AND password = ?
        UNION
        SELECT siswa_id AS user_id, nama, email, password, 'siswa' AS role FROM tb_siswa WHERE email = ? AND password = ?
        UNION
        SELECT guru_id AS user_id, nama, email, password, 'guru' AS role FROM tb_guru WHERE email = ? AND password = ?;
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
                    "email" => $user['email']
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
